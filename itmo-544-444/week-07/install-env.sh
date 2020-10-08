#!/bin/bash

# Install dependecies here:

sudo apt-get update
sudo apt-get install -y nodejs npm 

# Run NPM to install the NPM Node packages needed for the code
# You will start this NodeJS script by executing the command: node app.js
# from the directory where app.js is located. The program `pm2` can be
# used to auto start NodeJS applications (as they don't have a normal
# systemd service handler).
# <https://pm2.keymetrics.io/docs/usage/quick-start/>. This will require
# the install of PM2 via npm as well.

npm install express aws-sdk multer multer-s3 pm2 

# Command to clone your private repo via SSH usign the Private key 
# Note - change "hajek.git" to be your private repo name (hawk ID)
git clone git@github.com:illinoistech-itm/hajek.git

# Start the nodejs app where it is located via PM2
# https://pm2.keymetrics.io/docs/usage/quick-start
