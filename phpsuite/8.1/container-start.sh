#!/usr/bin/env bash

chown -R 1000:1000 /var/www/app
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
