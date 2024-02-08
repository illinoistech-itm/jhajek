#!/bin/bash
##############################################################################################
# This is where you would update or open new firewall ports.
# By default is open:
# Port 22 for SSH
# port 8301 and 8500 are the Gossip protocol and for the instance to be able to 
# register with the Consul DNS service 
# Instances will be using firewalld
##############################################################################################
sudo apt-get update
sudo apt-get install -y firewalld

sudo systemctl enable firewalld
sudo systemctl start firewalld
##############################################################################################
# sudo firewall-cmd --zone=public --add-interface=ens18 --permanent
# Creates a zone that restricts traffic to that one interface ens18
##############################################################################################
sudo firewall-cmd --zone=public --add-interface=ens18 --permanent
sudo firewall-cmd --zone=public --add-service=ssh --permanent
# Turn off IPv6 DHCP client port
sudo firewall-cmd --zone=public --remove-service=dhcpv6-client --permanent 

# Create new zone on ens19 called metrics-network for just metrics
sudo firewall-cmd --new-zone=metrics-network --permanent
# Attach interface ens19 (eth1) to the new zone
sudo firewall-cmd --zone=metrics-network --change-interface=ens19 --permanent

# Create new zone on ens20 called meta-network for a non-routable internal network
sudo firewall-cmd --new-zone=meta-network --permanent
# Attach interface ens20 (eth2) to the new zone
sudo firewall-cmd --zone=meta-network --change-interface=ens20 --permanent

# Consul ports needed for Gossip protocol on the LAN
# https://www.consul.io/docs/install/ports

sudo firewall-cmd --zone=meta-network --add-port=8301/tcp --permanent
sudo firewall-cmd --zone=meta-network --add-port=8500/tcp --permanent
##############################################################################################
# Add any additional firewall ports below this line in this format:
# sudo firewall-cmd --zone=public --add-port=####/tcp --permanent
# sudo firewall-cmd --zone=public --add-port=####/udp --permanent
##############################################################################################
sudo firewall-cmd --reload