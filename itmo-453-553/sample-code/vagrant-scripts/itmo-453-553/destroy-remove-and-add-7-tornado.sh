#!/bin/bash
# Destroy existing vagrant boxes
cd tornado-proxy
vagrant destroy -f
rm -rf ./.vagrant 
cd ../tornado-web1
vagrant destroy -f
rm -rf ./.vagrant 
cd ../tornado-web2
vagrant destroy -f
rm -rf ./.vagrant 
cd ../tornado-api1
vagrant destroy -f
rm -rf ./.vagrant 
cd ../tornado-api2
vagrant destroy -f
rm -rf ./.vagrant 
cd ../tornado-db
vagrant destroy -f
rm -rf ./.vagrant
cd ../tornado-redis
vagrant destroy -f
rm -rf ./.vagrant  
cd ../

# Remove existing vagrant boxes
vagrant box remove tornado-proxy --force 
vagrant box remove tornado-web1 --force
vagrant box remove tornado-web2 --force 
vagrant box remove tornado-api1 --force 
vagrant box remove tornado-api2 --force 
vagrant box remove tornado-db --force 
vagrant box remove tornado-redis --force

# Add newly built Vagrant boxes
if [ -a  ../../itmo-453-553/build/tornado-proxy-virtualbox*.box ]
then 
    vagrant box add ../../itmo-453-553/build/tornado-proxy-virtualbox*.box --name ub-riemanna
else
   echo  "File ../../itmo-453-553/build/tornado-proxy-virtualbox*.box doesn't exist"
fi
if [ -a  ../../itmo-453-553/build/tornado-web1-virtualbox*.box ] 
then
    vagrant box add ../../itmo-453-553/build/tornado-web1-virtualbox*.box --name centos-riemannb
else
   echo  "File ../../itmo-453-553/build/tornado-web1-virtualbox*.box doesn't exist"
fi
if [ -a  ../../itmo-453-553/build/tornado-web2-virtualbox*.box ] 
then
    vagrant box add ../../itmo-453-553/build/tornado-web2-virtualbox*.box --name ub-riemannmc
else
   echo  "File ../../itmo-453-553/build/tornado-web2-virtualbox*.box doesn't exist"
fi
if [ -a  ../../itmo-453-553/build/tornado-api1-virtualbox*.box ] 
then
    vagrant box add ../../itmo-453-553/build/tornado-api1-virtualbox*.box --name ub-graphitea
else
   echo  "File ../../itmo-453-553/build/tornado-api1-virtualbox*.box doesn't exist"
fi
if [ -a  ../../itmo-453-553/build/tornado-api2-virtualbox*.box ] 
then
    vagrant box add ../../itmo-453-553/build/tornado-api2-virtualbox*.box --name centos-graphiteb
else
   echo  "File ../../itmo-453-553/build/tornado-api2-virtualbox*.box doesn't exist"
fi
if [ -a  ../../itmo-453-553/build/tornado-db-virtualbox*.box ] 
then
    vagrant box add ../../itmo-453-553/build/tornado-db-virtualbox*.box --name ub-graphitemc
else
   echo  "File ../../itmo-453-553/build/tornado-db-virtualbox*.box doesn't exist"
fi
if [ -a  ../../itmo-453-553/build/tornado-redis-virtualbox*.box ] 
then
    vagrant box add ../../itmo-453-553/build/tornado-redis-virtualbox*.box --name ub-graphitemc
else
   echo  "File ../../itmo-453-553/build/tornado-redis-virtualbox*.box doesn't exist"
fi