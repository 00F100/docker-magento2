FROM 00f100/php-fpm-zts:7.0.33

RUN rm -Rf /var/lib/apt/lists \
    && rm -Rf /var/cache/apt \
    && rm -Rf /tmp

RUN sed 's/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g' /opt/php-7.0/etc/php-fpm.d/www.conf.default \
    > /opt/php-7.0/etc/php-fpm.d/www.conf

EXPOSE 9000

CMD ["php-fpm", "-F"]