#!/bin/bash

# Install and prepare backend database

sudo apt update
sudo apt-get install -y mariadb-server-10.6

## During the Terraform apply phase -- we will make some run time adjustments
# to configure the database to listen on the meta-network interface only

#############################################################################
# Using the variables you are passing via the variables.pkr.hcl file, you can
# access those variables as Linux ENVIRONMENT variables, use find and replace
# via sed and inline execute an inline mysql command
# Albiet this looks a bit hacky -- but it allows us not to hard code 
# secrets into our systems when building your backend template 
#############################################################################

# Change directory to the location of your JS code
cd /home/vagrant/team-00/code/db-samples

# Inline MySQL code that uses the secrets passed via the ENVIRONMENT VARIABLES to create a non-root user
# IPRANGE is "10.110.%.%"
echo "Executing inline mysql -e to create user..."
sudo mysql -e "GRANT SELECT,INSERT,CREATE TEMPORARY TABLES ON posts.* TO '${DBUSER}'@'${IPRANGE}' IDENTIFIED BY '${DBPASS}';"

# Inlein mysql to allow the USERNAME you passed in via the variables.pkr.hcl file to access the Mariadb/MySQL commandline 
# for debugging purposes only to connect via localhost (or the mysql CLI)

sudo mysql -e "GRANT SELECT,INSERT,CREATE TEMPORARY TABLES ON posts.* TO '${DBUSER}'@'localhost' IDENTIFIED BY '${DBPASS}';"

# These sample files are located in the mysql directory but need to be part of 
# your private team repo
sudo mysql < ./create-database.sql
sudo mysql < ./create-table.sql
sudo mysql < ./insert-records.sql