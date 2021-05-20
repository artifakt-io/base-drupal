FROM registry.artifakt.io/drupal:9.1-apache

COPY --chown=www-data:www-data . /opt/drupal/web/

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# PERSISTENT DATA FOLDERS
RUN rm -rf /opt/drupal/web/sites && \
  mkdir -p /data/sites && \
  ln -s /data/sites /opt/drupal/web/sites

RUN rm -rf /opt/drupal/web/modules && \
  mkdir -p /data/modules && \
  ln -s /data/modules /opt/drupal/web/modules

RUN rm -rf /opt/drupal/web/profiles && \
  mkdir -p /data/profiles && \
  ln -s /data/profiles /opt/drupal/web/profiles

RUN rm -rf /opt/drupal/web/themes && \
  mkdir -p /data/themes && \
  ln -s /data/themes /opt/drupal/web/themes

WORKDIR /opt/drupal/web

# copy the artifakt folder on root
RUN  if [ -d .artifakt ]; then cp -rp /opt/drupal/web/.artifakt /.artifakt/; fi

# run custom scripts build.sh
# hadolint ignore=SC1091
RUN --mount=source=artifakt-custom-build-args,target=/tmp/build-args \
  if [ -f /tmp/build-args ]; then source /tmp/build-args; fi && \
  if [ -f /.artifakt/build.sh ]; then /.artifakt/build.sh; fi

ARG COMPOSER_VERSION=2.0.13
RUN curl -sS https://getcomposer.org/installer | \
  php -- --version=${COMPOSER_VERSION} --install-dir=/usr/local/bin --filename=composer

RUN [ -f composer.lock ] && composer install --no-cache --optimize-autoloader --no-interaction --no-ansi --no-dev || true
