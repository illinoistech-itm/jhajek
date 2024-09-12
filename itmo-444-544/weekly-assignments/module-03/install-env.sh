#!/bin/bash 

sudo apt update
sudo apt install -y nginx

sudo systemctl enable --now nginx
