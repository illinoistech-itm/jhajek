#!/bin/bash

# script to install hashicorp consul for Proxmox servers

wget -O- http://10.0.0.40/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] http://10.0.0.40/hashicorp $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install -y consul

sudo systemctl stop consul.service
echo 'retry_join = ["10.110.0.59","10.110.0.58","10.110.0.38"]' | sudo tee -a /etc/consul.d/consul.hcl
sudo sed -i '1,$s/#datacenter = "my-dc-1"/datacenter = "rice-dc-1"/' /etc/consul.d/consul.hcl
sudo sed -i "1,$s/changeme/$RANDOM/" /etc/consul.d/system.hcl
sudo sed -i "1,$s/replace-name/$(hostname)/" /etc/consul.d/system.hcl

sudo mv -v ../jammy-services/system.hcl /etc/consul.d/
sudo mv -v ../jammy-services/node-exporter-consul-service.json /etc/consul.d/
sudo systemctl enable --now consul.service
