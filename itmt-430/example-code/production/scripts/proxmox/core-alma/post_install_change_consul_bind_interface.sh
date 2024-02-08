#!/bin/bash

#########################################################################
# Script to change the bind_addr in Consul to the dynmaic Go lang call to
# Interface ens18
# https://www.consul.io/docs/troubleshoot/common-errors
#########################################################################

sed -i 's/#bind_addr = \"0.0.0.0\"/bind_addr = \"{{GetInterfaceIP \\\"ens20\\\"}}\"/' /etc/consul.d/consul.hcl
