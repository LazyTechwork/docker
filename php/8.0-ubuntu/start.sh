#!/usr/bin/env bash

if [ ! -z "$APPUSER" ]; then
  usermod -u 1337 "$APPUSER"
fi

if [ ! -d /.composer ]; then
  mkdir /.composer
fi

usermod -aG "$APPUSER" root
chmod -R ugo+rw /.composer
chown -R "$APPUSER":"$APPUSER" /var/www/application

if [ $# -gt 0 ]; then
  exec gosu "$APPUSER" "$@"
else
  /usr/bin/supervisord -c /etc/supervisor/supervisord.conf
fi
