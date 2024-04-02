#!/bin/bash
##############################################################################################
# This is where you would update or open new firewall ports.
# By default is open:
# Port 22 for SSH
# port 8301 and 8500 are the Gossip protocol and for the instance to be able to 
# register with the Consul DNS service 
# Instances will be using firewalld
##############################################################################################
echo "Printing current network status information..."

echo "Update SSH rules"
echo "AllowTcpForwarding no" | sudo tee /etc/ssh/sshd_config.d/60-ots-customization.conf
echo "Ciphers -chacha20-poly1305@openssh.com" | sudo tee /etc/ssh/sshd_config.d/disable_chacha20-poly1305.conf
sudo chmod 600 /etc/ssh/sshd_config.d/disable_chacha20-poly1305.conf
sudo systemctl daemon-reload
sudo systemctl restart ssh

sudo apt-get update
sudo apt-get install -y firewalld

sudo systemctl enable firewalld
sudo systemctl start firewalld
##############################################################################################
# sudo firewall-cmd --zone=public --add-interface=ens18 --permanent
# Creates a zone that restricts traffic to that one interface ens18
##############################################################################################
sudo firewall-cmd --zone=public --add-interface=eno1 --permanent
sudo firewall-cmd --zone=public --add-service=ssh --permanent

# Create new zone on ens19 called metrics-network for just metrics
sudo firewall-cmd --new-zone=metrics-network --permanent
# Attach interface ens19 (eth1) to the new zone
sudo firewall-cmd --zone=metrics-network --change-interface=eno2 --permanent
# Created entry for Prometheus
# sudo firewall-cmd --zone=metrics-network --add-port=9100/tcp --permanent

# Create new zone on ens20 called meta-network for a non-routable internal network
sudo firewall-cmd --new-zone=meta-network --permanent
# Attach interface ens20 (eth2) to the new zone
sudo firewall-cmd --zone=meta-network --change-interface=enp5s0 --permanent

# Consul ports needed for Gossip protocol on the LAN
# https://www.consul.io/docs/install/ports
# Clients only need 8301 tcp & udp to communicate and Gossip with each other

sudo firewall-cmd --zone=meta-network --add-port=8301/tcp --permanent
sudo firewall-cmd --zone=meta-network --add-port=8301/udp --permanent

# Created entry for Node_exporter to be availabe for scraping
sudo firewall-cmd --zone=meta-network --add-port=9100/tcp --permanent
sudo firewall-cmd --zone=meta-network --add-port=30000-52000/tcp --permanent
sudo firewall-cmd --zone=public --add-service=ssh --permanent

# Creating the data network interface
sudo firewall-cmd --new-zone=data-network --permanent
sudo firewall-cmd --zone=meta-network --change-interface=enp4s0 --permanent
##############################################################################################
# Add any additional firewall ports below this line in this format:
# sudo firewall-cmd --zone=public --add-port=####/tcp --permanent
# sudo firewall-cmd --zone=public --add-port=####/udp --permanent
##############################################################################################
sudo firewall-cmd --reload
