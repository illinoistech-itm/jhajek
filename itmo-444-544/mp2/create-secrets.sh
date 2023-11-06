#!/bin/bash

#create secret
echo "creating secret..."

# Add maria.json to your .gitignore file on your host system, push this to GitHub
# Modify your maria-template.json not on the local system but on your Vagrant Box after you have
# issued a git pull - rename the maria-template.json to maria.json and add a username and password
aws secretsmanager create-secret --name ${20} --secret-string file://maria.json

