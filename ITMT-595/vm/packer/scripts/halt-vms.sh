#!/bin/bash

# Halt VMS
cd ../vms/node-application-server/

vagrant halt

echo "[NODE] server shutdown..."


# Halt nginx server
cd ../nginx-web-server/

vagrant halt

echo "[NGINX] server shutdown..."

# Halt mongodb server
cd ../mongodb-server/

vagrant halt

echo "[MONGODB] server shutdown..."

# Halt mongodb rep1 server
cd ../mongodb-rep1-server/

vagrant halt

echo "[MONGODB REP1] server shutdown..."

# Halt redis caching server
cd ../redis-caching-server/

vagrant halt

echo "[REDIS] server shutdown..."
