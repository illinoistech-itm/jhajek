#!/bin/bash 
set -e
set -v

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
# pm2 is the way to start nodejs applications at boot
npm install pm2@latest -g
# To setup the Startup Script, copy/paste the following command:
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u vagrant --hp /home/vagrant
# Install needed dependency
npm install react-scripts

cd /home/vagrant/2021-team-sample/sprint-02/code/ReactMultiPageWebsite
# Get project dependencies (npm packages)
npm install
# This will cause the app to autostart on subsequent reboots and launch the app on 192.168.33.33:3000
pm2 start --name reactjs-project npm -- start --host 192.168.33.33
