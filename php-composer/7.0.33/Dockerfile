FROM 00f100/php-fpm-zts:7.0.33

ARG UID
ARG GID

RUN apt-get update

RUN apt-get install --assume-yes --no-install-recommends \
    git \
    zip

RUN mv /opt/php-7.0/lib/php.ini /opt/php-7.0/lib/php.ini.default

RUN sed 's/memory_limit = 128M/memory_limit = -1/g' \
    /opt/php-7.0/lib/php.ini.default \
    > /opt/php-7.0/lib/php.ini

ENV COMPOSER_HOME /opt/composer

RUN mkdir -p /opt/composer/bin \
    && cd /opt/composer \
    && php -r "copy('http://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && mv composer.phar /opt/composer/bin/composer \
    && chmod +x /opt/composer/bin/composer \
    && mkdir /opt/composer/.composer \
    && chown -R "$UID:$GID" /opt/composer/

ENV PATH "/opt/composer/bin:$PATH"

RUN mkdir /source \
    && chown "$UID:$GID" /source

RUN rm -Rf /var/lib/apt/lists \
    && rm -Rf /var/cache/apt \
    && rm -Rf /tmp

VOLUME /opt/composer/.composer
VOLUME /source

WORKDIR /source

CMD ["-"]

ENTRYPOINT ["composer", "--ansi"]