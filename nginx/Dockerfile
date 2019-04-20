FROM debian

RUN apt-get update \
    && apt-get install --assume-yes --no-install-recommends \
        ca-certificates \
        nginx \
    && rm -rf /var/lib/apt/lists/*

RUN /etc/init.d/nginx stop

VOLUME /etc/nginx/sites-enabled
VOLUME /etc/nginx/conf.d
VOLUME /var/www/html

WORKDIR /etc/nginx

EXPOSE 80
EXPOSE 443

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
