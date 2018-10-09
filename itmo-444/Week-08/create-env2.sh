#!/bin/bash

sudo apt-get update
sudo apt-get install -y apache2 git

cd /var/www/html
sudo git clone https://github.com/illinoistech-itm/jhajek.git 

# command to copy index.html to /ver/www/html
