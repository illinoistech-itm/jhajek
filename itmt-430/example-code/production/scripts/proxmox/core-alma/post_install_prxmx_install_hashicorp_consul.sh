#!/bin/bash

# script to install hashicorp consul for Proxmox servers

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
# https://www.shellhacks.com/yum-install-specific-version-of-package
sudo yum -y install consul

sudo mv -v /home/vagrant/system.hcl /etc/consul.d/
sudo systemctl enable consul.service
sudo systemctl daemon-reload
sudo systemctl restart consul
sudo systemctl status consul
