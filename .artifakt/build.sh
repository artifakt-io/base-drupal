#!/bin/bash

set -e

echo ">>>>>>>>>>>>>> START CUSTOM BUILD SCRIPT <<<<<<<<<<<<<<<<< "

echo 'variables_order = "EGPCS"' >> /usr/local/etc/php/conf.d/zzz-artifakt.ini

composer require drush/drush

composer show

chown -R www-data:www-data /opt/drupal/vendor

if [[ ! -d /opt/drupal/config ]]; then
 mkdir -p /data/config
 ln -snf /data/config /opt/drupal/config
 chown -R www-data:www-data /data/config
fi

ls -la /data

echo ">>>>>>>>>>>>>> END CUSTOM BUILD SCRIPT <<<<<<<<<<<<<<<<< "
