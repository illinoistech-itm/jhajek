#!/bin/bash

# Install and prepare frontend web server - Example for ExpressJS/NodeJS

sudo apt-get update
sudo apt-get install -y curl rsync

# Steps to add NodeJS repository to your Ubuntu Server for Node and NPM installation
# Remove and or replace with your required webserver stack
# https://github.com/nodesource/distributions/blob/master/README.md#using-ubuntu-2
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g npm@9.6.0

# Upgrade to latest NPM
sudo npm install -g express ejs pm2
# pm2.io is an applcation service manager for Javascript applications
cd /home/vagrant/team-00/code/express-static-app/
sudo pm2 start server.js
sudo pm2 save

