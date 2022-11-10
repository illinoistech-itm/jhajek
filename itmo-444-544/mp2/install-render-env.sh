#!/bin/bash

# Code to install the dependencies for the rendering server
sudo apt-get update
sudo apt-get install -y python3-dev python3-pip python3-setuptools

# Code to install Python3 AWS-SDK
python3 -m pip install Pillow boto3

# Change directory to Ubuntu's home directory and clone your code repository
cd /home/ubuntu
sudo -u ubuntu git clone git@github.com:illinoistech-itm/jhajek.git

# This command will copy our .timer and .service files into the systemd directory to be executed at boot
cp -v ./jhajek/itmo-444-544/mp2/check-for-new-objects.* /etc/systemd/system/

# This command starts the .timer file to check every two minutes to the SQS queue
sudo systemctl start check-for-new-objects.timer