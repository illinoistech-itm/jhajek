#!/bin/bash
set -e
set -v

# http://superuser.com/questions/196848/how-do-i-create-an-administrator-user-on-ubuntu
# http://unix.stackexchange.com/questions/1416/redirecting-stdout-to-a-file-you-dont-have-write-permission-on
# This line assumes the user you created in the preseed directory is vagrant
echo "%admin  ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/init-users
sudo groupadd admin
sudo usermod -a -G admin vagrant

sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install -y links firewalld

sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --add-service=ssh --permanent
# Consul ports needed for Gossip protocol on the LAN
# https://www.consul.io/docs/install/ports
sudo firewall-cmd --add-port=8301/tcp --permanent
sudo firewall-cmd --add-port=8500/tcp --permanent
sudo firewall-cmd --add-port=9001/tcp --permanent
sudo firewall-cmd --reload

# https://github.com/hashicorp/terraform-provider-vsphere/issues/516
# Remove /etc/machine-id so that all the cloned machines will get their own IP address upon DHCP request
sudo rm -f /etc/machine-id
sudo touch /etc/machine-id

##################################################
# https://min.io/download#/linux
##################################################
sudo apt-get update
# Installing ZFS library
sudo apt-get install -y zfsutils-linux

wget https://dl.min.io/server/minio/release/linux-amd64/minio_20210730000200.0.0_amd64.deb
dpkg -i minio_20210730000200.0.0_amd64.deb
