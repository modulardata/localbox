#!/usr/bin/env bash

apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y

echo "########################################"
echo "## Apache, PHP and MySQL installation ##"
echo "########################################"

export DEBIAN_FRONTEND=noninteractive
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get install -qy apache2 libapache2-mod-php php-mcrypt php-gd php-mbstring php-mysql php-xdebug mysql-server nodejs build-essential

echo "        "
echo "Installations done"
echo "        "

echo "##########################"
echo "## Apache Configuration ##"
echo "##########################"

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

echo "        "
echo "Apache configuration done"
echo "        "

echo "#######################"
echo "## PHP Configuration ##"
echo "#######################"

echo "display_errors=On
xdebug.show_local_vars=1" > /etc/php/7.0/apache2/conf.d/zzzz-custom.ini

echo "        "
echo "PHP configuration done"
echo "        "

echo "###########################"
echo "## Composer Installation ##"
echo "###########################"

curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

service apache2 restart

echo "        "
echo "Composer installation done"
echo "        "

echo "#########################"
echo "## MySQL Configuration ##"
echo "#########################"

if [ ! -f .mysql ]; then
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';"
fi
touch .mysql

service mysql restart

echo "        "
echo "MySQL configuration done"
echo "        "

echo " _       ___     __   ____  _      ____    ___   __ __ ";
echo "| |     /   \   /  ] /    || |    |    \  /   \ |  |  |";
echo "| |    |     | /  / |  o  || |    |  o  )|     ||  |  |";
echo "| |___ |  O  |/  /  |     || |___ |     ||  O  ||_   _|";
echo "|     ||     /   \_ |  _  ||     ||  O  ||     ||     |";
echo "|     ||     \     ||  |  ||     ||     ||     ||  |  |";
echo "|_____| \___/ \____||__|__||_____||_____| \___/ |__|__|";
echo "                                        by Gil Balsiger";
