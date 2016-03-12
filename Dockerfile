FROM        sdurrheimer/alpine-golang-make-onbuild
MAINTAINER  The Prometheus Authors <prometheus-developers@googlegroups.com>

LABEL       container.name=wehkamp/prometheus-mesos-exporter:1.0

EXPOSE      9105

ENTRYPOINT ["mesos_exporter"]
CMD ["-exporter.discover-interval=60s", "-exporter.interval=15s", "-exporter.scrape-mode=discover", "-exporter.url=http://mesos-master.service.consul:5050"]
