#!/bin/bash

# Install and prepare frontend web server

sudo apt-get update
sudo apt-get install -y nginx curl rsync

# How to generate a self-signed TLS cert

# https://github.com/nodesource/distributions/blob/master/README.md#using-ubuntu-2
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# Upgrade to latest NPM
#sudo npm install -g npm@9.4.2

# Install expressjs and pm2 as the vagrant user
sudo -u vagrant npm install express@4.17.1 ejs@3.1.6 pm2


