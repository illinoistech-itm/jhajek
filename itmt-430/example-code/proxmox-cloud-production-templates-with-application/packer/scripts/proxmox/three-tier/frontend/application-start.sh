#!/bin/bash

cd /home/vagrant/team-00/code/express-static-app/

# run the npm install command to retrieve required express dependencies
# this will retrieve all the NPM packages listed in the package.json file
# and create the node_modules folder -- you don't want to be pushing 
# node_modules around in version control
echo "Installing the javascript packages for ejs..."
sudo npm install
