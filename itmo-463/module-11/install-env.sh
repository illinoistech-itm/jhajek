#!/bin/bash

sudo apt update
sudo apt install -y nginx git

sudo systemctl enable nginx
sudo systemctl start nginx

# Cloning private repo over ssh
echo "Beginning clone operation..."
sudo -u ubuntu git clone git@github.com:illinoistech-itm/hajek.git
