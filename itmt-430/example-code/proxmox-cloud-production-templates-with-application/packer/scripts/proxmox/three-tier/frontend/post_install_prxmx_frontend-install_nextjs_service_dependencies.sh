#!/bin/bash

# Use NPM package manager to install needed dependencies to run our Next JS app
# PM2.io is a process manager for javascript applications
sudo npm install -g --save pm2

# This saves which files we have already started -- so pm2 will 
# restart them at boot
pm2 start npm --name "project2" -- run start

sudo -u vagrant pm2 save
sudo -u vagrant pm2 startup
