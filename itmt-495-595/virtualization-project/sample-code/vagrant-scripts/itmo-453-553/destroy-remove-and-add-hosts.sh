#!/bin/bash
# Destroy existing vagrant boxes
cd host1
vagrant destroy -f
rm -rf ./.vagrant  
cd ../host2
vagrant destroy -f
rm -rf ./.vagrant 
cd ../

# Remove existing vagrant boxes
vagrant box remove host1 --force
vagrant box remove host2 --force

# Add newly built Vagrant boxes
if [ -a  ../../itmo-453-553/build/ub-host1-virtualbox*.box ] 
then
    vagrant box add ../../itmo-453-553/build/ub-host1-virtualbox*.box --name host1
else
   echo  "File ../../itmo-453-553/build/ub-host1-virtualbox*.box doesn't exist"
fi
if [ -a  ../../itmo-453-553/build/centos-host2-virtualbox*.box ] 
then
    vagrant box add ../../itmo-453-553/build/centos-host2-virtualbox*.box --name host2
else
   echo  "File ../../itmo-453-553/build/centos-host2-virtualbox*.box doesn't exist"
fi