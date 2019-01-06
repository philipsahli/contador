#!/bin/bash -e

# get dependencies
dep ensure

# compile package and dependencies
go build src/main.go src/helper.go src/counter.go

# run it
export SYSTEM_ENV=dev
export SYSTEM_INSTANCE=demo-stao
export SERVICE_HOST=${HOSTNAME}
export SERVICE_PORT=3000
export SERVICE_INSTANCE=${USER}-local
export METRIC_HOST=localhost
export METRIC_PORT=2003

export REDIS_URL=192.168.1.2:6379
export REDIS_PASSWORD=6379

exec ./main
