#!/bin/bash

#########################################################################
# Script to change the bind_addr in Consul to the dynmaic Go lang call to
# Interface ens20
# https://www.consul.io/docs/troubleshoot/common-errors
#########################################################################

# Logic to check for presence of /etc/consul.d/consul.hcl file
if [ -e /etc/consul.d/consul.hcl ]
  then
    echo "The file /etc/consul.d/consul.hcl exists..."
    echo "Replacing the default 0.0.0.0 with ens20"
    sed -i 's/#bind_addr = \"0.0.0.0\"/bind_addr = \"{{GetInterfaceIP \\\"ens20\\\"}}\"/' /etc/consul.d/consul.hcl
  else
    echo "The file /etc/consul.d/consul.hcl doesn't exist... something has happened with the installation of consul... throwing an error to kill the build process..."
    exit 1
fi


