#!/bin/bash

# Destroy VMS if exist

# Destroy & rebuild node server
cd ../vms/node-application-server/ || exit 1

echo y | vagrant destroy
echo "[NODE] Server destroyed..."


# Destroy & rebuild nginx server
cd ../nginx-web-server/ || exit 1

echo y | vagrant destroy
echo "[NGINX] Server destroyed..."


# Destroy & rebuild mongodb server
cd ../mongodb-server/ || exit 1

echo y | vagrant destroy
echo "[MONGODB] Server destroyed..."

# Destroy & rebuild mongodb rep1 server
cd ../mongodb-rep1-server/ || exit 1

echo y | vagrant destroy
echo "[MONGODB REP1] Server destroyed..."

# Destroy & rebuild redis server
cd ../redis-caching-server/ || exit 1

echo y | vagrant destroy
echo "[REDIS] Server destroyed..."

# Remove servers if exist
vagrant box remove nginx-web-server
echo "[NGINX] Vagrant box removed..."

vagrant box remove node-application-server
echo "[NODE] Vagrant box removed..."

vagrant box remove mongodb-server
echo "[MONGODB] Vagrant box removed..."

vagrant box remove mongodb-rep1-server
echo "[MONGODB REP1] Vagrant box removed..."

vagrant box remove redis-caching-server
echo "[REDIS] Vagrant box removed..."