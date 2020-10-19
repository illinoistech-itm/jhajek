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