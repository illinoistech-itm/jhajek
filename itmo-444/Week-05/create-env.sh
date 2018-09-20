#!/bin/bash

# Script to run on a luanched AWS EC2 resources

sudo apt-get -y update
sudo apt-get -y install python jekyll ruby-stuff 1> ~/out.log 2> ~/err.log

jekyll build
jekyll run
