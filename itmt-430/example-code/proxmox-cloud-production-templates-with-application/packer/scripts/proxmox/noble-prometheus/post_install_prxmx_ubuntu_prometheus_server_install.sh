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

# Chown ownership of prometheus binary
sudo chown prometheus:prometheus /usr/local/bin/prometheus

# Copy prometheus.yml to etc
sudo mkdir /etc/prometheus
sudo cp -v /home/vagrant/prometheus.yml /etc/prometheus/prometheus.yml
sudo cp -vr ./prometheus-2.37.1.linux-amd64/consoles /etc/prometheus/
sudo cp -vr ./prometheus-2.37.1.linux-amd64/console_libraries /etc/prometheus/

sudo cp -v /home/vagrant/prometheus.service /etc/systemd/system/prometheus.service
sudo systemctl enable prometheus.service
