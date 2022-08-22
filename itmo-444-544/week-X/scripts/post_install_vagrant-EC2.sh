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

sudo apt-get install -y git rsync wget links cloud-init

# This changes the ownership of the private key and config file to make sure there are no permission issues
sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/config
sudo chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa_github_deploy_key

sudo systemctl enable cloud-init
#sudo systemctl start cloud-init

