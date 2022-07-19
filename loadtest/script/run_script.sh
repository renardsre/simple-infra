#!/bin/bash

SCRIPT=${1:-"test.js"}

k6 run ${SCRIPT}
