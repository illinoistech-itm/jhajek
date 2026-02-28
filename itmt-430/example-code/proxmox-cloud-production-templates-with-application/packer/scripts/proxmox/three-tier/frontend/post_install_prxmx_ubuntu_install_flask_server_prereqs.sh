#!/bin/bash 
set -e
set -v

##################################################################################################
# Install Flask and dependencies - create service file
# https://flask.palletsprojects.com/en/stable/installation/#install-flask
##################################################################################################

sudo apt update
sudo apt install -y python3-setuptools python3-pip python3-dev

# https://flask.palletsprojects.com/en/stable/deploying/
# Install Gunicorn and Flask not via Pip but via Ubuntu apt packages
sudo apt install -y gunicorn python3-flask

# Requirements for Flask app functionality
sudo apt install -y python3-flask-socketio python3-flask-login python3-requests python3-requests-oauthlib python3-dotenv python3-jinja2 python3-metaconfig python3-flask-sqlalchemy 

# Pre-reqs for MySQL database, if using PostgreSQL change these out
sudo apt install -y python3-pymysql libmysqlclient-dev

# Install dependencies for application logging to the Journal
sudo apt install -y libsystemd-dev python3-systemd
