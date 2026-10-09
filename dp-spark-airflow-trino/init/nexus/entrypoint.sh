#!/bin/sh
set -e

ADMIN_PASS="${NEXUS_ADMIN_PASSWORD:-admin123}"
PASSWORD_FILE="/nexus-data/admin.password"
NEXUS_URL="http://nexus:8081"

# pre-seed password file on very first boot
if [ ! -f "${PASSWORD_FILE}" ] && [ ! -f "/nexus-data/.setup-complete" ]; then
  mkdir -p /nexus-data
  echo -n "${ADMIN_PASS}" > "${PASSWORD_FILE}"
  chown -R nexus:nexus /nexus-data
fi

/opt/sonatype/nexus/bin/nexus run &
NEXUS_PID=$!

echo "Waiting for Nexus to be writable..."
until curl -sf -u "admin:${ADMIN_PASS}" \
    "${NEXUS_URL}/service/rest/v1/status/writable" > /dev/null 2>&1; do
  sleep 5
done
echo "Nexus is up."

# only run setup once
if [ ! -f "/nexus-data/.setup-complete" ]; then

  # explicitly change password via API — this is what marks onboarding done
  curl -sf \
    -u "admin:${ADMIN_PASS}" \
    -X PUT "${NEXUS_URL}/service/rest/v1/security/users/admin/change-password" \
    -H "Content-Type: text/plain" \
    -d "${ADMIN_PASS}"
  echo "Password set via API."

  # remove the seed file
  rm -f "${PASSWORD_FILE}"

  # enable anonymous access
  curl -sf \
    -u "admin:${ADMIN_PASS}" \
    -X PUT "${NEXUS_URL}/service/rest/v1/security/anonymous" \
    -H "Content-Type: application/json" \
    -d '{"enabled": true,"userId":"anonymous","realmName":"NexusAuthorizingRealm"}' || true

  curl -sf -o /dev/null \
    -u "admin:${ADMIN_PASS}" \
    -X POST "${NEXUS_URL}/service/rest/v1/repositories/pypi/proxy" \
    -H "Content-Type: application/json" \
    -d @/nexus-init/pypi-proxy.json || true

  # create PyPI proxy repo
  curl -sf -o /dev/null \
    -u "admin:${ADMIN_PASS}" \
    -X POST "${NEXUS_URL}/service/rest/v1/repositories/docker/proxy" \
    -H "Content-Type: application/json" \
    -d @/nexus-init/docker-proxy.json || true    

  # configure outbound HTTP proxy (only if HTTP_PROXY is set)
  if [ -n "${HTTP_PROXY}" ]; then
    PROXY_HOST=$(echo "${HTTP_PROXY}" | sed 's|https\?://||' | cut -d: -f1)
    PROXY_PORT=$(echo "${HTTP_PROXY}" | sed 's|https\?://||' | cut -d: -f2 | cut -d/ -f1)
    PROXY_PORT=${PROXY_PORT:-3128}

    NON_PROXY_HOSTS=$(echo "${NO_PROXY:-localhost}" | tr ',' '\n' | awk 'BEGIN{printf "["} NR>1{printf ","} {printf "\"%s\"",$0} END{printf "]"}')

    curl -sf \
      -u "admin:${ADMIN_PASS}" \
      -X PUT "${NEXUS_URL}/service/rest/v1/http" \
      -H "Content-Type: application/json" \
      -d "{
        \"userAgent\": \"\",
        \"timeout\": 20,
        \"retries\": 2,
        \"httpProxy\": {
          \"enabled\": true,
          \"host\": \"${PROXY_HOST}\",
          \"port\": ${PROXY_PORT}
        },
        \"httpsProxy\": {
          \"enabled\": true,        
          \"host\": \"${PROXY_HOST}\",
          \"port\": ${PROXY_PORT}
        },
        \"nonProxyHosts\": ${NON_PROXY_HOSTS}
      }" || true
    echo "HTTP proxy configured: ${PROXY_HOST}:${PROXY_PORT}"
  fi

  # Retrieve licence data and update acceptance
  EULA_FILE="$(mktemp)_EULA.json"
  curl -s -X GET -u "admin:${ADMIN_PASS}"  -H "accept: application/json" "$NEXUS_URL/service/rest/v1/system/eula" | sed 's/: false/: true/g' > $EULA_FILE
  # Send back acceptance
  curl -v -s -X POST -u "admin:${ADMIN_PASS}" -H "Content-Type: application/json; charset=UTF-8" -d "$(cat $EULA_FILE | sed 's/\n//g')" "$NEXUS_URL/service/rest/v1/system/eula"

  # mark setup as done so restarts skip this block
  touch /tmp/.setup-complete
  echo "Setup complete."

fi

wait $NEXUS_PID