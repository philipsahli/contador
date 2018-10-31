#!/bin/sh
docker build -t docker.pnet.ch/misc/contador .
docker push docker.pnet.ch/misc/contador:latest
if oc get dc | grep contador -q; then 
    oc import-image contador
else
    oc create -f template.yaml
    oc new-app --template=contador-template
    oc expose service/contador
fi