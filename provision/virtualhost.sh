#!/bin/bash

SOURCE_DESTINATION=/var/www/ezplatform

chmod +x ${SOURCE_DESTINATION}/bin/vhost.sh

cp /vagrant/provision/vhost-template.conf /etc/apache2/sites-available/ezplatform.conf
a2ensite ezplatform.conf
systemctl reload apache2
