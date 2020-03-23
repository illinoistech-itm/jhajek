#!/bin/bash

# Add servers
cd ../build/ || exit 1

vagrant box add ./nginx-web-server-virtualbox.box --name nginx-web-server || exit 1
echo "[NGINX] vagrant box added..."

vagrant box add ./node-application-server-virtualbox.box --name node-application-server || exit 1
echo "[NODE] vagrant box added..."

vagrant box add ./mongodb-server-virtualbox.box --name mongodb-server || exit 1
echo "[MONGODB] vagrant box added..."

vagrant box add ./mongodb-server-virtualbox.box --name mongodb-rep1-server || exit 1
echo "[MONGODB REP1] vagrant box added..."

vagrant box add ./redis-caching-server-virtualbox.box --name redis-caching-server || exit 1
echo "[REDIS] vagrant box added..."
