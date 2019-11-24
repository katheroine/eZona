#!/bin/bash

MYSQL_VERSION=5.7
PHP_VERSION=7.2

echo "MySQL version: ${PHP_VERSION}"
echo "PHP version: ${PHP_VERSION}"

mysql_packages=(
	mysql-server-$MYSQL_VERSION
	mysql-client-$MYSQL_VERSION
)

echo "MySQL packages: ${mysql_packages[@]}"

php_extensions=(
	fpm
	cli
	intl
	curl
	xml
	mbstring
	gd
	mysql
)

echo "PHP extensions: ${php_extensions[@]}"

php_packages=("${php_extensions[@]/#/php$PHP_VERSION-}")

echo "PHP packages: ${php_packages[@]}"

apache_packages=(
	apache2
	#libapache2-mod-fastcgi
)

echo "Apache packages: ${apache_packages[@]}"

debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

packages=(
	zip
	unzip
	lynx
	git
	composer
	"${mysql_packages[@]}"
	"${php_packages[@]}"
	"${apache_packages[@]}"
)

echo "Packages: ${packages[@]}"

echo "Installing aptitude packages..."

aptitude install --assume-yes ${packages[@]}

# # Istallation of problematic Fast CGI Apache module
# wget http://mirrors.kernel.org/ubuntu/pool/multiverse/liba/libapache-mod-fastcgi/libapache2-mod-fastcgi_2.4.7~0910052141-1.2_amd64.deb
# sudo dpkg -i libapache2-mod-fastcgi_2.4.7~0910052141-1.2_amd64.deb

# Installation of problematic NodeJS package
aptitude remove -y nodejs
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - > /dev/null 2>&1
aptitude install -y nodejs

# Installation of problematic Yarn package
aptitude remove cmdtest
aptitude remove yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - 2>&1
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
aptitude update  
aptitude install yarn
yarn install

aptitude clean
