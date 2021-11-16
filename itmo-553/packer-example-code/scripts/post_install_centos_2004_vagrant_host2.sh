#!/bin/bash 
set -e
set -v


# http://unix.stackexchange.com/questions/1416/redirecting-stdout-to-a-file-you-dont-have-write-permission-on
# This line assumes the user you created in the preseed directory is vagrant
# http://chrisbalmer.io/vagrant/2015/07/02/build-rhel-centos-7-vagrant-box.html
# Read this bug track to see why this line below was the source of a lot of trouble.... 
# https://github.com/mitchellh/vagrant/issues/1482
#echo "Defaults requiretty" | sudo tee -a /etc/sudoers.d/init-users
# Need to add this first as wget not part of the base package...
sudo yum install -y wget git
#################################################################################################################
# code needed to allow for vagrant to function seamlessly
#################################################################################################################
echo "%admin  ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/init-users
sudo groupadd admin
sudo usermod -a -G admin vagrant

# Installing Vagrant keys
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
sudo mkdir -p /home/vagrant/.ssh
sudo chown -R vagrant:vagrant /home/vagrant/.ssh
cat ./vagrant.pub >> /home/vagrant/.ssh/authorized_keys
sudo chown -R vagrant:vagrant /home/vagrant/.ssh/authorized_keys
sudo chmod 700 /home/vagrant/.ssh
sudo chmod 600 /home/vagrant/.ssh/authorized_keys
echo "All Done!"

#########################
# Add customization here
#########################

sudo yum install -y kernel-devel-`uname -r` gcc binutils make perl bzip2 epel-release

echo "All Done!"

cat << EOT >> /etc/hosts
# Nodes
192.168.33.100  riemanna riemanna.example.com
192.168.33.101  riemannb riemannb.example.com
192.168.33.102  riemannmc riemannmc.example.com
192.168.33.200  graphitea graphitea.example.com
192.168.33.201  graphiteb graphiteb.example.com
192.168.33.202  graphitemc graphitemc.example.com
192.168.33.10   host1.example.com
192.168.33.11   host2.example.com
EOT

## Command to change hostname
sudo hostnamectl set-hostname host2

# Install software
# 1 we will need openjdk-8-jre (java runtime) and ruby runtimes

git clone git@github.com:illinoistech-itm/sample-student.git

############################################################################
# Installation and cofiguration of collectd and load generation tool stress
############################################################################
sudo yum install -y collectd stress collectd-write_riemann

sudo systemctl stop collectd

#####################################################
# Copy the collectd configuration files from week-12
#####################################################
sudo mkdir -p /etc/collectd.conf.d/
cp -v sample-student/itmo-453/week-13/hosts/collectd.conf.d/* /etc/collectd.conf.d/

cp -v sample-student/itmo-453/week-13/collectd.conf /etc/

sudo systemctl daemon-reload
sudo systemctl start collectd

#######################################################
# Using sed to find and replace riemanna in the write_riemann.conf collectd conf file
#######################################################
sed -i 's/"riemanna"/"host2"/' /etc/collectd.conf.d/write_riemann.conf
