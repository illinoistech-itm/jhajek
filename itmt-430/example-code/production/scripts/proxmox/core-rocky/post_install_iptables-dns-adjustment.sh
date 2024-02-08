#!/bin/bash

# The main limitation with this configuration is that the DNS field cannot contain ports. So for this to work either Consul must be configured to listen on port 53 instead of 8600 or you can use iptables to map port 53 to 8600. The following iptables commands are sufficient to do the port mapping.

sudo iptables -t nat -A OUTPUT -d localhost -p udp -m udp --dport 53 -j REDIRECT --to-ports 8600
sudo iptables -t nat -A OUTPUT -d localhost -p tcp -m tcp --dport 53 -j REDIRECT --to-ports 8600

# Structure to keep the iptables adjusted DNS entries
# https://askubuntu.com/questions/1252275/ubuntu-20-04-cant-persist-the-iptables-configuration
# install nftables 
# https://askubuntu.com/questions/1252275/ubuntu-20-04-cant-persist-the-iptables-configuration
# https://wiki.nftables.org/wiki-nftables/index.php/Moving_from_iptables_to_nftables
sudo yum install -y nftables
if [ -d /etc/iptables ]; then
  echo "Directory /etc/iptables exists... moving on\n"
else 
  sudo mkdir -p /etc/iptables
  echo "Directory /etc/iptables created succesfully.\n"
fi
sudo /sbin/iptables-save | sudo tee /etc/iptables/rules.v4 
sudo iptables-restore-translate -f /etc/iptables/rules.v4 > ruleset.nft
sudo nft -f ruleset.nft
