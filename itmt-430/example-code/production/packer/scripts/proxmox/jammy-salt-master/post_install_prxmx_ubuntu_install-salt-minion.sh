#!/bin/bash

# Installing Salt Minion
# https://docs.saltproject.io/en/getstarted/fundamentals/install.html
echo "Installing salt master..."
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sudo sh install_salt.sh

sudo systemctl stop salt-minion.service

sudo sed -i '1,$s/#master: salt/master: salt-vm0.service.consul/g' /etc/salt/minion
