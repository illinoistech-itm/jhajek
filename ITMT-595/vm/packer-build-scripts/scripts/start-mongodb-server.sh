#!/bin/bash

# Start Mongod service


sudo mongod --fork --logpath /var/log/mongodb.log --config /etc/mongod.conf --replSet rs0
echo "[MONGODB] server running..."
