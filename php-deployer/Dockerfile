FROM php:8.1-cli-bullseye

RUN apt-get update -yqq
RUN apt-get install -y unzip wget gnupg libcurl4-openssl-dev libonig-dev libzip-dev libxml2-dev
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install mbstring curl xml zip
RUN curl --silent --show-error "https://getcomposer.org/installer" | php -- --install-dir=/usr/local/bin --filename=composer
RUN cd /usr/local/etc/php/conf.d/ && \
    echo "memory_limit = -1" >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH="${PATH}:/root/.composer/vendor/bin"

RUN composer global require deployer/deployer
