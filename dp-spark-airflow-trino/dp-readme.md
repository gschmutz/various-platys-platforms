# Data Platform on Platys

This platform runs using [Docker Compose](https://docs.docker.com/compose/). The `docker-compose.yml` and all necessary configuration files can be found in the GitHub repository:

[https://github.com/gschmutz/various-platys-platforms/tree/main/dp-spark-airflow-trino](https://github.com/gschmutz/various-platys-platforms/tree/main/dp-spark-airflow-trino)

You can start it using these commands:

## Running the Platform (if you want to run it on another machine)

```bash
export PUBLIC_IP=<public-ip-of-the-machine-running-docker>
export DOCKER_HOST_IP=<private-ip-of-the-machine-running-docker>

docker compose up -d
```

## Services

The services are listed here: <http://3.71.39.194/services-v2>

## Users and Passwords

| Application | User    | Password |
|-------------|---------|----------|
| Airflow     | airflow | abc123!  |
| Jupyter     | -       | abc123!  |
| RustFS      | admin   | abc123abc123! |

