#!/bin/bash 
set -e
set -v

##################################################################################################
# Install OSS Grafana server
# https://grafana.com/grafana/download?pg=oss-graf&plcmt=resources&edition=oss
##################################################################################################

sudo apt-get install -y adduser libfontconfig1 musl
wget https://dl.grafana.com/oss/release/grafana_10.2.0_amd64.deb
sudo dpkg -i grafana_10.2.0_amd64.deb

##################################################################################################
# Enable the services to start at boot
##################################################################################################
sudo systemctl enable grafana-server.service
##################################################################################################
