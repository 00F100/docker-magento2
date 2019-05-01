FROM debian

RUN apt-get update

RUN apt-get install --assume-yes --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        mcrypt \
        autoconf \
        libfcgi-dev \
        libfcgi0ldbl \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libssl-dev \
        libc-client2007e \
        libc-client2007e-dev \
        libxml2-dev \
        libbz2-dev \
        libcurl4-openssl-dev \
        libjpeg-dev \
        libpng-dev \
        libfreetype6-dev \
        libkrb5-dev \
        libpq-dev \
        libxml2-dev \
        libxslt1-dev

RUN ln -s /usr/lib/libc-client.a /usr/lib/x86_64-linux-gnu/libc-client.a

RUN cd /usr/include \
    && ln -s x86_64-linux-gnu/curl

RUN mkdir -p /opt/php-7.0 \
    && mkdir /usr/local/src/php7.0-build \
    && cd /usr/local/src/php7.0-build \
    && curl https://www.php.net/distributions/php-7.0.33.tar.bz2 \
         -o php-7.0.33.tar.bz2 \
    && tar jxf php-7.0.33.tar.bz2

RUN cd /usr/local/src/php7.0-build/php-7.0.33/ \
    && ./configure \
    --prefix=/opt/php-7.0 \
    --with-zlib-dir \
    --with-freetype-dir \
    --with-libxml-dir=/usr \
    --with-curl \
    --with-mcrypt \
    --with-zlib \
    --with-gd \
    --with-mhash \
    --with-pcre-regex \
    --with-pdo-mysql \
    --with-mysqli \
    --with-jpeg-dir=/usr \
    --with-png-dir=/usr \
    --with-openssl \
    --with-fpm-user=www-data \
    --with-fpm-group=www-data \
    --with-libdir=/lib/x86_64-linux-gnu \
    --with-gettext \
    --with-xmlrpc \
    --with-xsl \
    --enable-mbstring \
    --enable-soap \
    --enable-bcmath \
    --enable-zip \
    --enable-gd-native-ttf \
    --enable-opcache \
    --enable-fpm \
    --enable-intl \
    --enable-maintainer-zts \
    --disable-rpath \
    --without-sqlite3 \
    --without-pdo-sqlite \
    && make \
    && make install

RUN cp /usr/local/src/php7.0-build/php-7.0.33/php.ini-production /opt/php-7.0/lib/php/php.ini \
    && echo "extension=php_pthreads.so" >> /opt/php-7.0/lib/php/php.ini

RUN sed 's/\;pid = run\/php-fpm.pid/pid = run\/php-fpm.pid/g' \
    /opt/php-7.0/etc/php-fpm.conf.default \
    > /opt/php-7.0/etc/php-fpm.conf

RUN cp /opt/php-7.0/etc/php-fpm.d/www.conf.default /opt/php-7.0/etc/php-fpm.d/www.conf

ENV PATH "/opt/php-7.0/sbin:/opt/php-7.0/bin:$PATH"

RUN pecl install pthreads