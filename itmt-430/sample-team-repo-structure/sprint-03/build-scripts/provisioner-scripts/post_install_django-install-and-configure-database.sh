#!/bin/bash

# Script to configure Django automatically out of the box
# Set the etc hosts values
echo "$WEBSERVERIP     frontend    frontend.class.edu"  | sudo tee -a /etc/hosts
echo "$DATABASESERVERIP    backend    backend.class.edu"    | sudo tee -a /etc/hosts

# Install python3 and pip3 for django database restoration
sudo apt-get update
sudo apt-get install -y python3-dev python3-pip python3-setuptools
###########################################################################
# Django Backup and restore program
########################################################################### 
#https://pypi.org/project/django-dbbackup/
python3 -m pip install django-dbbackup

########################################################################### 
# Install Mariadb 
########################################################################### 
sudo apt-get update
sudo apt-get install -y mariadb-server 

########################################################################### 
# If using MySQL Server
########################################################################### 
# sudo apt-get update
# sudo apt-get install -y mysql-server 

##############################################################################################
# Changing the mysql bind address with a script
# https://serverfault.com/questions/584607/changing-the-mysql-bind-address-within-a-script
# https://stackoverflow.com/questions/23670282/bind-address-missing-in-my-cnf-in-mysql-centos
# https://en.wikipedia.org/wiki/Sed
##############################################################################################
sudo sed -i "s/.*bind-address.*/bind-address = $DATABASESERVERIP/" /etc/mysql/mariadb.conf.d/50-server.cnf 

########################################################################### 
# Enable and start the service 
########################################################################### 
sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service

########################################################################### 
# If Using MySQL
# sudo systemctl enable mysql.service
# sudo systemctl start mysql.service
########################################################################### 
# If using mysql instead of MariaDB the path to the cnf file is /etc/mysql/mysql.conf.d/mysql.cnf
# sudo sed -i "s/.*bind-address.*/bind-address = $DATABASESERVERIP/" /etc/mysql/mysql.conf.d/mysql.cnf

##############################################################################################
# CHANGE THE VALUES ~/2021-team-sample TO YOUR TEAM REPO AND ADJUST THE PATH ACCORDINGLY     #
# Adjust the paths below in line 35-37, and 44 and 46                                        #
##############################################################################################
sudo chown -R vagrant:vagrant ~/2021-team-sample
##############################################################################################

# Here we are going to use the sed command to do a find and replace of placeholder variables
# This is so we can dynamically create usernames and passwords and not have to hardcode these values
# Using sed to replace variables in the scripts with the ENV variables passed
sed -i "s/\$ACCESSFROMIP/$ACCESSFROMIP/g" ~/2021-team-sample/sprint-03/code/db/*.sql
sed -i "s/\$USERPASS/$USERPASS/g" ~/2021-team-sample/sprint-03/code/db/*.sql
sed -i "s/\$DATABASENAME/$DATABASENAME/g" ~/2021-team-sample/sprint-03/code/db/*.sql
##############################################################################################
# This next section will then execute the .sql files, with their placeholder values replaced, 
# and execute the scripts that will create out database and create a user, with proper privilleges 
# allowed
##############################################################################################
# This script will create the database named posts in the mariadb server
sudo mysql -u root < ~/2021-team-sample/sprint-03/code/db/create-database.sql
# This script will create the non-root user named worker and the user for replication
sudo mysql -u root < ~/2021-team-sample/sprint-03/code/db/create-user-with-permissions.sql

##############################################################################################
# Set firewall section
# We will need to enable to port and the IP to receive a connection from for our system
##############################################################################################
# https://serverfault.com/questions/809643/how-do-i-use-ufw-to-open-ports-on-ipv4-only
# https://serverfault.com/questions/790143/ufw-enable-requires-y-prompt-how-to-automate-with-bash-script
ufw --force enable
ufw allow proto tcp to 0.0.0.0/0 port 22
ufw allow from $FIREWALLACCESS to any port 3306
