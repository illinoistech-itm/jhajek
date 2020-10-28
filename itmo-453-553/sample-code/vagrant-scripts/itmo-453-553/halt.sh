#!/bin/bash

cd host1
vagrant halt
cd ../host2
vagrant halt
cd ../ub-riemanna
vagrant halt
cd ../centos-riemannb
vagrant halt
cd ../ub-riemannmc
vagrant halt
cd ../ub-graphitea
vagrant halt
cd ../centos-graphiteb
vagrant halt
cd ../ub-graphitemc
vagrant halt
cd ../ela1
vagrant halt
cd ../ela2
vagrant halt
cd ../ela3
vagrant halt
cd ../logstash
vagrant halt
cd ../
