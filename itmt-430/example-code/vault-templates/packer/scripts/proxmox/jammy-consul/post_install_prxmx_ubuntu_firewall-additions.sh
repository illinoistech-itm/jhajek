#!/bin/bash 
set -e
set -v

##############################################################################################
# Add any additional firewall ports below this line in this format:
# sudo firewall-cmd --zone=public --add-port=####/tcp --permanent
# sudo firewall-cmd --zone=public --add-port=####/udp --permanent
##############################################################################################

# Adding Server ports to receive consul traffic
# https://stackoverflow.com/questions/30684262/different-ports-used-by-consul
sudo firewall-cmd --zone=meta-network --add-port=8300/tcp --permanent
sudo firewall-cmd --zone=meta-network --add-port=8500/tcp --permanent

# Restart the firewall to reload the rules
sudo firewall-cmd --reload

