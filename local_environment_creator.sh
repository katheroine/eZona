#!/bin/bash

# Before run this script, create /config directory and your user as an owner of this directory
# then go to this directory and run `git clone https://github.com/katheroine/eZona .` command.
# After that copy config-template.yaml to config.yaml and edit to set-up parameters.
# Now you can run this script within the /config directory.
# Do not forget to modify /etc/hosts file.

source /config/provision/bash_variables_script.sh

SCRIPT_CREATOR=/config/provision/bash_variables_script_creator.rb
SCRIPT=/config/provision/bash_variables_script.sh
ruby $SCRIPT_CREATOR

chmod +x provision/*

sudo ./provision/packages.sh
sudo ./provision/web_server.sh
sudo ./provision/project.sh
sudo ./provision/virtualhost.sh
