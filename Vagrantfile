# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

user_config = YAML.load_file('config.yaml')

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/bionic64"
  
  config.vm.network "forwarded_port", guest: 80, host: user_config['www_server_forwarded_port']
  config.vm.network "forwarded_port", guest: 3306, host: user_config['sql_server_formwarded_port']
  config.vm.network "private_network", ip: user_config['virtual_machine_external_ip']

  config.vm.synced_folder "../", "/trunk"
  config.vm.synced_folder "./", "/config"

  config.vm.synced_folder user_config['shared_local_ezplatform_project_directory'], user_config['virtual_ezplatform_project_directory'],
    owner: user_config['virtual_machine_www_user'], 
    group: user_config['virtual_machine_www_group']

  config.vm.provider "virtualbox" do |vb|
    vb.name = user_config['virtualbox_machine_name']
    vb.memory = user_config['virtual_machine_ram']
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y aptitude
    aptitude install -y ruby
  SHELL

  config.vm.provision "shell", inline: <<-SHELL
    SCRIPT_CREATOR=/config/provision/bash_variables_script_creator.rb
    SCRIPT=/config/provision/bash_variables_script.sh
    ruby $SCRIPT_CREATOR
    chown #{user_config['virtual_machine_www_user']}:#{user_config['virtual_machine_www_group']} $SCRIPT
    chmod 777 $SCRIPT
  SHELL

  config.vm.provision "shell", path: "provision/packages.sh"
  config.vm.provision "shell", path: "provision/web_server.sh"
  config.vm.provision "shell", path: "provision/project.sh"
  config.vm.provision "shell", path: "provision/virtualhost.sh"

end
