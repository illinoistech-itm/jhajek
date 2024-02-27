#!/bin/bash

# script to install hashicorp consul for Proxmox servers

wget -O- http://10.0.0.40/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
#echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] http://10.0.0.40/hashicorp $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install -y consul

sudo systemctl stop consul.service
sudo mv -v /home/vagrant/system.hcl /etc/consul.d/
sudo mv -v /home/vagrant/node-exporter-consul-service.json /etc/consul.d/
sudo systemctl enable consul.service

echo "Sleeping for 5 seconds..."
sleep 5

# Logic to check for presence of /etc/consul.d/consul.hcl file
if [ -e /etc/consul.d/consul.hcl ]
  then
    echo "The file /etc/consul.d/consul.hcl exists..."
  else
    echo "The file /etc/consul.d/consul.hcl doesn't exist... something has happened with the installation of consul... throwing an error to kill the build process..."
    exit 1
fi
