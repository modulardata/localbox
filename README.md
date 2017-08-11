LOCALBOX
==========
Localbox is a simple vagrant file which allows you to deploy a full WAMP/LAMP/MAMP server very quickly and easily.

## Inside the box
* PHP 7.0
* MySQL 5.7
* Apache 2
* Composer

## Requirements
Localbox is compatible Windows, MacOS and Linux. You need only 2 things to get started with localbox: [VirtualBox](https://www.virtualbox.org/) (min 2.1.26) and [Vagrant](https://www.vagrantup.com/) (min 1.9.5).

## Get started
1. Clone or download the repository somewhere on your computer
2. Go with you terminal in that folder (with the Vagrantfile) and use `vagrant up` to start the VM
3. (Optional) Edit your hosts file and add this line: `192.168.33.10 local.dev`
4. Go with you web browser on `192.168.33.10` or `local.dev`
5. :thumbsup: Happy coding...