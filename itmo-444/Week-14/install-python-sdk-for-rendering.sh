#!/bin/bash

sudo apt-get update
sudo apt-get install -y python3-pip python3-dev python3-setuptools

pip3 install boto3
pip3 install Pillow

# Install PIL  - python image library
# https://docs.python-guide.org/scenarios/imaging/
