#!/bin/bash

ARG=$1
COMPOSE_FILE=${2:-"../compose/golang-app.yaml"}

if [[ $ARG == "start" ]]; then
  docker-compose -f ${COMPOSE_FILE} up -d
fi

if [[ $ARG == "recreate" ]]; then
  docker-compose -f ${COMPOSE_FILE} up -d --force-recreate
fi

if [[ $ARG == "kill" ]]; then
  docker-compose -f ${COMPOSE_FILE} down --rmi all
fi
