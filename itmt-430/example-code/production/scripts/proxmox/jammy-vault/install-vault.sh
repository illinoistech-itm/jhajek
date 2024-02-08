#!/bin/bash

sudo apt install -y gpg
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install -y vault

# Add default services 
echo "export VAULT_ADDR='https://127.0.0.1:8200'" >> /home/vagrant/.bashrc
echo "export VAULT_SKIP_VERIFY='true'" >> /home/vagrant/.bashrc

sudo firewall-cmd --zone=meta-network --add-port=8200/tcp --permanent
sudo firewall-cmd --reload
