#!/bin/bash

# https://docs.saltproject.io/en/getstarted/system/communication.html
echo "Opening two firewall ports for salt minion communication..."
sudo firewall-cmd --zone=meta-network --add-port=4505/tcp --permanent
sudo firewall-cmd --zone=meta-network --add-port=4506/tcp --permanent

sudo firewall-cmd --reload