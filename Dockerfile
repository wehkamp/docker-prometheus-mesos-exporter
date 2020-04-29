FROM wehkamp/alpine:3.11-5

EXPOSE 9105
ENTRYPOINT ["mesos_exporter"]

ENV GOPATH /gopath
ENV APPPATH $GOPATH/src/

RUN LAYER=build \
    && apk add --update -t build-deps openssl git make go git mercurial libc-dev gcc libgcc \
    && mkdir -p /gopath/src/github.com/mesosphere \
    && cd /gopath/src/github.com/mesosphere \
    && git clone https://github.com/mesosphere/mesos_exporter \
    && cd /gopath/src/github.com/mesosphere/mesos_exporter \
    && go get -d \
    && go build \
    && mv mesos_exporter /bin \
    && apk del --purge build-deps \
    && rm -rf $GOPATH

LABEL container.name="wehkamp/prometheus-mesos-exporter:1.0-rc2"
