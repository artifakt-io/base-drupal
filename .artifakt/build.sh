#!/bin/bash

set -e

echo ">>>>>>>>>>>>>> START CUSTOM BUILD SCRIPT <<<<<<<<<<<<<<<<< "

echo "------------------------------------------------------------"
echo "The following build args are available:"
env
echo "------------------------------------------------------------"

echo 'variables_order = "EGPCS"' >> /usr/local/etc/php/conf.d/zzz-artifakt.ini

# NO SCRIPTS, it breaks the build
# see https://stackoverflow.com/a/61349991/1093649
#composer --no-ansi --no-interaction install --no-cache --no-progress  --no-autoloader --no-scripts --no-dev

cd /opt/drupal && ls -la

composer show

apt-get update && apt-get install -y --no-install-recommends gnupg

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install --no-install-recommends -y nodejs yarn \
    && rm -rf /var/lib/apt/lists/*

# if [[ ! -f /data/sites/default/default.settings.php ]]; then
#  mkdir -p /data/sites/default
#  cp /.artifakt/default.settings.php /data/sites/default/default.settings.php
#  ls -la /data/sites/default
# fi

if [[ ! -d /opt/drupal/config ]]; then
 mkdir -p /data/config
 ln -snf /data/config /opt/drupal/config
 chown -R www-data:www-data /data/config
fi

#chown www-data:www-data /var/www/html/

echo ">>>>>>>>>>>>>> END CUSTOM BUILD SCRIPT <<<<<<<<<<<<<<<<< "
