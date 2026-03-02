#!/bin/bash

# Install and prepare backend database
echo "############ Installing Maria DB Server #####################"
sudo apt update
sudo apt install -y mariadb-server
echo "############ Install of Maria DB Server Complete #####################"
# Required to have the mariadb.service start at boot time
sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service
## During the Terraform apply phase -- we will make some run time adjustments
# to configure the database to listen on the meta-network interface only
