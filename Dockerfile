FROM registry.artifakt.io/drupal:9.2-apache

ARG CODE_ROOT=.

COPY --chown=www-data:www-data $CODE_ROOT /opt/drupal/

WORKDIR /opt/drupal/

RUN [ -f composer.lock ] && composer install --no-cache --optimize-autoloader --no-interaction --no-ansi --no-dev || true

# PERSISTENT DATA FOLDERS
# FIXME: Uncommenting this will prevent the container from starting on Stack v5.
#        Root cause is that the line below will remove the /opt/drupal/web/sites at image _build_ time
#        but the drupal:9.2-apache will try to do a symlink in /opt/drupal/web/sites/default in its 
#        entrypoint, so at _run_ time. Unfortunately, the destination folder is gone, so symlink failed
#        and drupal don't find its configurations and crash
#RUN rm -rf /opt/drupal/web/sites && \
#  mkdir -p /data/sites && \
#  ln -snf /data/sites /opt/drupal/web/sites

#RUN rm -rf /opt/drupal/web/modules && \
#  mkdir -p /data/modules && \
#  ln -snf /data/modules /opt/drupal/web/modules

#RUN rm -rf /opt/drupal/web/profiles && \
#  mkdir -p /data/profiles && \
#  ln -snf /data/profiles /opt/drupal/web/profiles

#RUN rm -rf /opt/drupal/web/themes && \
#  mkdir -p /data/themes && \
#  ln -snf /data/themes /opt/drupal/web/themes

# copy the artifakt folder on root
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN  if [ -d .artifakt ]; then cp -rp /opt/drupal/.artifakt /.artifakt/; fi

# run custom scripts build.sh
# hadolint ignore=SC1091
RUN --mount=source=artifakt-custom-build-args,target=/tmp/build-args \
  if [ -f /tmp/build-args ]; then source /tmp/build-args; fi && \
  if [ -f /.artifakt/build.sh ]; then /.artifakt/build.sh; fi

# fix perms/owner
RUN chown -R www-data:www-data /data /opt/drupal/
