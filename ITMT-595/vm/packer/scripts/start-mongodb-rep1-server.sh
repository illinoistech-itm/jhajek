#!/bin/bash

sudo mongod --fork --logpath /var/log/mongodb.log --config /etc/mongod.conf --replSet rs0 --enableMajorityReadConcern
echo "[MONGODB REP 1] server running..."
