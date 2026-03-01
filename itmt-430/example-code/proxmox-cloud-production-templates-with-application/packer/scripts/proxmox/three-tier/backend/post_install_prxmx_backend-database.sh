#!/bin/bash

# Install and prepare backend database

sudo apt update
sudo apt install -y mariadb-server

# Required to have the mariadb.service start at boot time
sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service
## During the Terraform apply phase -- we will make some run time adjustments
# to configure the database to listen on the meta-network interface only
