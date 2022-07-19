#!/bin/bash

# How to use?
# ./build.sh <container_name> <port>
# ex: ./build-test.sh apps 9090

# Parameter
NAME=${1:-"k6"}
PORT=${2:-"8080"}

# Remove and build container base images
docker rm -f $(docker ps -a | grep $NAME | awk '{print $1}') 2>/dev/null
docker rmi $NAME 2>/dev/null
docker build . -t $NAME
docker run -itd -v ${PWD}/script:/tools --name $NAME $NAME
docker exec -it -u root $NAME bash 
