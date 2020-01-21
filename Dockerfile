FROM consul:1.6.2
FROM golang:1.12-alpine
ENV GOPATH /go

RUN git clone github.com/uchiru/consul-alerts#E42-102_serviceTags && echo $(grep -nr ServiceTags consul-alerts)

RUN mkdir -p /go && \
    apk update && \
    apk add bash ca-certificates git curl && \
    GO111MODULE="off" go get -v github.com/uchiru/consul-alerts@E42-102_serviceTags && \
    mv /go/bin/consul-alerts /bin

FROM alpine:3.8

COPY --from=0 /bin/consul /bin
COPY --from=1 /bin/consul-alerts /bin
RUN apk add --no-cache ca-certificates curl

EXPOSE 9000
CMD []
ENTRYPOINT []
