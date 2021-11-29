#!/bin/bash

# Shell Script used to install that application and business logic

## Command to clone your own @hawk ID private repo with all the configuration files
# This will clone your HAWK repo code -- you need to change sample-student to your HAWK account
git clone git@github.com:illinoistech-itm/sample-student.git /home/ubuntu/sample-student

# Change permission of the cloned repo to that of the user: ubuntu
# Need to change the path to your HAWK address in /home/ubuntu
sudo chown -R ubuntu:ubuntu /home/ubuntu/sample-student

# Install Node.js
# V16 LTS from https://github.com/nodesource/distributions/blob/master/README.md
# Using Ubuntu
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# Using NPM to install PM2 a process manager for our nodejs app
npm install pm2 -g

# Use NPM to install the needed packages from the package.json file
# Need to change the path to match your HAWK account and match the path
cd /home/ubuntu/sample-student/itmo-444/mp2/

sudo npm install 

# Start the app.js application automatically
sudo pm2 start app.js

#PM2 - https://pm2.keymetrics.io/
