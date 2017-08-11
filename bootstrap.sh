#!/usr/bin/env bash

apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y

echo "#########################################"
echo "## Installation d'Apache, PHP et MySQL ##"
echo "#########################################"

export DEBIAN_FRONTEND=noninteractive
apt-get install -qy apache2 libapache2-mod-php php-mcrypt php-gd php-mbstring php-mysql php-xdebug mysql-server

echo "############################"
echo "## Configuration d'Apache ##"
echo "############################"

echo "<VirtualHost *:80>
	ServerName local.dev
	
	DocumentRoot /var/www/localbox
	
	<Directory /var/www/localbox>
		Options +Indexes +FollowSymLinks +MultiViews
		AllowOverride All
	</Directory>
</VirtualHost>" > /etc/apache2/sites-available/010-localbox.conf

a2ensite 010-localbox
a2dissite 000-default
a2enmod rewrite

echo "##########################"
echo "## Configuration de PHP ##"
echo "##########################"

echo "display_errors=On
xdebug.show_local_vars=1" > /etc/php/7.0/apache2/conf.d/zzzz-custom.ini

service apache2 restart

echo "############################"
echo "## Configuration de MySQL ##"
echo "############################"

if ! [ -x "$(command -v mysql)" ]; then
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';"
fi