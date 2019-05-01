#!/usr/bin/env bash

sudo apt-get update
sudo apt-get install -y mongodb
sudo systemctl disable mongodb
sudo systemctl stop mongodb
sudo hostnamectl set-hostname m4
sudo sed -i -e '127\.0\.1\.1    ubuntu-xenial ubuntu-xenial/127\.0\.1\.1 m4 m4' /etc/hosts