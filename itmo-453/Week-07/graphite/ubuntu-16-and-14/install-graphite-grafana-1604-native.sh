#!/bin/bash
set +x
set +e

#https://linoxide.com/ubuntu-how-to/setup-graphite-statsd-ubuntu-16-04/
#https://grey-boundary.io/the-architecture-of-clustering-graphite/

sudo apt-get update -y
#http://askubuntu.com/questions/549550/installing-graphite-carbon-via-apt-unattended
sudo apt-get install -y apt-transport-https libffi-dev libfontconfig pkg-config python-pip gunicorn3 graphite-api
sudo DEBIAN_FRONTEND=noninteractive apt-get -q -y --force-yes install graphite-carbon 

# P.135 - Listing 4.13: Installing the graphite-api package on Ubuntu
# sudo apt-get install -y graphite-api gunicorn
#http://graphite-api.readthedocs.io/en/latest/installation.html
sudo pip install -U six pyparsing websocket urllib3
# sudo pip install graphite-api 
# sudo pip install gunicorn 
# Start Gunicorn and create graphite-api systemd service file
# sudo systemctl enable gunicorn
# sudo systemctl start gunicorn
sudo cp -v graphite-api.service /lib/systemd/system/

# P.136 - Listing 4.16: Adding the Grafana repository listing
#sudo sh -c "echo deb https://packagecloud.io/grafana/stable/debian/ wheezy main > #/etc/apt/sources.list.d/packagecloud_grafana.list"
# https://grafana.com/grafana/download 
wget https://dl.grafana.com/oss/release/grafana_6.3.6_amd64.deb                                                                                                                                                          
sudo dpkg -i grafana_6.3.6_amd64.deb  

# Listing 4.61: Starting the Grafana Server
 sudo systemctl daemon-reload
 sudo systemctl enable grafana-server
### You can start grafana-server by executing
 sudo systemctl start grafana-server

# P.153 - Listing 4-39 - Create empty conf file to avoid error
sudo cp -v carbon.conf /etc/carbon/
sudo touch /etc/carbon/storage-aggregation.conf

sudo cp -v storage-schemas.conf /etc/carbon/

# P. 162 Copy the default graphite-api.yaml file overwritting the default one installed
sudo cp -v graphite-api.yaml /etc/graphite-api.yaml

# Listing 4.56: Creating the /var/lib/graphite/api_search_index file
sudo touch /var/lib/graphite/api_search_index
sudo chown _graphite:_graphite /var/lib/graphite/api_search_index

# Listing 4.57: Restarting the Graphite-API on Ubuntu
sudo systemctl enable graphite-api 
sudo systemctl start graphite-api

# Listing 4.49: Starting the Carbon daemons on Ubuntu
# sudo cp -v graphite-carbon /etc/default/graphite-carbon

# Listing at 26% page wise ebook
sudo cp -v carbon-cache@.service /lib/systemd/system/
sudo cp -v carbon-relay@.service /lib/systemd/system/

sudo systemctl disable carbon-relay
sudo systemctl disable carbon-cache

sudo systemctl enable carbon-cache@1.service
sudo systemctl enable carbon-cache@2.service
sudo systemctl start carbon-cache@1.service
sudo systemctl start carbon-cache@2.service

sudo systemctl enable carbon-relay@1.service
sudo systemctl start carbon-relay@1.service

# Remove old systemd service files
sudo rm -f /lib/systemd/system/carbon-relay.service
sudo rm -f /lib/systemd/system/carbon-cache.service
