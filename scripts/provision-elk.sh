#!/bin/bash

set -x

DOCKER_COMPOSE_WORKDIR="${HOME}/compose"
DOCKER_COMPOSE_SERVICES=("elasticsearch" "logstash" "kibana" "apm-server")
DOCKER_COMPOSE_FILE=${1:-"elastic-log-kibana.yaml"}

if [[ ! -f ${DOCKER_COMPOSE_WORKDIR}/${DOCKER_COMPOSE_FILE} ]]; then exit 1; fi

check_elk_status() {
  CONTAINER_STATUS=$(docker inspect --format='{{json .State.Health.Status}}' elk_${1}_1 2>/dev/null | tr -d '"' 2>/dev/null)
  if [[ ${CONTAINER_STATUS} == "healthy" ]]; then exit 1; fi
}

run_docker_compose() {
  cd ${DOCKER_COMPOSE_WORKDIR} 
  docker-compose -f ${1} up -d
}

for SERVICE in ${DOCKER_COMPOSE_SERVICES[@]}; do
  check_elk_status ${SERVICE}
done

run_docker_compose ${DOCKER_COMPOSE_FILE}
