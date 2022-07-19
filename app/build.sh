#!/bin/bash

docker build -t test .
docker rm -f test 2>/dev/null
docker run -itd -p 8000:8000 --name test test
watch docker logs test
