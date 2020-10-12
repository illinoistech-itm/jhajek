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
192.168.33.110 riemanna riemanna.example.com
192.168.33.120 riemannb riemannb.example.com
192.168.33.100 riemannmc riemannmc.example.com
192.168.33.210 graphitea graphitea.example.com
192.168.33.220 graphiteb graphiteb.example.com
192.168.33.200 graphitemc graphitemc.example.com
192.168.33.150 ela1 ela1.example.com
192.168.33.160 ela2 ela2.example.com
192.168.33.170 ela3 ela3.example.com
192.168.33.180 logstash logstash.example.com
192.168.33.10 host1 host1.example.com
192.168.33.11 host2 host2.example.com
EOT

sudo hostnamectl set-hostname host1

##################################################
sudo apt-get update -y
sudo apt-get install -y collectd stress

# Cloning source code examples for the book
git clone https://github.com/turnbullpress/aom-code.git

# Collectd config filees
sudo cp -v /home/vagrant/aom-code/5-6/collectd/collectd.conf /etc
sudo sudo cp -rv /home/vagrant/aom-code/5-6/collectd/collectd.d/*.conf /etc/collectd/collectd.conf.d
# sudo sed -i 's/riemanna.exmaple.com/riemanna.example.com/g' /etc/collectd.d/write_riemann.conf
sudo sed -i 's/Node "riemanna"/Node "host1"/g' /etc/collectd/collectd.conf.d/write_riemann.conf

# Reload collectd service and start it at boot
sudo systemctl enable collectd
sudo systemctl stop collectd
sudo systemctl daemon-reload
sudo systemctl start collectd
