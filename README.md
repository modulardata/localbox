LOCALBOX
==========
LocalBox is a simple vagrant file which allows you to deploy a full WAMP/LAMP/MAMP server very quickly and easily.

## Inside the box
* PHP 7.1
* MySQL 5.7
* Apache 2.4
* Composer
* NodeJS 9 & NPM
* MailHog 1.0.0 with mhsendmail 0.2.0

### PHP extensions
* mcrypt
* gd
* mbstring
* mysql
* xdebug
* xml
* zip
* curl
* intl
* json
* msgpack
* memcached
* sqlite3
* gmp
* geoip
* redis

## Requirements
You can run LocalBox on Windows, MacOS or Linux as long as you have [VirtualBox](https://www.virtualbox.org/) (min v2.1.26) and [Vagrant](https://www.vagrantup.com/) (min v1.9.5).

## Get started
1. Clone or download the repository somewhere on your computer
2. Go with you terminal in that folder (with the Vagrantfile) and use the `vagrant up` command to start the VM
3. (Optional) Edit your hosts file and add this line: `192.168.33.10 local.test`
4. Go with you web browser on `192.168.33.10` or `local.test`
5. The MySQL root password is `root`
6. :thumbsup: Happy coding...