# contador
A 12-factor counter microservice

## Services

### Telegraf

Run somewhere

    nc -l 2003

This is optional, used only if `METRIC_HOST` and `METRIC_PORT` is set.

### Redis

Run somewhere

     docker run --name gontador-redis -p 6379:6379 -d redis


## Test local

    go build -o gontador src/*.go 
    REDIS_URL=192.168.1.2:6379 METRIC_HOST=192.168.1.2 METRIC_PORT=2003 ./gontador

### HTTP Interface

    curl http://localhost:3000/counter

## Test on Openshift

    bash -xe deploy/deploy.sh

    URL=`oc get route.route.openshift.io/gontador  -o go-template --template={{.spec.host}}`

    curl -v $URL/counter

## Undeploy

    oc delete all -l app=gontador
    oc delete template gontador-template
