#!/bin/bash 
set -e
set -v

##############################################################################################
# Add any additional firewall ports below this line in this format:
# sudo firewall-cmd --zone=public --add-port=####/tcp --permanent
# sudo firewall-cmd --zone=public --add-port=####/udp --permanent
##############################################################################################
# Allow for DHCP
#sudo firewall-cmd --zone=public --add-service=dhcp --permanent

# Allow for DHCP
sudo firewall-cmd --zone=metrics-network --add-service=dhcp --permanent

# Allow for DHCP
sudo firewall-cmd --zone=meta-network --add-service=dhcp --permanent

sudo firewall-cmd --reload
