#!/bin/bash

set -e

echo ">>>>>>>>>>>>>> START CUSTOM BUILD SCRIPT <<<<<<<<<<<<<<<<< "

echo 'variables_order = "EGPCS"' >> /usr/local/etc/php/conf.d/zzz-artifakt.ini

composer show

if [[ ! -d /opt/drupal/config ]]; then
 mkdir -p /data/config
 ln -snf /data/config /opt/drupal/config
 chown -R www-data:www-data /data/config
fi

ls -la /data

echo ">>>>>>>>>>>>>> END CUSTOM BUILD SCRIPT <<<<<<<<<<<<<<<<< "
