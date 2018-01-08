LOCALBOX
==========
LocalBox is a simple vagrant file which allows you to deploy a full WAMP/LAMP/MAMP server very quickly and easily.

## Inside the box
* PHP 7.1 with extensions
* MySQL 5.7
* Apache 2.4
* Composer
* NodeJS 9 & NPM
* MailHog 1.0.0 with mhsendmail 0.2.0

## Requirements
You can run LocalBox on Windows, MacOS or Linux as long as you have [VirtualBox](https://www.virtualbox.org/) (min v2.1.26) and [Vagrant](https://www.vagrantup.com/) (min v1.9.5) installed.

## Get started
1. Clone or download the repository somewhere on your computer
1. Put your websites in the www folder
1. Use the `vagrant up` command in the root folder (with the Vagrantfile) to start the VM
1. (Optional) Edit your hosts file and add this line: `192.168.33.10 localbox`
1. Go with you web browser on `192.168.33.10` or `localbox`
1. The MySQL root password is `root`
1. :thumbsup: Happy coding...
