#!/usr/bin/env bash


sudo apt-get update
sudo apt-get install -y mongodb
sudo systemctl disable mongodb
sudo systemctl stop mongodb
sudo hostnamectl set-hostname m4