#!/bin/bash

source /config/provision/bash_variables_script.sh

VHOST_CONF=/etc/apache2/sites-available/ezplatform.conf

cp /config/provision/vhost-template.conf $VHOST_CONF

sed -i 's/%DOMAIN%/'${DOMAIN}'/' $VHOST_CONF
sed -i 's/%HOST%/'${HOST}'/' $VHOST_CONF
sed -i 's@%PROJECT_DIR%@'${SOURCE_DESTINATION}'@' $VHOST_CONF

a2ensite ezplatform.conf
systemctl reload apache2
