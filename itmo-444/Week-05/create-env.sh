#!/bin/bash

# Script to create environment

sudo apt-get -y update 
sudo apt-get -y install ruby gem ruby-dev links

sudo gem install bundler jekyll 1>> ~/out.log 2>> ~/err.log
jekyll site 1>> ~/out.log 2>> ~/err.log
cd site
bundle exec jekyll serve
