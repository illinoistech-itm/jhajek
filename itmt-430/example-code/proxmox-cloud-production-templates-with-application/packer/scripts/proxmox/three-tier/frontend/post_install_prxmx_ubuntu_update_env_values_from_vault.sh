#!/bin/bash 
set -e
set -v

##############################################################################
# Using Find and Replace via sed to add in the secrets to connect to MySQL
# There is a .env file containing an empty template of secrets -- essentially
# this is a hack to pass environment variables into the vm instances
###############################################################################

sudo sed -i "s/FQDN=/FQDN=$FQDN/" /home/flaskuser/.env
sudo sed -i "s/DBUSER=/DBUSER=$DBUSER/" /home/flaskuser/.env
sudo sed -i "s/DBPASS=/DBPASS=$DBPASS/" /home/flaskuser/.env
sudo sed -i "s/DATABASE=/DATABASE=$DATABASE/" /home/flaskuser/.env
