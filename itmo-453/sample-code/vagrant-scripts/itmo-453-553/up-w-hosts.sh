#!/bin/bash

cd ub-graphitea
vagrant up
cd ../centos-graphiteb
vagrant up
cd ../ub-graphitemc
vagrant up
cd ../ub-riemanna
vagrant up
cd ../centos-riemannb
vagrant up
cd ../ub-riemannmc
vagrant up
cd ../host1
vagrant up
cd ../host2
vagrant up
cd ../
