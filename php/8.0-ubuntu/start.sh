#!/usr/bin/env bash

if [ ! -z "$APPUSER" ]; then
    usermod -u $APPUSER $APPUSER
fi

if [ ! -d /.composer ]; then
    mkdir /.composer
fi

chmod -R ugo+rw /.composer

if [ $# -gt 0 ];then
    exec gosu $APPUSER "$@"
else
    /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
fi
