#!/bin/bash 
set -e
set -v

# http://superuser.com/questions/196848/how-do-i-create-an-administrator-user-on-ubuntu
# http://unix.stackexchange.com/questions/1416/redirecting-stdout-to-a-file-you-dont-have-write-permission-on
echo "vagrant ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/init-users
sudo cat /etc/sudoers.d/init-users


# Installing vagrant keys
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
sudo mkdir -p /home/vagrant/.ssh
cat ./vagrant.pub >> /home/vagrant/.ssh/authorized_keys
sudo chown -R vagrant:vagrant /home/vagrant/.ssh
##################################################
# Change hostname and /etc/hosts
##################################################
cat << EOT >> /etc/hosts
# Nodes
192.168.33.10 centos-riemanna centos-riemanna.project.iit.edu
192.168.33.11 centos-riemannb centos-riemannb.project.iit.edu
192.168.33.12 centos-riemannmc centos-riemannmc.project.iit.edu
192.168.33.110 centos-graphitea centos-graphitea.project.iit.edu
192.168.33.111 centos-graphiteb centos-graphiteb.project.iit.edu
192.168.33.112 centos-graphitemc centos-graphitemc.project.iit.edu
192.168.33.20 ub-riemanna ub-riemanna.project.iit.edu
192.168.33.21 ub-riemannb ub-riemannb.project.iit.edu
192.168.33.22 ub-riemannmc ub-riemannmc.project.iit.edu
192.168.33.210 ub-graphitea ub-graphitea.project.iit.edu
192.168.33.211 ub-graphiteb ub-graphiteb.project.iit.edu
192.168.33.212 ub-graphitemc ub-graphitemc.project.iit.edu
EOT

sudo hostnamectl set-hostname ub-riemannb

##################################################
sudo apt-get update -y
sudo apt-get install -y ruby ruby-dev build-essential zlib1g-dev openjdk-8-jre collectd

# P.42 The Art of Monitoring
wget https://github.com/riemann/riemann/releases/download/0.3.5/riemann_0.3.5_all.deb
sudo dpkg -i riemann_0.3.5_all.deb

# cloning source code examples for the book
git clone https://github.com/turnbullpress/aom-code.git

# Install leiningen on Centos 7 - needed for riemann syntax checker
sudo apt-get install -y leiningen

# Riemann syntax checker download and install
git clone https://github.com/samn/riemann-syntax-check
cd riemann-syntax-check
lein uberjar
cd ../

# P. 44  Install ruby gem tools
sudo gem install --no-ri --no-rdoc riemann-tools

sudo systemctl enable collectd
sudo systemctl start collectd
sudo systemctl enable riemann
sudo systemctl start riemann


