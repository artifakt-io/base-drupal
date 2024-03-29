#!/bin/bash
set -e

echo ">>>>>>>>>>>>>> START CUSTOM ENTRYPOINT SCRIPT <<<<<<<<<<<<<<<<< "

composer show

mkdir -p /opt/drupal/sites/default/files

su --preserve-environment www-data -s /bin/bash -c 'env && /opt/drupal/vendor/bin/drush site:install standard si --no-interaction --account-pass=password123 --db-url=mysql://$ARTIFAKT_MYSQL_USER:$ARTIFAKT_MYSQL_PASSWORD@$ARTIFAKT_MYSQL_HOST:$ARTIFAKT_MYSQL_PORT/$ARTIFAKT_MYSQL_DATABASE_NAME'

chown -R www-data:www-data /opt/drupal/sites

echo ">>>>>>>>>>>>>> END CUSTOM ENTRYPOINT SCRIPT <<<<<<<<<<<<<<<<< "
