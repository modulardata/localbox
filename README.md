LOCALBOX
==========
LocalBox is a simple vagrant file which allows you to deploy a full WAMP/LAMP/MAMP server quickly and easily.

## Inside the box
* PHP 7.2 with extensions
* MySQL
* Apache 2
* Composer
* NodeJS & NPM
* MailHog 1.0.0 with mhsendmail 0.2.0

## Requirements
You can run LocalBox on Windows, MacOS or Linux as long as you have [VirtualBox](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/) installed.

## Get started
1. Clone or download the repository somewhere on your computer
1. Put your websites in the www folder
1. Execute the `vagrant up` command in the root folder (with the Vagrantfile) to start the VM
1. (Optional) Edit your hosts file and add this line: `192.168.33.10 localbox`
1. Go with you web browser on `192.168.33.10` or `localbox`
1. The MySQL root password is `root`
1. :thumbsup: Happy coding...
