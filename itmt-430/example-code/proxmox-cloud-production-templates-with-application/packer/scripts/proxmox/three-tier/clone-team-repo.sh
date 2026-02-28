#!/bin/bash

# Command to clone the team code repo -- assuming you have renamed the template-config to config
# You have pushed the id_ed25519 key

cd /home/vagrant

# Command to clone your private repo via SSH usign the Private key
####################################################################
# Note - change "team-00.git" to be your private repo name (hawk ID) #
####################################################################
ls -l /home/vagrant/.ssh
sudo -u vagrant git clone git@github.com:illinoistech-itm/team-00.git

# Add commands to copy your code out of the team repo and into the correct location to serve code
