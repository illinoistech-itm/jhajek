#!/bin/bash

# Steps captured from https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-14-04
# Steps for downloading node captured from https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-18-04

# Installing Node.js on the app server

# Update the apt-get package lists
sudo apt-get update
sudo apt install build-essential
sudo apt install net-tools

# Install the git package, which npm depends on
sudo apt-get install git

# Add derver to hostname
sudo chown vagrant /etc/hosts
echo "192.168.50.11  nginx-web-server" >> /etc/hosts
echo "192.168.50.12  node-application-server" >> /etc/hosts
echo "192.168.50.13  mongodb-server" >> /etc/hosts
echo "192.168.50.14  mongodb-rep1-server" >> /etc/hosts
echo "192.168.50.15  redis-caching-server" >> /etc/hosts

# Install the NodeSource PPA in order to get access to its contents into the home directory
cd ~
curl -sL https://deb.nodesource.com/setup_11.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs

# Verify installation by printing versions
node_version=$(nodejs -v)
npm_version=$(npm -v)
echo "Node versrion: $node_version"
echo "Npm version: $npm_version"

# Download app
cat <<EOT > ~/hello.js
var http = require("http");
http
  .createServer(function(req, res) {
    res.writeHead(200, { "Content-Type": "text/plain" });
    res.end("Hello World\n");
  })
  .listen(8080, "192.168.50.12");
console.log("Server running at http://192.168.50.12:8080/");
EOT

# Installing PM2 which is a process manager for node applications
sudo npm install pm2 -g
pm2 startup ubuntu
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup ubuntu -u vagrant --hp /home/vagrant

# Installing Passport.js, middleware for authentication.
npm install passport -g
# Installing oauth for 3rd Party Sign ins. Will Utilize Google and Facebook
npm install passport-oauth -g
# Installing Oauth for Facebook. Note, dev account needs to be created still
npm install passport-facebook -g
# Installing Oauth for Google. Note, dev account needs to be created still
npm install passport-google-oauth -g

# Installing Net Data which is a resource management tool for servers.
cd ~
wget https://my-netdata.io/kickstart.sh 
bash kickstart.sh --dont-wait
