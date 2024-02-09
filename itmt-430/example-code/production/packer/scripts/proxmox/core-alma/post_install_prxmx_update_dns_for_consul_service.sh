#!/bin/bash

# https://developer.hashicorp.com/consul/tutorials/networking/dns-forwarding?utm_source=docs#systemd-resolved-setup

echo "Copying the systemd-resolved DNS configuration for the .consul domain lookup"
sudo mkdir /etc/systemd/resolved.conf.d/
sudo cp -v /home/vagrant/consul.conf /etc/systemd/resolved.conf.d/consul.conf

sudo systemctl daemon-reload
sudo systemctl restart systemd-resolved
