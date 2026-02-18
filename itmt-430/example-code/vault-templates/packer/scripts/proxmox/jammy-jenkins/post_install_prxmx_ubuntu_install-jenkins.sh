#!/bin/bash 
set -e
set -v

# Install Jenkins LTS by adding Jenkins repo
# https://pkg.jenkins.io/debian/
# Important Notice: Beginning with LTS 2.387.2 and weekly 2.397, releases will be signed with a new GPG key.
# Administrators must install the new key on their servers before attempting to update Jenkins.
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
    /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
    https://pkg.jenkins.io/debian binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
