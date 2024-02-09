#!/bin/bash 
set -e
set -v

# Install Android and Jenkins Java Dependencies
sudo apt-get update
###############################################################################
# Up to Java 11 OpenJDK 
###############################################################################
sudo apt install -y openjdk-17-jdk
