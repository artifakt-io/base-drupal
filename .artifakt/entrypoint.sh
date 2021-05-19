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

echo ">>>>>>>>>>>>>> END CUSTOM ENTRYPOINT SCRIPT <<<<<<<<<<<<<<<<< "
