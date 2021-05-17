#!/bin/bash

set -e

echo ">>>>>>>>>>>>>> START CUSTOM BUILD SCRIPT <<<<<<<<<<<<<<<<< "

echo "------------------------------------------------------------"
echo "The following build args are available:"
env
echo "------------------------------------------------------------"

# NO SCRIPTS, it breaks the build
# see https://stackoverflow.com/a/61349991/1093649
composer --no-ansi --no-interaction install --no-cache --no-progress  --no-autoloader --no-scripts --no-dev

# install drush CLI as an additional package
composer require --no-cache --update-no-dev --prefer-dist --no-ansi --no-interaction drush/drush && \
composer dump-autoload

apt-get update && apt-get install -y --no-install-recommends gnupg

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install --no-install-recommends -y nodejs yarn \
    && rm -rf /var/lib/apt/lists/*

chown -R www-data:www-data /var/www/html/

echo ">>>>>>>>>>>>>> END CUSTOM BUILD SCRIPT <<<<<<<<<<<<<<<<< "
