# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

user_config = YAML.load_file('/config/config.yaml')

file_path = "/config/provision/bash_variables_script.sh"

if !File.file?(file_path) then

  bash_variables_script = <<-SHELL
#!/bin/bash

export SOURCE_PROJECT=ezsystems/ezplatform
export SOURCE_DESTINATION=#{user_config['virtual_ezplatform_project_directory']}
export USER=#{user_config['virtual_machine_www_user']}
export GROUP=#{user_config['virtual_machine_www_group']}
export HOST=#{user_config['virtual_machine_external_ip']}
export DOMAIN=#{user_config['project_domain']}
SHELL

  File.write(file_path, bash_variables_script)
end
