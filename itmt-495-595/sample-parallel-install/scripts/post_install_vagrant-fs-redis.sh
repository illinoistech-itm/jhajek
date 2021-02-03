#!/bin/bash 
set -e
set -v

# http://superuser.com/questions/196848/how-do-i-create-an-administrator-user-on-ubuntu
# http://unix.stackexchange.com/questions/1416/redirecting-stdout-to-a-file-you-dont-have-write-permission-on
# This line assumes the user you created in the preseed directory is vagrant
echo "%admin  ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/init-users
sudo groupadd admin
sudo usermod -a -G admin vagrant

# Installing Vagrant keys
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
sudo mkdir -p /home/vagrant/.ssh
sudo chown -R vagrant:vagrant /home/vagrant/.ssh
cat ./vagrant.pub >> /home/vagrant/.ssh/authorized_keys
sudo chown -R vagrant:vagrant /home/vagrant/.ssh/authorized_keys
echo "All Done!"

##################################################
# Add User customizations below here
##################################################


sudo apt-get update
sudo apt-get install -y nginx fail2ban git redis-server

## enable firewall

ufw --force enable
ufw allow proto tcp to 0.0.0.0/0 port 22
ufw allow proto tcp to 0.0.0.0/0 port 6379

# set the /etc/hosts file to match hostname
echo "$LBIP     lb     lb.class.edu"   | sudo tee -a /etc/hosts
echo "$WS1IP     ws1    ws1.class.edu"  | sudo tee -a /etc/hosts
echo "$WS2IP     ws2  ws2.class.edu"   | sudo tee -a /etc/hosts
echo "$WS3IP     ws3  ws3.class.edu"   | sudo tee -a /etc/hosts
echo "$REDIP     redis  redis.class.edu" | sudo tee -a /etc/hosts
echo "$MMIP     mm  mm.class.edu" | sudo tee -a /etc/hosts
echo "$MS1IP     ms1  ms1.class.edu" | sudo tee -a /etc/hosts
echo "$MS2IP     ms2  ms2.class.edu" | sudo tee -a /etc/hosts
echo "$MS3IP     ms3  ms3.class.edu" | sudo tee -a /etc/hosts
sudo hostnamectl set-hostname redis

# Redis configurations
# https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-18-04
sudo cp -v ./hajek/itmt-430/fullstack/redis-conf/redis.conf /etc/redis
sudo systemctl daemon-reload
sudo systemctl restart redis
sudo systemctl status redis
sudo systemctl enable redis
