#!/bin/bash 
set -e
set -v

# Install dependencies to create collectd
sudo yum install -y epel-release
# Install collectd for plugin management
# Install Java dependencies
sudo yum install -y java-11-openjdk
sudo yum install -y collectd collectd-write_riemann

sudo systemctl enable collectd
sudo systemctl start collectd