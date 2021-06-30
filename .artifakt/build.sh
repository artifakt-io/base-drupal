#!/bin/bash

set -e

echo ">>>>>>>>>>>>>> START CUSTOM BUILD SCRIPT <<<<<<<<<<<<<<<<< "

echo "------------------------------------------------------------"
echo "The following build args are available:"
env
echo "------------------------------------------------------------"

echo 'variables_order = "EGPCS"' >> /usr/local/etc/php/conf.d/zzz-artifakt.ini

composer show

if [[ ! -d /opt/drupal/config ]]; then
 mkdir -p /data/config
 ln -snf /data/config /opt/drupal/config
 chown -R www-data:www-data /data/config
fi

echo ">>>>>>>>>>>>>> END CUSTOM BUILD SCRIPT <<<<<<<<<<<<<<<<< "
