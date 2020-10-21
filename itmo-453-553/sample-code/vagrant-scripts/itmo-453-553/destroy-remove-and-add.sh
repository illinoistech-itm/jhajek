#!/bin/bash
# Destroy existing vagrant boxes
cd ub-riemanna
vagrant destroy -f
rm -rf ./.vagrant 
cd ../centos-riemannb
vagrant destroy -f
rm -rf ./.vagrant 
cd ../ub-riemannmc
vagrant destroy -f
rm -rf ./.vagrant 
cd ../ub-graphitea
vagrant destroy -f
rm -rf ./.vagrant 
cd ../centos-graphiteb
vagrant destroy -f
rm -rf ./.vagrant 
cd ../ub-graphitemc
vagrant destroy -f
rm -rf ./.vagrant
cd ../host1
vagrant destroy -f
rm -rf ./.vagrant  
cd ../host2
vagrant destroy -f
rm -rf ./.vagrant 
cd ../

# Remove existing vagrant boxes
vagrant box remove ub-riemanna --force 
vagrant box remove centos-riemannb --force
vagrant box remove ub-riemannmc --force 
vagrant box remove ub-graphitea --force 
vagrant box remove centos-graphiteb --force 
vagrant box remove ub-graphitemc --force 
vagrant box remove host1 --force
vagrant box remove host2 --force

# Add newly built Vagrant boxes
if [ -a  ../../itmo-453-553/build/ub-riemanna-virtualbox*.box ]
then 
    vagrant box add ../../itmo-453-553/build/ub-riemanna-virtualbox*.box --name ub-riemanna
else
   echo  "File ../../itmo-453-553/build/ub-riemanna-virtualbox*.box doesn't exist"
fi
if [ -a  ../../itmo-453-553/build/centos-riemannb-virtualbox*.box ] 
then
    vagrant box add ../../itmo-453-553/build/centos-riemannb-virtualbox*.box --name centos-riemannb
else
   echo  "File ../../itmo-453-553/build/centos-riemannb-virtualbox*.box doesn't exist"
fi
if [ -a  ../../itmo-453-553/build/ub-riemannmc-virtualbox*.box ] 
then
    vagrant box add ../../itmo-453-553/build/ub-riemannmc-virtualbox*.box --name ub-riemannmc
else
   echo  "File ../../itmo-453-553/build/ub-riemannmc-virtualbox*.box doesn't exist"
fi
if [ -a  ../../itmo-453-553/build/ub-graphitea-virtualbox*.box ] 
then
    vagrant box add ../../itmo-453-553/build/ub-graphitea-virtualbox*.box --name ub-graphitea
else
   echo  "File ../../itmo-453-553/build/ub-graphitea-virtualbox*.box doesn't exist"
fi
if [ -a  ../../itmo-453-553/build/centos-graphiteb-virtualbox*.box ] 
then
    vagrant box add ../../itmo-453-553/build/centos-graphiteb-virtualbox*.box --name centos-graphiteb
else
   echo  "File ../../itmo-453-553/build/centos-graphiteb-virtualbox*.box doesn't exist"
fi
if [ -a  ../../itmo-453-553/build/ub-graphitemc-virtualbox*.box ] 
then
    vagrant box add ../../itmo-453-553/build/ub-graphitemc-virtualbox*.box --name ub-graphitemc
else
   echo  "File ../../itmo-453-553/build/ub-graphitemc-virtualbox*.box doesn't exist"
fi
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