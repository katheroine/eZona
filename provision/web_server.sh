#!/bin/bash

PHP_VERSION=7.2

apache_modules=(
	rewrite
	actions
	alias
	proxy_fcgi
)

echo "Apache modules: ${apache_modules[@]}"

echo "Enabling Apache modules..."

a2enmod ${apache_modules[@]}
a2enconf php$PHP_VERSION-fpm
service apache2 restart

# The way of verification if Apache is working fine with PHP FPM
# Go to IP address defined by config.vm.network in Vagrantfile
# and you should see PHP Info page
rm /var/www/html/index.html
echo "<?php phpinfo();" > /var/www/html/index.php

USER=vagrant

APACHE_ENVARS_FILE=/etc/apache2/envvars
sed -i 's/^export APACHE_RUN_USER=.*$/export APACHE_RUN_USER='${USER}'/' $APACHE_ENVARS_FILE
sed -i 's/^export APACHE_RUN_GROUP=.*$/export APACHE_RUN_GROUP='${USER}'/' $APACHE_ENVARS_FILE
service apache2 restart

PHP_CONF_FILE=/etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i 's/^user = .*$/user = '${USER}'/' $PHP_CONF_FILE
sed -i 's/^group = .*$/group = '${USER}'/' $PHP_CONF_FILE
sed -i 's/^listen.owner = .*$/listen.owner = '${USER}'/' $PHP_CONF_FILE
sed -i 's/^listen.group = .*$/listen.group = '${USER}'/' $PHP_CONF_FILE
service php$PHP_VERSION-fpm restart
