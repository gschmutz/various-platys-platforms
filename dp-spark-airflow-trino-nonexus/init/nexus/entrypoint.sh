#!/bin/sh
set -e

ADMIN_PASS="${NEXUS_ADMIN_PASSWORD:-admin123}"
PASSWORD_FILE="/nexus-data/admin.password"
NEXUS_URL="http://localhost:8081"

# ensure curl never routes Nexus API calls through an outbound proxy
NO_PROXY="${NO_PROXY},localhost,127.0.0.1"
no_proxy="${no_proxy},localhost,127.0.0.1"
export NO_PROXY no_proxy

# pre-seed password file on very first boot
if [ ! -f "${PASSWORD_FILE}" ] && [ ! -f "/nexus-data/.setup-complete" ]; then
  mkdir -p /nexus-data
  echo -n "${ADMIN_PASS}" > "${PASSWORD_FILE}"
  chown -R nexus:nexus /nexus-data 2>/dev/null || true
fi

mkdir -p /nexus-data/etc
if [ -n "${HTTP_PROXY}" ]; then
  PROXY_HOST=$(echo "${HTTP_PROXY}" | sed 's|https\?://||' | cut -d: -f1)
  PROXY_PORT=$(echo "${HTTP_PROXY}" | sed 's|https\?://||' | cut -d: -f2 | tr -d '/')
  cat > /nexus-data/etc/nexus.properties << EOF
nexus.httpclient.proxy.http.enabled=true
nexus.httpclient.proxy.http.host=${PROXY_HOST}
nexus.httpclient.proxy.http.port=${PROXY_PORT}
nexus.httpclient.proxy.https.enabled=true
nexus.httpclient.proxy.https.host=${PROXY_HOST}
nexus.httpclient.proxy.https.port=${PROXY_PORT}
nexus.httpclient.proxy.http.nonProxyHosts=localhost|127.0.0.1|10.89.*
EOF
fi

/opt/sonatype/nexus/bin/nexus run &
NEXUS_PID=$!

echo "Waiting for Nexus to be writable..."
until curl -sf -u "admin:${ADMIN_PASS}" \
    "${NEXUS_URL}/service/rest/v1/status/writable" > /dev/null 2>&1; do
  STATUS=$(curl -s -o /dev/null -w "%{http_code}" -u "admin:${ADMIN_PASS}" "${NEXUS_URL}/service/rest/v1/status/writable" 2>&1 || echo "no-response")
  echo "  still waiting... HTTP=${STATUS}, nexus pid=${NEXUS_PID} alive=$(kill -0 ${NEXUS_PID} 2>/dev/null && echo yes || echo NO)"
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

  # import PEM certificates into the Nexus truststore
  CERT_DIR="${NEXUS_CERT_DIR:-/nexus-init/certs}"
  if [ -d "${CERT_DIR}" ]; then
    for pem in "${CERT_DIR}"/*.pem; do
      [ -f "$pem" ] || continue
      echo "Importing certificate: $pem"
      curl -sf -o /dev/null \
        -u "admin:${ADMIN_PASS}" \
        -X POST "${NEXUS_URL}/service/rest/v1/security/ssl/truststore" \
        -H "Content-Type: text/plain" \
        --data-binary @"${pem}" || echo "  WARNING: failed to import $pem (may already exist)"
    done
  fi

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

  # enable useTrustStore on pre-configured repos (e.g. maven-central)
  for repo in maven-central; do
    echo "Patching useTrustStore on repo: $repo"
    REPO_JSON=$(curl -sf \
      -u "admin:${ADMIN_PASS}" \
      -H "Accept: application/json" \
      "${NEXUS_URL}/service/rest/v1/repositories/${repo}" 2>/dev/null) || { echo "  WARNING: could not fetch $repo config"; continue; }
    PATCHED=$(printf '%s' "$REPO_JSON" | sed 's/"useTrustStore"\s*:\s*false/"useTrustStore": true/g')
    # inject useTrustStore if not present at all
    if ! printf '%s' "$PATCHED" | grep -q '"useTrustStore"'; then
      PATCHED=$(printf '%s' "$PATCHED" | sed 's/"proxy"\s*:\s*{/"proxy": { "useTrustStore": true,/g')
    fi
    curl -sf -o /dev/null \
      -u "admin:${ADMIN_PASS}" \
      -X PUT "${NEXUS_URL}/service/rest/v1/repositories/maven/proxy/${repo}" \
      -H "Content-Type: application/json" \
      -d "$PATCHED" || echo "  WARNING: failed to patch $repo"
    echo "  Done."
  done

  # Retrieve licence data and update acceptance
  EULA_FILE="$(mktemp)_EULA.json"
  curl -s -u "admin:${ADMIN_PASS}" -H "accept: application/json" "$NEXUS_URL/service/rest/v1/system/eula" | sed 's/: false/: true/g' > "$EULA_FILE"
  # Send back acceptance
  curl -s -u "admin:${ADMIN_PASS}" -H "Content-Type: application/json; charset=UTF-8" -d "$(cat "$EULA_FILE")" "$NEXUS_URL/service/rest/v1/system/eula" || true

  # mark setup as done so restarts skip this block
  touch /nexus-data/.setup-complete
  echo "Setup complete."

fi

wait $NEXUS_PID