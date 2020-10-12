#!/bin/bash 
set -e
set -v

# Install base dependencies -  Centos 7 mininal needs the EPEL repo in the line above and the package daemonize
sudo yum update -y
sudo yum install -y wget unzip vim git 

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
##################################################
# Change hostname and /etc/hosts
##################################################
cat << EOT >> /etc/hosts
# Nodes
192.168.33.20 ub-riemanna ub-riemanna.project.iit.edu
192.168.33.21 ub-riemannb ub-riemannb.project.iit.edu
192.168.33.22 ub-riemannmc ub-riemannmc.project.iit.edu
192.168.33.210 ub-graphitea ub-graphitea.project.iit.edu
192.168.33.211 ub-graphiteb ub-graphiteb.project.iit.edu
192.168.33.212 ub-graphitemc ub-graphitemc.project.iit.edu
192.168.33.10 centos-riemanna centos-riemanna.project.iit.edu
192.168.33.11 centos-riemannb centos-riemannb.project.iit.edu
192.168.33.12 centos-riemannmc centos-riemannmc.project.iit.edu
192.168.33.110 centos-graphitea centos-graphitea.project.iit.edu
192.168.33.111 centos-graphiteb centos-graphiteb.project.iit.edu
192.168.33.112 centos-graphitemc centos-graphitemc.project.iit.edu
EOT

sudo hostnamectl set-hostname centos-riemannb

##################################################
# Install Elrepo - The Community Enterprise Linux Repository (ELRepo) - http://elrepo.org/tiki/tiki-index.php
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
# https://wiki.centos.org/AdditionalResources/Repositories
sudo yum install -y https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm
# Install epel repo for collectd
sudo yum install -y epel-release

sudo yum install -y java-1.8.0-openjdk daemonize curl collectd
# Due to needing a tty to run sudo, this install command adds all the pre-reqs to build the virtualbox additions
sudo yum install -y kernel-devel-`uname -r` gcc binutils make perl bzip2 python3 python3-pip python3-setuptools


###############################################################################################################
# firewalld additions to make CentOS and riemann to work
###############################################################################################################
# Adding firewall rules for riemann - Centos 7 uses firewalld (Thanks Lennart...)
# http://serverfault.com/questions/616435/centos-7-firewall-configuration
sudo firewall-cmd --zone=public --add-port=5555/tcp --permanent
sudo firewall-cmd --zone=public --add-port=5556/udp --permanent
# Websockets are TCP... for now - http://stackoverflow.com/questions/4657033/javascript-websockets-with-udp
sudo firewall-cmd --zone=public --add-port=5557/tcp --permanent
###############################################################################################################

###############################################################################################################
# Fetch and install the Riemann RPM
###############################################################################################################
wget https://github.com/riemann/riemann/releases/download/0.3.5/riemann-0.3.5-1.noarch-EL7.rpm
sudo rpm -Uvh riemann-0.3.5-1.noarch-EL7.rpm

# cloning source code examples for the book
git clone https://github.com/turnbullpress/aom-code.git

# Install leiningen on Centos 7 - needed for riemann syntax checker
wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
chmod +x lein
sudo cp ./lein /usr/local/bin

# Riemann syntax checker download and install
git clone https://github.com/samn/riemann-syntax-check
cd riemann-syntax-check
lein uberjar

# Enable to Riemann service to start on boot and start the service
sudo systemctl enable collectd
sudo systemctl start collectd
sudo systemctl enable riemann
sudo systemctl start riemann

# P. 44  Install ruby gem tool, Centos 7 has Ruby 2.x as the default
sudo yum install -y ruby ruby-devel gcc libxml2-devel
sudo gem install --no-ri --no-rdoc riemann-tools
echo "All Done!"