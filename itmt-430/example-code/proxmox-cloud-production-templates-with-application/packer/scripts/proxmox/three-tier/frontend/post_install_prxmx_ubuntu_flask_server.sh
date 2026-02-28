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
# python3-toml is needed since we are using Ubuntu Server 22.04.5 which ships Python 3.10
sudo apt install -y python3-flask-socketio python3-flask-login python3-requests python3-requests-oauthlib python3-hvac python3-dotenv python3-paramiko python3-jinja2 python3-metaconfig python3-flask-sqlalchemy python3-toml python3-pymysql libmysqlclient-dev

# Install dependencies for application logging to the Journal
sudo apt install -y libsystemd-dev python3-systemd

# Move the service file into /etc/systemd/system which is where user created
# service files are placed by convention
# Enable Flask App service to boot at start 
# from /etc/systemd/system/flask-app.service
sudo mv /home/vagrant/flask-app.service /etc/systemd/system/flask-app.service
sudo systemctl enable flask-app.service
