#!/bin/bash 
set -e
set -v

echo "Downloading Prometheus LTS..."
wget https://github.com/prometheus/prometheus/releases/download/v2.37.1/prometheus-2.37.1.linux-amd64.tar.gz
tar -xvzf prometheus-2.37.1.linux-amd64.tar.gz

echo "Create system account and group node_exporter..."
sudo adduser --system --group prometheus

# Copy Promethus server executable to /usr/local/bin
sudo cp -v ./prometheus-2.37.1.linux-amd64/prometheus /usr/local/bin/
# Copy prometheus.yml to etc
sudo mkdir /etc/prometheus
sudo cp -v ./prometheus-2.37.1.linux-amd64/prometheus.yml /etc/prometheus/prometheus.yml
sudo cp -vr ./prometheus-2.37.1.linux-amd64/consoles /etc/prometheus/
sudo cp -vr ./prometheus-2.37.1.linux-amd64/consoles_libraries /etc/prometheus/
