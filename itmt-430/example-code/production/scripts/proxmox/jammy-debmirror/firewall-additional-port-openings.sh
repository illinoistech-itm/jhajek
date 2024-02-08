#!/bin/bash

# Needed to receive update requests over http on the meta-network
sudo firewall-cmd --zone=metrics-network --add-service=http --permanent

sudo firewall-cmd --reload
