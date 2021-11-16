#!/bin/bash 
set -e
set -v

# http://superuser.com/questions/196848/how-do-i-create-an-administrator-user-on-ubuntu
# http://unix.stackexchange.com/questions/1416/redirecting-stdout-to-a-file-you-dont-have-write-permission-on
# This line assumes the user you created in the preseed directory is ubuntu
echo "%admin  ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/init-users
sudo groupadd admin
sudo usermod -a -G admin vagrant

# Installing Vagrant keys
wget --no-check-certificate 'https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub'
sudo mkdir -p /home/vagrant/.ssh
sudo chown -R vagrant:vagrant /home/vagrant/.ssh
cat ./vagrant.pub >> /home/vagrant/.ssh/authorized_keys
sudo chown -R vagrant:vagrant /home/vagrant/.ssh/authorized_keys
echo "All Done!"

##################################################
# Add User customizations below here
##################################################

cat << EOT >> /etc/hosts
# Nodes
192.168.33.100  riemanna riemanna.example.com
192.168.33.101  riemannb riemannb.example.com
192.168.33.102  riemannmc riemannmc.example.com
192.168.33.200  graphitea graphitea.example.com
192.168.33.201  graphiteb graphiteb.example.com
192.168.33.202  graphitemc graphitemc.example.com
EOT

## Command to change hostname
sudo hostnamectl set-hostname riemannmc

# Install software
# 1 we will need openjdk-8-jre (java runtime) and ruby runtimes
# Examples:
sudo apt-get update -y
sudo apt-get install -y openjdk-8-jre ruby ruby-dev

# 2 we will need the rpm deb packages from riemann.io
# Examples
wget https://github.com/riemann/riemann/releases/download/0.3.6/riemann_0.3.6_all.deb
sudo dpkg -i riemann_0.3.6_all.deb
# 3 we will need some ruby gems 
sudo gem install riemann-client riemann-tools
# 4 We need to ensure the services are enabled and start succesfully
sudo systemctl enable riemann
sudo systemctl start riemann

git clone git@github.com:illinoistech-itm/sample-student.git
cp -v sample-student/itmo-453/week-07/riemann/riemannmc/riemann.config /etc/riemann/riemann.config

####################################################
# Make directory for *.clj files
####################################################
sudo mkdir -p /etc/riemann/examplecom/etc
cp -v sample-student/itmo-453/week-09/examplecom/etc/*.clj /etc/riemann/examplecom/etc/

#####################################################
# Use sed to replace the default graphitea values
#####################################################
sed -i 's/graphitea/graphitemc/g' /etc/riemann/examplecom/etc/graphite.clj
sed -i 's/productiona/productionmc/g' /etc/riemann/examplecom/etc/graphite.clj

#####################################################
# Restart the Riemann service after the changes
#####################################################

sudo systemctl stop riemann
sudo systemctl start riemann

##################################################
# Installation and cofiguration of collectd and mailutils to send emails
##################################################
sudo apt-get update -y
# Command needed to pre-seed the answer to the mailutils configuration question
echo "postfix postfix/main_mailer_type string 'No Configuration'" | sudo debconf-set-selections
sudo apt-get install -y collectd mailutils
sudo systemctl stop collectd

#####################################################
# Copy the collectd configuration files from week-12
#####################################################
cp -v sample-student/itmo-453/week-12/riemann/collectd.conf.d/* /etc/collectd/collectd.conf.d/

cp -v sample-student/itmo-453/week-12/collectd.conf /etc/collectd/

sudo systemctl daemon-reload
sudo systemctl start collectd

#######################################################
# Using sed to find and replace riemanna in the write_riemann.conf collectd conf file
#######################################################
sed -i 's/"riemanna"/"riemannb"/' /etc/collectd/collectd.conf.d/write_riemann.conf
