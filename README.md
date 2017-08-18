LOCALBOX
==========
LocalBox is a simple vagrant file which allows you to deploy a full WAMP/LAMP/MAMP server very quickly and easily.

## Inside the box
* PHP 7.0
* MySQL 5.7
* Apache 2
* Composer
* NodeJS & NPM
* MailHog 1.0.0 with mhsendmail 0.2.0

### PHP extensions
* MySQL
* gd
* Xdebug
* mbstring
* mcrypt
* xml
* zip
* curl
* intl
* etc...

## Requirements
You can run LocalBox on Windows, MacOS or Linux as long as you have [VirtualBox](https://www.virtualbox.org/) (min v2.1.26) and [Vagrant](https://www.vagrantup.com/) (min v1.9.5) installed.

## Get started
1. Clone or download the repository somewhere on your computer
2. Go with you terminal in that folder (with the Vagrantfile) and use `vagrant up` to start the VM
3. (Optional) Edit your hosts file and add this line: `192.168.33.10 local.dev`
4. Go with you web browser on `192.168.33.10` or `local.dev`
5. The MySQL root password is `root`
6. :thumbsup: Happy coding...
