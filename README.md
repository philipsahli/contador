# contador

A 12-factor counter microservice

Exposes an HTTP-API and a gRPC Interface.

## Dependant services

**Telegraf**

Run somewhere a simple tcp listener to mock a telegraf daemon.

    nc -l 2003

**Redis**

Run somewhere a docker container with an unsecured redis daemon.

     docker run --name gontador-redis -p 6379:6379 -d redis


## Test local

    go build -o gontador src/*.go 
    REDIS_URL=192.168.1.2:6379 METRIC_HOST=192.168.1.2 METRIC_PORT=2003 ./gontador

### HTTP Interface

A HTTP/1.1 GET request to `/counter` increments the counter by 1 and returns the new counter.

    curl http://localhost:3000/counter

### gRPC Service

Gonsumidor increments the counter by 1 and prints out the counter every 2 seconds. Communication over gRPC to the service on port `3001`.

    git clone https://github.com/philipsahli/gonsumidor.git
    cd gonsumidor && go build -o gonsumidor main.go
    go build -o gonsumidor main.go

See https://github.com/philipsahli/gonsumidor/blob/master/README.md

## Test on Openshift

    bash -xe deploy/deploy.sh

    URL=`oc get route.route.openshift.io/gontador  -o go-template --template={{.spec.host}}`

    curl -v $URL/counter

## Undeploy

    oc delete all -l app=gontador
    oc delete template gontador-template

## Generate grpc service

     PROTOC_ZIP=protoc-3.3.0-osx-x86_64.zip\ncurl -OL https://github.com/google/protobuf/releases/download/v3.3.0/$PROTOC_ZIP\nsudo unzip -o $PROTOC_ZIP -d /usr/local bin/protoc\nrm -f $PROTOC_ZIP
     go get  -u github.com/golang/protobuf/protoc-gen-go

     protoc -I service/ service/gontador.proto --go_out=plugins=grpc:service

