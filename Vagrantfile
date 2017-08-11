# Vagrantfile for local.dev

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"
  config.vm.define "local.dev"
  
  config.vm.provider "virtualbox" do |vb|
    vb.name = "local.dev"
  end
  
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder "C:/Users/M254626/Sites", "/var/www/local.dev"
  
  config.vm.provision :shell do |s|
    s.name = "Services installation"
    s.path = "bootstrap.sh"
  end

end
