#!/bin/bash

# Git clone
sudo rm -rf /vagrant/repo/
git clone git@github.com:illinoistech-itm/2019-team-09f.git /vagrant/repo/

# cd /vagrant/repo/app/server/; sudo npm install

# cd /vagrant/repo/app/client/; sudo npm install

cd /vagrant/repo/app/server
sudo npm run npm-install-linux

# Start app
# sudo chown vagrant:vagrant /home/vagrant/.pm2/rpc.sock /home/vagrant/.pm2/pub.sock
sudo pm2 stop 0
sudo NODE_ENV=production pm2 start /vagrant/repo/app/server/server.js

# sudo npm run production-server
echo "[NODE] server running..."
