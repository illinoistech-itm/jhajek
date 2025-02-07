#!/bin/bash

# Install and prepare frontend web server - Example for ExpressJS/NodeJS

sudo apt-get update
sudo apt-get install -y curl rsync

# Steps to add NodeJS repository to your Ubuntu Server for Node and NPM installation
# Remove and or replace with your required webserver stack
# https://github.com/nodesource/distributions/blob/master/README.md#using-ubuntu-2
curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
sudo -E bash nodesource_setup.sh
sudo apt-get install -y nodejs

# Change directory to the location of your JS code
cd /home/vagrant/team-00/code/express-static-app/

# Use NPM package manager to install needed dependecies to run our EJS app
# https://github.com/motdotla/dotenv -- create a .env file to pass environment variables
# dotenv mysql2 packages will be installed in the package.json file
sudo npm install -g --save express ejs pm2

# pm2.io is an applcation service manager for Javascript applications
# Using pm2 start the express js application as the user vagrant
sudo -u vagrant pm2 start server.js

# This creates your javascript application service file
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u vagrant --hp /home/vagrant

# This saves which files we have already started -- so pm2 will 
# restart them at boot
sudo -u vagrant pm2 save

###############################################################################
# Using Find and Replace via sed to add in the secrets to connect to MySQL
# There is a .env file containing an empty template of secrets -- essentially
# this is a hack to pass environment variables into the vm instances
###############################################################################

sudo sed -i "s/FQDN=/FQDN=$FQDN/" /home/vagrant/team-00/code/express-static-app/.env
sudo sed -i "s/DBUSER=/DBUSER=$DBUSER/" /home/vagrant/team-00/code/express-static-app/.env
sudo sed -i "s/DBPASS=/DBPASS=$DBPASS/" /home/vagrant/team-00/code/express-static-app/.env
sudo sed -i "s/DATABASE=/DATABASE=$DATABASE/" /home/vagrant/team-00/code/express-static-app/.env
