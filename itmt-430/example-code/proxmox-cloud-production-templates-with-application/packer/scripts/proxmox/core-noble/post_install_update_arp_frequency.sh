#!/bin/bash

############################################################################################
# Script to modify the default ARP frequencies -- hoping to create less ARP packets
#############################################################################################

sudo touch /etc/sysctl.d/99-neigh-tuning.conf
echo "net.ipv4.neigh.default.gc_stale_time = 180" | sudo tee -a /etc/sysctl.d/99-neigh-tuning.conf
echo "net.ipv4.neigh.default.base_reachable_time_ms = 120000" | sudo tee -a /etc/sysctl.d/99-neigh-tuning.conf
sudo sysctl --system