#!/bin/bash

# Installing Vault

# https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-install
sudo apt-get update
sudo apt-get install -y gpg

# https://www.hashicorp.com/official-packaging-guide
# Packaging Guide
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt-get install -y vault
