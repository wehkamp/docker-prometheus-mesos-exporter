FROM wehkamp/alpine:3.4

EXPOSE 9105
ENTRYPOINT ["mesos_exporter"]

ENV GOPATH /gopath
ENV APPPATH $GOPATH/src/
ENV _VERSION 1.0-rc1

RUN LAYER=build \
    && apk add --update -t build-deps openssl git make go git mercurial libc-dev gcc libgcc \
    && mkdir -p /gopath/src/github.com/mesosphere \
    && cd /gopath/src/github.com/mesosphere \
    && git clone https://github.com/mesosphere/mesos_exporter \
    && cd /gopath/src/github.com/mesosphere/mesos_exporter \
    && git checkout v${_VERSION} \
    && go get -d \
    && go build \
    && mv mesos_exporter /bin \
    && apk del --purge build-deps \
    && rm -rf $GOPATH

LABEL container.name="wehkamp/prometheus-mesos-exporter:1.0-rc1"
