FROM golang:latest AS builder

# Download and install the latest release of dep
ADD https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64 /usr/bin/dep
RUN chmod +x /usr/bin/dep

# Copy the code from the host and compile it
WORKDIR $GOPATH/src/github.com/philipsahli/gontador/
COPY Gopkg.toml Gopkg.lock ./
RUN dep ensure --vendor-only
COPY . ./
RUN GOCACHE=/var/go CGO_ENABLED=0 GOOS=linux go build -a -installsuffix nocgo -o /app github.com/philipsahli/gontador/src

EXPOSE 3000

FROM scratch
COPY --from=builder /app ./
ENTRYPOINT ["./app"]
