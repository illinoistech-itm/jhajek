#!/bin/bash
set -e
set -x 

# 4.3.2.1
sudo yum install -y epel-release

sudo yum install -y python-setuptools java-1.8.0-openjdk

# 4.3.2.2
sudo yum install -y python-whisper python-carbon graphite-api

# Extra carbon install steps
# Create a new group and user called _graphite.
# Move the default path of /var/lib/carbon/ to /var/lib/graphite.
# Change the ownership of the /var/log/carbon directory.
# Remove the now unused carbon user.

sudo groupadd _graphite
sudo useradd -c "Carbon daemons" -g _graphite -d /var/lib/graphite -M -s /sbin/nologin _graphite

# Next let's move and change the ownership of the /var/lib/carbon directory.
sudo mv /var/lib/carbon /var/lib/graphite
sudo chown -R _graphite:_graphite /var/lib/graphite

# Next, let's change the ownership of the /var/log/carbon directory.
sudo chown -R _graphite:_graphite /var/log/carbon

# Lastly, let's remove the carbon user.
sudo userdel carbon

# 4.3.3.2 Installing Graphite-API on Red Hat
# First, we need to install some prerequisite packages.
sudo yum install -y python-pip gcc libffi-devel cairo-devel libtool libyaml-devel python-devel

# 4.3.4.2 Installing Grafana on Red Hat
wget https://dl.grafana.com/oss/release/grafana-6.3.6-1.x86_64.rpm 
sudo yum localinstall grafana-6.3.6-1.x86_64.rpm

## You can start grafana-server by executing
sudo systemctl daemon-reload
sudo systemctl enable grafana-server.service
sudo systemctl start grafana-server.service

# 4.4 Carbon conf
sudo cp -v carbon.conf /etc/carbon/ 

# 4.4.3.2 Service management on Red Hat
sudo cp -v carbon-cache@.service /lib/systemd/system/
sudo cp -v carbon-relay@.service /lib/systemd/system/
sudo systemctl daemon-reload

sudo systemctl enable carbon-cache@1.service
sudo systemctl enable carbon-cache@2.service
sudo systemctl start carbon-cache@1.service
sudo systemctl start carbon-cache@2.service

sudo systemctl enable carbon-relay@1.service
sudo systemctl start carbon-relay@1.service

sudo rm -f /lib/systemd/system/carbon-relay.service
sudo rm -f /lib/systemd/system/carbon-cache.service

# 4.5
sudo touch /var/lib/graphite/api_search_index
sudo chown _graphite:_graphite /var/lib/graphite/api_search_index

# 4.5.1
sudo cp -v graphite-api.service /lib/systemd/system/

# Start the service
sudo systemctl enable graphite-api.service
sudo systemctl start graphite-api.service
