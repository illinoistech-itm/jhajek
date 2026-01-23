#!/bin/bash

# Install the AWS CLIv2
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
# This is for x86 Intel/AMD based Linux
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# For ARM/Apple Silicon M-based Linux
# curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip
# sudo ./aws/install

# Install all the needed (and different from 22.04) dependencies via apt on 
# Ubuntu 24.04

sudo apt install vim git python3-dev python3-pip python3-setuptools build-essential python3-boto python3-bs4 python3-tqdm python3-requests python3-mysql.connector

# Install Terraform on Ubuntu 24.04 Linux
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update

sudo apt-get install terraform
