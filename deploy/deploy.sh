#!/bin/bash -xe

# Build docker image in openshift
# oc apply -f imagestream.yaml

# Deploy app
oc create -f template.yaml
oc new-app --template=gontador-template  --name gontador
oc apply -f build.yaml
oc start-build gontador-build -n gontador

# Publish service
# oc apply -f service.yaml
oc apply -f route.yaml