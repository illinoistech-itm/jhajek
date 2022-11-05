#!/bin/bash

# Install dependecies here:

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && sudo apt-get install -y nodejs

# Run NPM to install the NPM Node packages needed for the code
# You will start this NodeJS script by executing the command: node app.js
# from the directory where app.js is located. The program `pm2` can be
# used to auto start NodeJS applications (as they don't have a normal
# systemd service handler).
# <https://pm2.keymetrics.io/docs/usage/quick-start/>. This will require
# the install of PM2 via npm as well.
cd /home/ubuntu
sudo -u ubuntu npm install express aws-sdk multer multer-s3
sudo npm install pm2 -g

# Command to clone your private repo via SSH usign the Private key
####################################################################
# Note - change "hajek.git" to be your private repo name (hawk ID) #
####################################################################
sudo -u ubuntu git clone git@github.com:illinoistech-itm/jhajek.git

# Start the nodejs app where it is located via PM2
# https://pm2.keymetrics.io/docs/usage/quick-start
cd /home/ubuntu/jhajek/itmo-444-544/mp1/

sudo pm2 start app.js

# Delete the RSA private key once setup is finished
rm /home/ubuntu/.ssh/id_ed25519

