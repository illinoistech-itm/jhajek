#!/usr/bin/env bash

sudo hostnamectl set-hostname m2
sudo apt-get update
sudo apt-get install -y mongodb
sudo systemctl disable mongodb
sudo systemctl stop mongodb
sudo mkdir /home/vagrant/data/rs2