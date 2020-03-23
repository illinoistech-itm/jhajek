#!/bin/bash

# Tutorial from https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/
# https://www.digitalocean.com/community/tutorials/how-to-install-mongodb-on-ubuntu-18-04

# Reload local package database
sudo apt-get update
sudo apt install net-tools

# Install MongoD
# Import the public key used by the package management system
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4

# Create a list file for MongoD
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list

# Reload local package database
sudo apt-get update
sudo apt install net-tools

# Install the MongoDB packages
sudo apt-get install -y mongodb-org


# Add hostnames
sudo chown vagrant /etc/hosts
echo "192.168.50.11  nginx-web-server" >> /etc/hosts
echo "192.168.50.12  node-application-server" >> /etc/hosts
echo "192.168.50.13  mongodb-server" >> /etc/hosts
echo "192.168.50.14  mongodb-rep1-server" >> /etc/hosts
echo "192.168.50.15  redis-caching-server" >> /etc/hosts



# use admin
# db.createUser({user: "production-root",pwd: "production-root",roles: ["root"]});

# use production-db
# db.createUser({user: "production-user",pwd: "production-password",roles: ["readWrite"]});
# db.createCollection("sample")
# db.sample.insert({word :"hi"})

# sudo ufw allow from node-application-server/32 to any port 27017  
# sudo systemctl status mongod
# sudo chown vagrant:vagrant /*
