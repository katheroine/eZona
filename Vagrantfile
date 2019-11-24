# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

user_config = YAML.load_file('config.yaml')

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/bionic64"
  
  config.vm.network "forwarded_port", guest: 80, host: 8633
  config.vm.network "forwarded_port", guest: 3306, host: 13306
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provider "virtualbox" do |vb|
    vb.name = user_config['virtualbox_machine_name']
    vb.memory = "4096"
  end

  config.vm.synced_folder "../", "/trunk"
  config.vm.synced_folder user_config['shared_local_ezplatform_project_directory'], "/var/www/ezplatform", 
    # type: "nfs"
    owner: "vagrant", 
    group: "vagrant"

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y aptitude
  SHELL
  config.vm.provision "shell", path: "provision/packages.sh"
  config.vm.provision "shell", path: "provision/web_server.sh"
  config.vm.provision "shell", path: "provision/project.sh"
  config.vm.provision "shell", path: "provision/virtualhost.sh"
  
end
