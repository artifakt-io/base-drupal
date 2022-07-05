#!/bin/bash
set -e

echo ">>>>>>>>>>>>>> START CUSTOM ENTRYPOINT SCRIPT <<<<<<<<<<<<<<<<< "

composer show

echo "current dir:"
pwd

cd /opt/drupal

mkdir -p sites/default/files

ls -la sites/
ls -la sites/default/
ls -la sites/default/files

chown -R www-data:www-data /opt/drupal/sites


echo ">>>>>>>>>>>>>> END CUSTOM ENTRYPOINT SCRIPT <<<<<<<<<<<<<<<<< "
