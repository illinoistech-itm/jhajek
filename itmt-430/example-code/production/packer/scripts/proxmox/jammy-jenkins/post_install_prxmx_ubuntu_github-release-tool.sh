#!/bin/bash 
set -e
set -v

##############################################################################################
# Download and install the github release executable for adding compiled binaries to 
# the release tab in GitHub
##############################################################################################

wget https://github.com/mislav/hub/releases/download/v2.14.2/hub-linux-amd64-2.14.2.tgz
tar -xvzf hub-linux-amd64-2.14.2.tgz
mv -v ./hub-linux-amd64-2.14.2/bin/hub /usr/local/bin/
