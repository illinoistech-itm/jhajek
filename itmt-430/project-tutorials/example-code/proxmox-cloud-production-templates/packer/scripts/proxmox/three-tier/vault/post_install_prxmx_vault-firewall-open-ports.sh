#!/bin/bash

# opens a port on the 10.0.0.0/16 metrics-network for 8200 which is the Vault port
sudo firewall-cmd --zone=meta-network --add-port=8200/tcp --permanent

sudo firewall-cmd --reload