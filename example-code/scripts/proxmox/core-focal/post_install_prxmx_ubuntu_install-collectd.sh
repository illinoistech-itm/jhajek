#!/bin/bash 
set -e
set -v

# Install dependencies to create collectd
sudo apt-get update
# Install collectd for plugin management
# Install Java dependencies
sudo apt-get install -y openjdk-11-jre-headless
sudo apt-get install -y collectd-core intel-cmt-cat libdbi1 libprotobuf-c1 libriemann-client0 librrd8 lm-sensors rrdtool

sudo apt-get install -y --no-install-recommends collectd

sudo systemctl enable collectd
sudo systemctl start collectd