#!/bin/bash

# script to install hashicorp consul for Proxmox servers

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install -y consul

sudo systemctl stop consul.service
sudo mv -v /home/vagrant/system.hcl /etc/consul.d/
sudo mv -v /home/vagrant/node-exporter-consul-service.json /etc/consul.d/
sudo systemctl enable consul.service
