#!/bin/bash

# Install dependecies here:

##############################################################################
# Installing Git client from apt
# Install Nginx webserver to proxy requests from port 80 to 3000
##############################################################################
sudo apt update -y
sudo apt install git build-essential nginx -y

##############################################################################
# Enable and start Nginx service
##############################################################################
sudo systemctl enable nginx
sudo systemctl start nginx

sudo apt-get update -y
sudo apt-get install ca-certificates curl gnupg -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

NODE_MAJOR=18
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt-get update -y
sudo apt-get install nodejs -y

# Run NPM to install the NPM Node packages needed for the code
# You will start this NodeJS script by executing the command: node app.js
# from the directory where app.js is located. The program `pm2` can be
# used to auto start NodeJS applications (as they don't have a normal
# systemd service handler).
# <https://pm2.keymetrics.io/docs/usage/quick-start/>. This will require
# the install of PM2 via npm as well.
cd /home/ubuntu
sudo -u ubuntu npm install @aws-sdk/client-s3 @aws-sdk/client-sns @aws-sdk/client-rds @aws-sdk/client-secrets-manager @aws-sdk/client-dynamodb express multer multer-s3 mysql2
sudo npm install pm2 -g

# Command to clone your private repo via SSH usign the Private key
####################################################################
# Note - change "hajek.git" to be your private repo name (hawk ID) #
####################################################################
sudo -u ubuntu git clone git@github.com:illinoistech-itm/jhajek.git

# Start the nodejs app where it is located via PM2
# https://pm2.keymetrics.io/docs/usage/quick-start
cd /home/ubuntu/jhajek/itmo-444-544/mp2/544

sudo cp /home/ubuntu/jhajek/itmo-444-544/mp2/544/default /etc/nginx/sites-available/default
sudo systemctl daemon-reload
sudo systemctl restart nginx

sudo pm2 start app.js

# Delete the RSA private key once setup is finished
rm /home/ubuntu/.ssh/id_ed25519
