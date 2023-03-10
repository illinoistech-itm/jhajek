#!/bin/bash

# Install and prepare backend database

sudo apt update
sudo apt-get install -y mariadb-server

## During the Terraform apply phase -- we will make some run time adjustments
# to configure the database to listen on the meta-network interface only

# Change directory to the location of your JS code
cd /home/vagrant/team-00/code/db-samples

# These sample files are located in the mysql directory but need to be part of 
# your private team repo
sudo mysql < ./create-database.sql
sudo mysql < ./create-table.sql
sudo mysql < ./insert-records.sql