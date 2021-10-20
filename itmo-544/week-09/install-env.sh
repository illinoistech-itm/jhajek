#!/bin/bash

# Shell Script used to install that application and business logic 

sudo apt-get update
sudo apt-get install -y nginx

# Need to install the ZFS Utils to create a zpool named: datapool
sudo apt-get install -y zfs-utils 

# run the command: sudo zpool create ....   to create the zpool 


