#!/bin/bash

cd /home/vagrant/team-00/code/express-static-app/

# run the npm install command to retrieve required express dependencies
# this will retrieve all the NPM packages listed in the package.json file
# and create the node_modules folder -- you don't want to be pushing 
# node_modules around in version control
npm install

# pm2.io is an applcation service manager for Javascript applications
sudo -u vagrant pm2 start server.js
sudo -u vagrant pm2 save


