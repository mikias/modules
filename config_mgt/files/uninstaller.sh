#!/usr/bin/env bash

#to remove apache
sudo service apache2 stop
sudo apt-get remove --purge $APACHE_PKGS
#sudo apt-get install --reinstall apache
sudo apt-get purge apache2 -y

#remove php and json
apt-get purge 'php5*' -y
gem uninstall json-parser -q
gem install rufus-scheduler -q

#remove ruby
#apt-get remove ruby -y
#apt-get purge ruby -y
#aptitude purge ruby -y
