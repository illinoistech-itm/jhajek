#!/bin/bash

# Destroy and Remove VMS if exist
bash ./remove-vms.sh

# Build each Server
cd ../vanilla-install/ || exit 1

packer build -force all-servers.json || exit 1
echo "[PACKER] build finished..."
