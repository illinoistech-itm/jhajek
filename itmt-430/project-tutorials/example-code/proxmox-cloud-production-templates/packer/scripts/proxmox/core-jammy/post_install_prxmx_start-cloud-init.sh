#!/bin/bash
set -e
set -v

# Need to start the cloud-init service for Ubuntu so when the image boots, cloud init is running
sudo systemctl start cloud-init
sudo systemctl enable cloud-init
sudo systemctl status cloud-init
