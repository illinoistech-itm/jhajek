#!/bin/bash
set -e
set -v

sudo yum install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx
