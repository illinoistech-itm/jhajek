#!/bin/bash 
set -e
set -v

##################################################
# Add User customizations below here
##################################################
# needed to disable password authentication via SSH
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl enable ssh.service
sudo systemctl start ssh.service

sudo apt-get install -y git rsync wget links apache2

sudo systemctl enable apache2
sudo systemctl start apache2
