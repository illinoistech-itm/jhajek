#!/bin/bash

# Steps captured from https://www.digitalocean.com/community/tutorials/how-to-install-nginx-on-ubuntu-16-04vagr
# https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-ubuntu-14-04

# Set-up Nginx reverse proxy web server

# #update the apt-get package lists
sudo apt-get update
sudo apt install net-tools

# Install Nginx
# https://askubuntu.com/questions/394746/apt-get-purge-install-nginx-reports-success-but-not-installed-12-04
sudo apt-get purge nginx-common -y
sudo apt-get install nginx -y



# Add derver to hostname
sudo chown vagrant /etc/hosts
echo "192.168.50.11  nginx-web-server" >> /etc/hosts
echo "192.168.50.12  node-application-server" >> /etc/hosts
echo "192.168.50.13  mongodb-server" >> /etc/hosts
echo "192.168.50.14  mongodb-rep1-server" >> /etc/hosts
echo "192.168.50.15  redis-caching-server" >> /etc/hosts


# Copy the configuration from /etc/nginx/sites-available to /etc/nginx/sites-enabled using a symbolic link.
sudo ln -s /etc/nginx/sites-available/reverse-proxy.conf /etc/nginx/sites-enabled/reverse-proxy.conf
echo "Symbolic link created..."
