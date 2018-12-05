#!/bin/sh
docker build -t docker.pnet.ch/misc/gontador .
docker push docker.pnet.ch/misc/gontador:latest
if oc get dc | grep gontador -q; then 
    oc import-image gontador
else
    oc create -f template.yaml
    oc new-app --template=gontador-template
    oc expose service/gontador
fi