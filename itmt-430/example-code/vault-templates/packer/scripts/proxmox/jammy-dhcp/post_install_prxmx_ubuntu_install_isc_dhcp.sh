#!/bin/bash

# Install ISC DHCP server

sudo apt-get update
sudo apt-get install -y isc-dhcp-server

# Copy current dhcp configuration over to new system
sudo mv /home/vagrant/dhcpd.conf /etc/dhcp/dhcpd.conf
sudo systemctl daemon-reload

sudo systemctl enable isc-dhcp-server
sudo systemctl start isc-dhcp-server
