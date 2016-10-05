#!/usr/bin/env bash
PASSWORD='foobarbaz'

PROJECTFOLDER='project'
#login as root always

# create project folder

sudo mkdir "/var/www/html/${PROJECTFOLDER}"
sudo touch "/var/www/html/${PROJECTFOLDER}/sample_index.php"
sudo mkdir -p "/home/user/modules/config_mgt/files/"

# update and upgrade
sudo apt-get update
sudo apt-get -y upgrade

# install ruby and a json parser gem
sudo apt-get install -y ruby
gem install json-parser -q

VHOST=$(cat <<EOF
<VirtualHost *:80>
    DocumentRoot "/var/www/html/${PROJECTFOLDER}"
    <Directory "/var/www/html/${PROJECTFOLDER}">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
