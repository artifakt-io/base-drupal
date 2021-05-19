#!/bin/bash
set -e

echo ">>>>>>>>>>>>>> START CUSTOM ENTRYPOINT SCRIPT <<<<<<<<<<<<<<<<< "

# set drupal env. vars on the fly
export DRUPAL_DATABASE_NAME=${ARTIFAKT_MYSQL_DATABASE_NAME:-changeme}
export DRUPAL_DATABASE_USERNAME=${ARTIFAKT_MYSQL_USER:-changeme}
export DRUPAL_DATABASE_PASSWORD=${ARTIFAKT_MYSQL_PASSWORD:-changeme}
export DRUPAL_DATABASE_HOST=${ARTIFAKT_MYSQL_HOST:-mysql}
export DRUPAL_DATABASE_PORT=${ARTIFAKT_MYSQL_PORT:-3306}

# debug env vars.
env

if [[ ! -f /data/sites/default/default.settings.php ]]; then
  mkdir -p /data/sites/default
  cp /.artifakt/default.settings.php /data/sites/default/default.settings.php
  ls -la /data/sites/default
fi

echo ">>>>>>>>>>>>>> END CUSTOM ENTRYPOINT SCRIPT <<<<<<<<<<<<<<<<< "
