FROM alpine:3.4
MAINTAINER helpdeskgroup helpdeskgroup@helpme.net

RUN apk update && \
    apk upgrade && \
	apk add --no-cache varnish=4.1.9-r0

ENV TERM xterm
ENV VARNISH_VCL_CONFIG /etc/varnish/default.vcl
ENV VARNISH_STORAGE="malloc,1G"
ENV VARNISH_DAEMON_OPTS="-p thread_pool_min=5 -p thread_pool_max=500 -p thread_pool_timeout=300 -p default_ttl=3600 -p default_grace=3600"
ENV VARNISH_NCSA_FORMAT %{X-Client-IP}i %l %u %t "%r" %s %b "%{Referer}i" "%{User-agent}i"

EXPOSE 80

VOLUME ["/var/log/varnish"]
