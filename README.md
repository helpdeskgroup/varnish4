Varnish Docker container
Alpine 3.4
Varnish 4.1.9-r0
This docker container uses supervisord as its root process which allows both varnish and varnishnsa processes to run within the same container. There is a volume mount at /var/log/varnish which is used by varnishncsa to write its log files.

Usage
To use this container, you will need to provide a varnish configuration file default.vcl.

docker run -d \
  --link web-app:backend-host \
  --volumes-from web-app \
  --env 'VARNISH_VCL_CONFIG=/data/varnish/varnish.vcl' \
  helpdeskgroup/varnish
In the above example we assume that:

You have your application running inside web-app container and web server there is running on port 80 (although you don't need to expose that port, as we use --link and varnish will connect directly to it)
web-app container has /etc volume with varnish.vcl somewhere there
web-app is aliased inside varnish container as backend-host
Your varnish.vcl should contain at least backend definition like this:
backend default {
  .host = "backend-host";
  .port = "80";
}
Environmental variables
You can configure Varnish daemon by following env variables:

* VARNISH_VCL_CONFIG /etc/varnish/default.vcl
* VARNISH_STORAGE="malloc,1G"
* VARNISH_DAEMON_OPTS="-p thread_pool_min=5 -p thread_pool_max=500 -p thread_pool_timeout=300 -p default_ttl=3600 -p default_grace=3600"
* VARNISH_NCSA_FORMAT %{X-Client-IP}i %l %u %t "%r" %s %b "%{Referer}i" "%{User-agent}i"
