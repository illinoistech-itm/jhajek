#!/bin/bash

# Install and prepare frontend web server - Example for ExpressJS/NodeJS

sudo apt-get update
sudo apt-get install -y curl rsync

# Steps to add NodeJS repository to your Ubuntu Server for Node and NPM installation
# Remove and or replace with your required webserver stack
# https://github.com/nodesource/distributions/blob/master/README.md#using-ubuntu-2
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# Upgrade to latest NPM
sudo -u vagrant npm install -g pm2
sudo npm install -g express ejs
# pm2.io is an applcation service manager for Javascript applications
sudo -u vagrant pm2 start server.js
sudo -u vagrant pm2 save

