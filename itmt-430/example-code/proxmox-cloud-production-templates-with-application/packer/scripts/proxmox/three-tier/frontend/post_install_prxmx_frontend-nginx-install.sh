#!/bin/bash

# Install and prepare frontend web server - Example for ExpressJS/NodeJS

sudo apt-get update
sudo apt-get install -y curl rsync nginx

# Just enable the service, it will start at boot when we deploy a 
# VM via Terraform
sudo systemctl enable nginx.service
