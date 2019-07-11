#!/usr/bin/env bash

# Configuration
NODE_VERSION=10
PHP_VERSION=7.2


if [ -f .mysql ]; then
	mysqldump --all-databases -uroot -proot > /vagrant/localbox.sql
fi

apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get autoremove -qy

echo "########################################"
echo "## Apache, PHP and MySQL installation ##"
echo "########################################"

curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | sudo -E bash -
apt-get update
apt-get install -qy apache2 libapache2-mod-php php php-gd php-mbstring php-mysql php-xdebug php-xml php-zip php-curl php-intl php-json php-msgpack php-memcached php-sqlite3 php-gmp php-geoip php-redis mysql-server nodejs

echo "        "
echo "Installations done"
echo "        "

echo "##########################"
echo "## Apache Configuration ##"
echo "##########################"

echo "<VirtualHost *:80>
	ServerName localbox
	
	DocumentRoot /var/www/localbox
	
	<Directory /var/www/localbox>
		Options +Indexes +FollowSymLinks +MultiViews
		AllowOverride All
	</Directory>
</VirtualHost>" > /etc/apache2/sites-available/010-localbox.conf

a2ensite 010-localbox
a2dissite 000-default
a2enmod rewrite
systemctl reload apache2

echo "        "
echo "Apache configuration done"
echo "        "

echo "#######################"
echo "## PHP Configuration ##"
echo "#######################"

echo "display_errors=On
xdebug.show_local_vars=1
smtp_port = 1025
sendmail_path = /usr/local/bin/mhsendmail" > /etc/php/${PHP_VERSION}/apache2/conf.d/zzzz-custom.ini
systemctl reload apache2

echo "        "
echo "PHP configuration done"
echo "        "

echo "###########################"
echo "## Composer Installation ##"
echo "###########################"

curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

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

echo "        "
echo "MySQL configuration done"
echo "        "

echo "########################"
echo "## Installing MailHog ##"
echo "########################"

# Download binary from github
echo "Downloading MailHog..."
wget --quiet -O /usr/local/bin/mailhog https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64

# Make it executable
chmod +x /usr/local/bin/mailhog

# Make it start on reboot
echo "[Unit]
Description=MailHog Email Catcher
After=syslog.target network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/mailhog
StandardOutput=journal
Restart=on-failure

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/mailhog.service

systemctl daemon-reload
systemctl enable mailhog

# Start it now in the background
systemctl start mailhog

# Install mhSendMail
echo "Downloading mhsendmail..."
wget --quiet -O /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64
chmod +x /usr/local/bin/mhsendmail

echo "        "
echo "MailHog installation done"
echo "        "
echo "        "
echo "========================================================================"
echo " The provisioning of your personal localbox is complete !"
echo " You can access it with your favorite web browser: http://192.168.33.10/"
echo " Put you websites in the www folder."
echo "========================================================================"
echo " _       ___     __   ____  _      ____    ___   __ __ ";
echo "| |     /   \   /  ] /    || |    |    \  /   \ |  |  |";
echo "| |    |     | /  / |  o  || |    |  o  )|     ||  |  |";
echo "| |___ |  O  |/  /  |     || |___ |     ||  O  ||_   _|";
echo "|     ||     /   \_ |  _  ||     ||  O  ||     ||     |";
echo "|     ||     \     ||  |  ||     ||     ||     ||  |  |";
echo "|_____| \___/ \____||__|__||_____||_____| \___/ |__|__|";
