FROM ubuntu:20.04

LABEL maintainer="Ivan R. Petrov"

WORKDIR /var/www/application

ENV APPUSER "application"
ENV DEBIAN_FRONTEND "noninteractive"
ENV TZ "Europe/Moscow"

RUN mkdir -p /var/www/application

RUN useradd -U -ms /bin/bash -u 1337 $APPUSER
RUN usermod -aG sudo $APPUSER
RUN chown $APPUSER:$APPUSER /var/www/application

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get install -y gnupg gosu curl ca-certificates zip unzip git supervisor libcap2-bin libpng-dev python2 nginx
RUN mkdir -p ~/.gnupg
RUN chmod 600 ~/.gnupg
RUN echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf
RUN apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E5267A6C
RUN apt-key adv --homedir ~/.gnupg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C300EE8C

RUN apt-get remove -y openssl

RUN apt-get install -y gcc wget make \
    && wget https://www.openssl.org/source/openssl-1.1.1h.tar.gz \
    && tar -xzvf openssl-1.1.1h.tar.gz \
    && cd openssl-1.1.1h \
    && ./config \
    && make install \
    && ln -sf /usr/local/ssl/bin/openssl 'which openssl'

RUN apt-get install -y openjdk-8-jre-headless ant ca-certificates-java
RUN update-ca-certificates -f

RUN apt-get -y autoremove
RUN apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME

RUN usermod -aG www-data $APPUSER
