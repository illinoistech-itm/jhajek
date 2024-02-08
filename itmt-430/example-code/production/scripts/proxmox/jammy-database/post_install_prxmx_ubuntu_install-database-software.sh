#!/bin/bash 
set -e
set -v

# Install MariaDB and PostgreSQL
sudo apt-get update
sudo apt-get install -y mariadb-server postgresql
