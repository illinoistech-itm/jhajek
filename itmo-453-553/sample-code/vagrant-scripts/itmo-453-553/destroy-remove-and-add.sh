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
cd ../ub-host2
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
if [ -a  ../ub-riemanna-virtualbox*.box ]
then 
    vagrant box add ../ub-riemanna-virtualbox*.box --name ub-riemanna
else
   echo  "File ../ub-riemanna-virtualbox*.box doesn't exist"
fi
if [ -a  ../centos-riemannb-virtualbox*.box ] 
    vagrant box add ../centos-riemannb-virtualbox*.box --name centos-riemannb
else
   echo  "File ../centos-riemannb-virtualbox*.box doesn't exist"
fi
if [ -a  ../ub-riemannmc-virtualbox*.box ] 
    vagrant box add ../ub-riemannmc-virtualbox*.box --name ub-riemannmc
else
   echo  "File ../ub-riemannmc-virtualbox*.box doesn't exist"
fi
if [ -a  ../ub-graphitea-virtualbox*.box ] 
    vagrant box add ../ub-graphitea-virtualbox*.box --name ub-graphitea
else
   echo  "File ../ub-graphitea-virtualbox*.box doesn't exist"
fi
if [ -a  ../centos-graphiteb-virtualbox*.box ] 
    vagrant box add ../centos-graphiteb-virtualbox*.box --name centos-graphiteb
else
   echo  "File ../centos-graphiteb-virtualbox*.box doesn't exist"
fi
if [ -a  ../ub-graphitemc-virtualbox*.box ] 
    vagrant box add ../ub-graphitemc-virtualbox*.box --name ub-graphitemc
else
   echo  "File ../ub-graphitemc-virtualbox*.box doesn't exist"
fi
if [ -a  ../ub-host1-virtualbox*.box ] 
    vagrant box add ../ub-host1-virtualbox*.box --name host1
else
   echo  "File ../ub-host1-virtualbox*.box doesn't exist"
fi
if [ -a  ../centos-host2-virtualbox*.box ] 
    vagrant box add ../centos-host2-virtualbox*.box --name host2
else
   echo  "File ../centos-host2-virtualbox*.box doesn't exist"
fi