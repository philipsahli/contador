#!/bin/bash
export SYSTEM_ENV=dev
export SYSTEM_INSTANCE=demo-stao
export SERVICE_HOST=${HOSTNAME}
export SERVICE_PORT=3000
export SERVICE_INSTANCE=${USER}-local

exec node index.js