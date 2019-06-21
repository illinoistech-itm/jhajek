#!/bin/bash
# https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-redis-on-ubuntu-18-04
# Update the apt-get package lists and redis
sudo apt-get update
sudo apt-get install redis-server -y

# Inside the file, find the supervised directive. This directive allows you to declare an init system to manage Redis as a service, providing you with more control over its operation. The supervised directive is set to no by default. Since you are running Ubuntu, which uses the systemd init system, change this to systemd

sudo sed -i '147s/no/systemd/' /etc/redis/redis.conf
sudo sed -i '69s/127.0.0.1 ::1/192.168.50.15/' /etc/redis/redis.conf
sudo sed -i '500s/# requirepass foobared/requirepass A81jWlISU\/yYAtNlb+b5jdHpQ\/N9epFNWYrhJciQ2NF50mHT1t7UPeT+TkEQLpYkasIrmoR4ck6V85cy/' /etc/redis/redis.conf

# Add derver to hostname
sudo chown vagrant /etc/hosts
echo "192.168.50.11  nginx-web-server" >> /etc/hosts
echo "192.168.50.12  node-application-server" >> /etc/hosts
echo "192.168.50.13  mongodb-server" >> /etc/hosts
echo "192.168.50.14  mongodb-rep1-server" >> /etc/hosts
echo "192.168.50.15  redis-caching-server" >> /etc/hosts
