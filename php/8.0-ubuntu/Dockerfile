FROM lazytechwork/nginx:ubuntu

LABEL maintainer="Ivan R. Petrov"

USER root

RUN echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu focal main" > /etc/apt/sources.list.d/ppa_ondrej_php.list
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get update
RUN apt-get install -y nodejs php8.0-cli php8.0-dev \
                   php8.0-pgsql php8.0-sqlite3 php8.0-gd \
                   php8.0-curl php8.0-memcached \
                   php8.0-imap php8.0-mysql php8.0-mbstring \
                   php8.0-xml php8.0-zip php8.0-bcmath php8.0-soap \
                   php8.0-intl php8.0-readline php8.0-uuid \
                   php8.0-msgpack php8.0-igbinary php8.0-ldap \
                   php8.0-redis php8.0-xml php8.0-fpm php8.0-xdebug

#RUN apt-get install -y php8.0-xdebug \
#   && echo "[XDebug]" > /etc/php/8.0/fpm/conf.d/99-xdebug.ini \
#   && echo "zend_extension="$(find /usr/lib/php/20200930/ -name xdebug.so)" >> /etc/php/8.0/fpm/conf.d/99-xdebug.ini" \
#   && echo "xdebug.mode = develop,debug,trace" >> /etc/php/8.0/fpm/conf.d/99-xdebug.ini \
#   && echo "xdebug.start_with_request = yes" >> /etc/php/8.0/fpm/conf.d/99-xdebug.ini \
#   && echo "xdebug.discover_client_host = true" >> /etc/php/8.0/fpm/conf.d/99-xdebug.ini \
#   && echo "xdebug.client_host = host.docker.internal" >> /etc/php/8.0/fpm/conf.d/99-xdebug.ini \
#   && echo "xdebug.client_port = 9003" >> /etc/php/8.0/fpm/conf.d/99-xdebug.ini

RUN apt-get clean

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

COPY phpconf.ini /etc/php/8.0/fpm/conf.d/99-application.ini
COPY xdebug.ini /etc/php/8.0/fpm/conf.d/99-xdebug.ini
COPY fpm-pool.ini /etc/php/8.0/fpm/pool.d/www.conf

RUN update-alternatives --set php /usr/bin/php8.0

RUN rm -rf /etc/nginx/sites-available/*
RUN rm -rf /etc/nginx/sites-enabled/*

COPY nginx-server.conf /etc/nginx/conf.d/application.conf
COPY nginx.conf /etc/nginx/nginx.conf

RUN nginx -t

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY nginx-php-supervisor.conf /etc/supervisor/conf.d/nginx-php-supervisor.conf
COPY start.sh /usr/local/bin/container-start
RUN chmod +x /usr/local/bin/container-start

EXPOSE 80
EXPOSE 9003

ENTRYPOINT ["su","-","root","-c","container-start"]
