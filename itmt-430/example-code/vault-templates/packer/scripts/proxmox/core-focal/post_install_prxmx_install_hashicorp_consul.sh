#!/bin/bash

# script to install hashicorp consul for Proxmox servers

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install -y consul

sudo systemctl stop consul.service
sudo mv -v /home/vagrant/system.hcl /etc/consul.d/
sudo systemctl enable consul.service
