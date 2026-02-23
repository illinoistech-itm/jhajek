#!/bin/bash

# Install and prepare backend database

sudo apt update
sudo apt-get install -y mariadb-server-10.6

## During the Terraform apply phase -- we will make some run time adjustments
# to configure the database to listen on the meta-network interface only
