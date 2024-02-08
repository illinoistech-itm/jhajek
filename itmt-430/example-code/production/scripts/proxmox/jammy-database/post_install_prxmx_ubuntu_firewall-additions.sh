#!/bin/bash 
set -e
set -v

##############################################################################################
# Add any additional firewall ports below this line in this format:
# sudo firewall-cmd --zone=public --add-port=####/tcp --permanent
# sudo firewall-cmd --zone=public --add-port=####/udp --permanent
##############################################################################################
# Firewall ports for mariadb and postgresql
sudo firewall-cmd --zone=meta-network --add-port=3306/tcp --permanent
sudo firewall-cmd --zone=meta-network --add-port=5432/tcp --permanent

sudo firewall-cmd --reload
