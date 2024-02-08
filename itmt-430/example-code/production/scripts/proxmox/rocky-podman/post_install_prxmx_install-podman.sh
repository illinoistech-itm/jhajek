#!/bin/bash
set -e
set -x

# Installing podman via the module method.  Also includes Buildah
sudo dnf module install -y container-tools