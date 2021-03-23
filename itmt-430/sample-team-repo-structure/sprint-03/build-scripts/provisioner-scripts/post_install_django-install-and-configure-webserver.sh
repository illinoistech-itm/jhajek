#!/bin/bash

# Script to configure Django automatically out of the box
# Set the etc hosts values
echo "$WEBSERVERIP     frontend    frontend.class.edu"  | sudo tee -a /etc/hosts
echo "$DATABASESERVERIP    backend    backend.class.edu"    | sudo tee -a /etc/hosts

##############################################################################################
# Install Django pre-reqs
##############################################################################################
sudo apt-get install -y apache2 libexpat1 apache2-utils ssl-cert libapache2-mod-wsgi python3-dev python3-pip python3-setuptools

##############################################################################################
# Install Django mysqlclient library pre-reqs
##############################################################################################
sudo apt-get install -y default-libmysqlclient-dev build-essential
python3 -m pip install mysqlclient

##############################################################################################
# Inject all environment variables into a .my.cnf file
# Here we can construct the .my.cnf file and append the value to the .my.cnf file we will 
# create in the home directory
##############################################################################################
echo -e "[client]" >> /home/vagrant/.my.cnf
echo -e "database = $DATABASENAME" >> /home/vagrant/.my.cnf
echo -e "user = worker" >> /home/vagrant/.my.cnf
echo -e "password = $DBPASS" >> /home/vagrant/.my.cnf
echo -e "default-character-set = utf8" >> /home/vagrant/.my.cnf

##############################################################################################
# Install Django
##############################################################################################
python3 -m pip install django django-admin django-common

##############################################################################################
# Create Django project
##############################################################################################
django-admin startproject mysite

##############################################################################################
# CHANGE THE VALUES ~/2021-team-sample TO YOUR TEAM REPO AND ADJUST THE PATH ACCORDINGLY     #
# Adjust the paths below in line 35-37, and 44 and 46                                        #
##############################################################################################
sudo chown -R vagrant:vagrant ~/2021-team-sample

sudo cp -v /home/vagrant/2021-team-sample/sprint-03/code/django/settings.py /home/vagrant/mysite/mysite/

##############################################################################################
# Using sed to replace the blank settings value with the secret key
##############################################################################################

sed -i "s/SECRET_KEY = \'\'/SECRET_KEY = \'$DJANGOSECRETKEY\'/g" /home/vagrant/mysite/mysite/settings.py
sed -i "s/ALLOWED_HOSTS = []/ALLOWED_HOSTS = ['$WEBSERVERIP']/g" /home/vagrant/mysite/mysite/settings.py

##############################################################################################
# Create super user account from the ENV variables we passed in
##############################################################################################
python3 manage.py createsuperuser --noinput 

##############################################################################################
# Copy systemd start script to runserver at boot
##############################################################################################
sudo cp -v ~/2021-team-sample/sprint-03/code/django/django-server.service /lib/systemctl/system/
sudo systemctl enable django-server.service
sudo systemctl start django-server.service

##############################################################################################
# Set firewall section
# We will need to enable to port and the IP to receive a connection from for our system
##############################################################################################
# https://serverfault.com/questions/809643/how-do-i-use-ufw-to-open-ports-on-ipv4-only
# https://serverfault.com/questions/790143/ufw-enable-requires-y-prompt-how-to-automate-with-bash-script
ufw --force enable
ufw allow proto tcp to 0.0.0.0/0 port 22
ufw allow proto tcp to 80
ufw allow proto tcp to 443
ufw allow proto tcp to 8000
