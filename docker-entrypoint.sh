#!/bin/bash
set -e

if [ "$1" = 'apache' ]; then
   cd /var/www/html
   unzip /data/download.zip
   a2enmod headers

   grep -v "</VirtualHost>" /etc/apache2/sites-enabled/000-default.conf > /000-default.conf
   cat /var/www/html/templates/.htaccess >> /000-default.conf
   printf "\n</VirtualHost>" >> /000-default.conf
   cp /000-default.conf /etc/apache2/sites-enabled/000-default.conf

   /usr/sbin/apache2ctl -D FOREGROUND
fi

exec "$@"
