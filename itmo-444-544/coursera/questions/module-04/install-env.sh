#!/bin/bash

# Sample code to install Nginx webserver

sudo apt update
sudo apt install -y nginx

sudo systemctl enable --now nginx
