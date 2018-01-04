#!/usr/bin/env bash

if [ -f .mysql ]; then
	mysqldump --all-databases -uroot -proot > /vagrant/localbox.sql
fi

apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y

echo "########################################"
echo "## Apache, PHP and MySQL installation ##"
echo "########################################"

export DEBIAN_FRONTEND=noninteractive
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
apt-get install -qy build-essential apache2 libapache2-mod-php7.1 php7.1-mcrypt php7.1-gd php7.1-mbstring php7.1-mysql php7.1-xdebug php7.1-xml php7.1-zip php7.1-curl php7.1-intl php7.1-json php7.1-msgpack php7.1-memcached php7.1-sqlite3 php7.1-gmp php7.1-geoip php7.1-redis mysql-server nodejs

echo "        "
echo "Installations done"
echo "        "

echo "##########################"
echo "## Apache Configuration ##"
echo "##########################"

echo "<VirtualHost *:80>
	ServerName local.test
	
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
xdebug.show_local_vars=1
smtp_port = 1025
sendmail_path = /usr/local/bin/mhsendmail" > /etc/php/7.0/apache2/conf.d/zzzz-custom.ini

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
echo "======================================================================="
echo " The provisioning of your personal localbox is complete !"
echo " You can access it with your favorite web browser: http://192.168.33.10/"
echo " Put you websites in the www folder."
echo "======================================================================="
echo " _       ___     __   ____  _      ____    ___   __ __ ";
echo "| |     /   \   /  ] /    || |    |    \  /   \ |  |  |";
echo "| |    |     | /  / |  o  || |    |  o  )|     ||  |  |";
echo "| |___ |  O  |/  /  |     || |___ |     ||  O  ||_   _|";
echo "|     ||     /   \_ |  _  ||     ||  O  ||     ||     |";
echo "|     ||     \     ||  |  ||     ||     ||     ||  |  |";
echo "|_____| \___/ \____||__|__||_____||_____| \___/ |__|__|";
echo "                                        by Gil Balsiger";
