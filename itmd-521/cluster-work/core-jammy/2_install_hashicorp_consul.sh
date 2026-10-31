#!/bin/bash

# script to install hashicorp consul for Proxmox servers

wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install -y consul

sudo systemctl stop consul.service
echo 'retry_join = ["10.110.0.88","10.110.0.89","10.110.0.90"]' | sudo tee -a /etc/consul.d/consul.hcl
sudo sed -i "1,$s/#datacenter = \'my-dc-1\'/datacenter = \'mies-dc-1\'/" /etc/consul.d/consul.hcl
sudo sed -i "1,$s/changeme/$RANDOM/" /etc/consul.d/system.hcl
sudo sed -i "1,$s/replace-name/$(hostname)/" /etc/consul.d/system.hcl

sudo cp -v ../jammy-services/system.hcl /etc/consul.d/
sudo cp -v ../jammy-services/node-exporter-consul-service.json /etc/consul.d/
sudo systemctl enable consul.service
