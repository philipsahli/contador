#!/bin/bash
export SYSTEM_ENV=dev
export SYSTEM_INSTANCE=demo-stao
export SERVICE_HOST=${HOSTNAME}
export SERVICE_PORT=3000
export SERVICE_INSTANCE=${USER}-local
export METRIC_HOST=localhost
export METRIC_PORT=2003

exec node index.js