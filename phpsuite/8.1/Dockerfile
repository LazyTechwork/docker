FROM php:8.1-fpm-bullseye

LABEL maintainer="Ivan R. Petrov"

ENV TZ "Europe/Moscow"

RUN addgroup --gid 1000 app \
    && adduser --uid 1000 --gid 1000 app

RUN apt-get update -y

RUN apt-get install -y \
    libzip-dev libicu-dev libmcrypt-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev \
    libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev \
    libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev libonig-dev libmagickwand-dev libmagickcore-dev libgd-dev \
    libjpeg62-turbo-dev libcurl4-openssl-dev nginx supervisor libpq-dev

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) gd

RUN pecl install redis \
	&& pecl install xdebug \
	&& docker-php-ext-enable redis xdebug

RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install curl
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install dom
RUN docker-php-ext-install zip
RUN docker-php-ext-install xml
RUN docker-php-ext-install opcache
RUN docker-php-ext-install exif

RUN cd /usr/local/etc/php/conf.d/ && \
    echo "memory_limit = -1" >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini

RUN apt-get clean

RUN rm -rf /etc/nginx/sites-available/*
RUN rm -rf /etc/nginx/sites-enabled/*

COPY php.ini /etc/php/8.1/fpm/conf.d/99-application.ini
COPY xdebug.ini /etc/php/8.1/fpm/conf.d/99-xdebug.ini
COPY fpm-pool.ini /etc/php/8.1/fpm/pool.d/www.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-app.conf /etc/nginx/conf.d/app.conf
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY supervisor-nginx.conf /etc/supervisor/conf.d/supervisor-nginx.conf
COPY supervisor-php-fpm.conf /etc/supervisor/conf.d/supervisor-php-fpm.conf
COPY supervisor-npm.conf /etc/supervisor/conf.d/supervisor-npm.conf
COPY container-start.sh /usr/local/bin/container-start

RUN nginx -t

RUN chmod +x /usr/local/bin/container-start

EXPOSE 80
EXPOSE 9003
WORKDIR /var/www/app
ENTRYPOINT ["su","-","root","-c","container-start"]
