#!/bin/bash 
set -e
set -v

##################################################
# Add User customizations below here
##################################################

sudo apt-get install -y mariadb-server firewalld

#################################################################################
# Use an IF statement to determine if we are building for Proxmox Cloud server
# 192.168.172.x or for VirtualBox 192.168.56.x
#################################################################################
IP=$(hostname -I | awk '{print $2}' | cut -d . -f3)

if [ $IP != 172 ]
then
  echo "Building for Proxmox Cloud Environment -- we have Dynamic DNS, no need for /etc/hosts files"
else
  echo "192.168.56.101     team-$NUMBER-lb-vm0    team-$NUMBER-lb-vm0.service.consul"    | sudo tee -a /etc/hosts
  echo "192.168.56.102     team-$NUMBER-ws-vm0   team-$NUMBER-ws-vm0.service.consul"   | sudo tee -a /etc/hosts
  echo "192.168.56.103     team-$NUMBER-ws-vm1   team-$NUMBER-ws-vm1.service.consul"   | sudo tee -a /etc/hosts
  echo "192.168.56.104     team-$NUMBER-ws-vm2   team-$NUMBER-ws-vm2.service.consul"   | sudo tee -a /etc/hosts
  echo "192.168.56.105     team-$NUMBER-db-vm0    team-$NUMBER-db-vm0.service.consul"    | sudo tee -a /etc/hosts
fi

#################################################################################
# Change the value of XX to be your team GitHub Repo
# Otherwise your clone operation will fail
# The command: su - vagrant -c switches from root to the user vagrant to execute 
# the git clone command
##################################################################################
su - vagrant -c "git clone git@github.com:illinoistech-itm/team-00.git"
cd team-00/code/
#################################################################################
# Linux systemd Firewall - firewalld https://firewalld.org/
# Remember to open proper firewall ports
#################################################################################
# Open firewall port for port 3306/tcp
sudo firewall-cmd --zone=public --add-port=3306/tcp --permanent 
# Open firewall port to allow only connections from 192.168.56.0/24
if [ $IP != 172 ]
then
  # Detect if we are in the Vagrant environement (third IP octet will be 56) or Proxmox environment -- will be 172
  # For VirtualBox
  sudo firewall-cmd --zone=public --add-source=192.168.56.0/24 --permanent
else
  # For Proxmox
  sudo firewall-cmd --zone=public --add-source=192.168.172.0/24 --permanent
fi
# Reload changes to firewall
sudo firewall-cmd --reload

#################################################################################
# Changing the mysql bind address with a script to listen for external 
# connections
# This is important because mysql by default only listens on localhost and needs
# to be configured to listen for external connections
# https://serverfault.com/questions/584607/changing-the-mysql-bind-address-within-a-script
# https://en.wikipedia.org/wiki/Sed
#################################################################################

if [ $IP != 172 ]
then
  # Detect if we are in the Vagrant environement (third IP octet will be 56) or Proxmox environment -- will be 172
  # If using mysql instead of MariaDB the path to the cnf file is /etc/mysql/mysql.conf.d/mysql.cnf
  # The command: $(cat /etc/hosts | grep db | awk '{ print $1 }') will retrieve the IP address of the db from the /etc/hosts file, a bit of a hack...
  # sudo sed -i "s/.*bind-address.*/#bind-address = $(cat /etc/hosts | grep team-$NUMBER-db-vm0 | awk '{ print $1 }')/" /etc/mysql/mysql.conf.d/mysql.cnf
  sudo sed -i "s/.*bind-address.*/bind-address = $(cat /etc/hosts | grep team-$NUMBER-db-vm0 | awk '{ print $1 }')/" /etc/mysql/mariadb.conf.d/50-server.cnf
else
  # Kind of a hack....
  sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf 
fi

#################################################################################
# To execute .sql files to create tables, databases, and insert records
# modern versions of mariadb and mysql don't have a root password for the root 
# user they control access via sudo permissions... which is great for security
# and automation
# These next 4 lines will create a simple database, a table, a non-root user
# with limited permissions (adjust accordingly) and finally insert 3 dummy records
#################################################################################

#################################################################################
# Using sed to replace placeholder variables in the code/db-samples/*.sql files
# with the USER variables passed from PACKER
# There isn't a cleaner way to do this but at least its verbose
#################################################################################
sed -i "s/\$ACCESSFROMIP/$ACCESSFROMIP/g" ./db-samples/*.sql
sed -i "s/\$USERPASS/$USERPASS/g" ./db-samples/*.sql
sed -i "s/\$USERNAME/$USERNAME/g" ./db-samples/*.sql

sudo mysql < /home/vagrant/team-00/code/db-samples/create-database.sql
sudo mysql < /home/vagrant/team-00/code/db-samples/create-table.sql
sudo mysql < /home/vagrant/team-00/code/db-samples/create-user-with-permissions.sql
sudo mysql < /home/vagrant/team-00/code/db-samples/insert-records.sql