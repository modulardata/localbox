# Vagrantfile for local.dev

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "localbox"
  config.vm.define "localbox"
  
  config.vm.provider "virtualbox" do |vb|
    vb.name = "localbox"
  end
  
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.synced_folder "./www", "/var/www/localbox"
  
  config.vm.provision :shell do |s|
    s.name = "Services installation"
    s.path = "bootstrap.sh"
  end

end
