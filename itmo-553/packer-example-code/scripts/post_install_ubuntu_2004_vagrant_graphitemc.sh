#!/bin/bash 
set -e
set -v

# http://superuser.com/questions/196848/how-do-i-create-an-administrator-user-on-ubuntu
# http://unix.stackexchange.com/questions/1416/redirecting-stdout-to-a-file-you-dont-have-write-permission-on
# This line assumes the user you created in the preseed directory is ubuntu
echo "%admin  ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/init-users
sudo groupadd admin
sudo usermod -a -G admin vagrant

# Installing Vagrant keys
wget --no-check-certificate 'https://raw.githubusercontent.com/hashicorp/vagrant/main/keys/vagrant.pub'
sudo mkdir -p /home/vagrant/.ssh
sudo chown -R vagrant:vagrant /home/vagrant/.ssh
cat ./vagrant.pub >> /home/vagrant/.ssh/authorized_keys
sudo chown -R vagrant:vagrant /home/vagrant/.ssh/authorized_keys
echo "All Done!"

##################################################
# Add User customizations below here
##################################################

cat << EOT >> /etc/hosts
# Nodes
192.168.33.100  riemanna riemanna.example.com
192.168.33.101  riemannb riemannb.example.com
192.168.33.102  riemannmc riemannmc.example.com
192.168.33.200  graphitea graphitea.example.com
192.168.33.201  graphiteb graphiteb.example.com
192.168.33.202  graphitemc graphitemc.example.com
EOT

# Commands to install graphite, carbon-cache and carbon-relay services,
# and whisper flatfile database
# http://askubuntu.com/questions/549550/installing-graphite-carbon-via-apt-unattended
sudo apt-get update
sudo apt-get install -y apt-transport-https

sudo DEBIAN_FRONTEND=noninteractive apt-get -y --allow-change-held-packages install graphite-carbon python3-whisper

## Command to stop the carbon-cache and carbon-relay services, as we need to edit
# edit their systemd service files later
sudo systemctl stop carbon-cache.service
sudo systemctl stop carbon-relay@1.service

# Command in add the apt repository to install python3.9 in addition to
# the Ubuntu 20.04 default install of python3.8 due to the bug in the logging library
# that prevents the graphite-api from runnning
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt-get install -y python3.9

## Command to install graphite-api only and gunicorn - https://gunicorn.org/
sudo apt-get install -y graphite-api gunicorn

## Command to stop the graphite api service as we need to change out the default
## default graphite-api.service file with out own from our GitHub Repo
sudo systemctl stop graphite-api.service

## Commands to delete the uneeded service files for graphite-api, carbon-cache, and carbon-relay
## Commmand can be typed verbosly or as a single command using {}:
# sudo rm /lib/systemd/system/graphite-api.service
# sudo rm /lib/systemd/system/carbon-relay@.service
# sudo rm /lib/systemd/system/carbon-cache.service  
sudo rm /lib/systemd/system/{carbon-cache,carbon-relay@,graphite-api}.service

## Command to install Grafana graphing tool
wget https://dl.grafana.com/oss/release/grafana_7.3.6_amd64.deb
sudo dpkg -i grafana_7.3.6_amd64.deb

## Command to clone your own @hawk ID private repo with all the configuration files
# We need to add
git clone git@github.com:illinoistech-itm/sample-student.git

## Code to copy the new systemd service files from our GitHub repo code to the systemd service directory
sudo cp -v ./sample-student/itmo-453/week-09/service-files/carbon-cache@.service /lib/systemd/system/carbon-cache@.service
sudo cp -v ./sample-student/itmo-453/week-09/service-files/carbon-relay@.service /lib/systemd/system/carbon-relay@.service
sudo cp -v ./sample-student/itmo-453/week-09/service-files/graphite-api.service /lib/systemd/system/graphite-api.service

## Code to cp our carbon.conf configuration file we created and overwrite the default
sudo cp -v ./sample-student/itmo-453/week-09/graphite/graphitea/carbon.conf /etc/carbon/carbon.conf

## Code to cp our storage aggregation configuration files and overwrite the default
sudo cp -v ./sample-student/itmo-453/week-09/graphite/graphitea/storage-schemas.conf /etc/carbon/storage-schemas.conf

## Code to create a blank storage aggregation file (not needed at the moment) but will avoid warning message 
# in the logs
sudo touch /etc/carbon/storage-aggregation.conf

## Ubuntu only - default file to start 2 carbon cache and 1 carbon-relay instances at boot time
sudo cp -v ./sample-student/itmo-453/week-09/graphite/graphitea/graphite-carbon.default /etc/default/graphite-carbon

## Command to create the graphite-api search index file
sudo touch /var/lib/graphite/api_search_index

## Code to copy our customized Graphite parameter's file and overwrite the default one
sudo cp -v ./sample-student/itmo-453/week-09/graphite/graphitea/graphite-api.yaml /etc/

## Command to reload all of the daemons and start them
# Daemon-reload must be run each time you change the content of a .service file
sudo systemctl daemon-reload 

# Command to start and enable at boot 2 instances of the carbon-cache
sudo systemctl enable carbon-cache@1.service
sudo systemctl enable carbon-cache@2.service
sudo systemctl start carbon-cache@1.service
sudo systemctl start carbon-cache@2.service

## Command to start and enable at boot 1 instance of carbon-relay
sudo systemctl enable carbon-relay@1.service
sudo systemctl start carbon-relay@1.service

## Command to start and enable at boot the graphite-api--for Ubuntu running on port 8542
## you can check this by running the command:  ss -l
sudo systemctl enable graphite-api
sudo systemctl start graphite-api

# Command to start and enable the grafana-server, running on port 3000
sudo systemctl enable grafana-server
sudo systemctl start grafana-server




