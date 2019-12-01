#!/bin/bash

source /config/provision/bash_variables_script.sh

EZPLATFORM_TMP_DIR=/var/ezona/ezplatform

mkdir -m 774 -p ${EZPLATFORM_TMP_DIR}

export SYMFONY_ENV="dev"

rm -rf ${SOURCE_DESTINATION}/* ${SOURCE_DESTINATION}/.*

composer create-project --keep-vcs $SOURCE_PROJECT $SOURCE_DESTINATION
cp /vagrant/provision/project_parameters.yml ${SOURCE_DESTINATION}/app/config/parameters.yml
composer update
chmod -R 777 $SOURCE_DESTINATION
chown -R ${USER}:${GROUP} $SOURCE_DESTINATION

cd $SOURCE_DESTINATION
composer ezplatform-install

rm -rf ${SOURCE_DESTINATION}/var

chown -R ${USER}:${GROUP} ${EZPLATFORM_TMP_DIR}/..