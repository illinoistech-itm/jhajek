#!/bin/bash

# Destroy and Remove VMS if exist
bash ./remove-vms.sh

# Build each Server
cd ../vanilla-install/ || exit 1

#packer build -force all-servers.json || exit 1
packer build mongodb-server.json
packer build nginx-web-server.json
packer build node-application-server.json
packer redis-caching-server.json

echo "[PACKER] build finished..."
