FROM php:8.1

RUN apt-get update -yqq

RUN apt-get install unzip wget gnupg optipng pngquant gifsicle webp git libzip-dev libcurl4-gnutls-dev \
    libicu-dev libmcrypt-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev \
    libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libpq-dev libsqlite3-dev \
    libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev libonig-dev libmagickwand-dev libmagickcore-dev libgd-dev -yqq

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-install -j$(nproc) mbstring pdo_mysql pdo_pgsql curl xml zip exif gd

RUN pecl install xdebug imagick swoole redis uuid
RUN docker-php-ext-enable xdebug imagick swoole redis uuid

RUN curl --silent --show-error "https://getcomposer.org/installer" | php -- --install-dir=/usr/local/bin --filename=composer

RUN cd /usr/local/etc/php/conf.d/ && \
    echo "memory_limit = -1" >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini
