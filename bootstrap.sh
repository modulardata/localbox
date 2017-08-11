#!/usr/bin/env bash

apt-get update
apt-get upgrade
apt-get dist-upgrade

echo "##################################"
echo "## Installation d'Apache et PHP ##"
echo "##################################"

apt-get install -y apache2 libapache2-mod-php php-mcrypt php-gd php-mbstring php-mysql php-xdebug

echo "############################"
echo "## Configuration d'Apache ##"
echo "############################"

echo "<VirtualHost *:80>
	ServerName local.dev
	
	DocumentRoot /var/www/local.dev
	
	<Directory /var/www/local.dev>
		Options +Indexes +FollowSymLinks +MultiViews
		AllowOverride All
	</Directory>
</VirtualHost>" > /etc/apache2/sites-available/010-localdev.conf

a2ensite 010-localdev
a2dissite 000-default
a2enmod rewrite

echo "##########################"
echo "## Configuration de PHP ##"
echo "##########################"

echo "display_errors=On" > /etc/php/7.0/apache2/conf.d/zzzz-custom.ini

service apache2 restart

echo "#############################"
echo "## Installation de MariaDB ##"
echo "#############################"

apt-get install -y mariadb-server

echo "##############################"
echo "## Configuration de MariaDB ##"
echo "##############################"

mysql -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('root');"


echo " _       ___     __   ____  _          ___      ___ __ __ ";
echo "| |     /   \   /  ] /    || |        |   \    /  _]  |  |";
echo "| |    |     | /  / |  o  || |        |    \  /  [_|  |  |";
echo "| |___ |  O  |/  /  |     || |___     |  D  ||    _]  |  |";
echo "|     ||     /   \_ |  _  ||     | __ |     ||   [_|  :  |";
echo "|     ||     \     ||  |  ||     ||  ||     ||     |\   / ";
echo "|_____| \___/ \____||__|__||_____||__||_____||_____| \_/  ";
echo "                                                          ";
