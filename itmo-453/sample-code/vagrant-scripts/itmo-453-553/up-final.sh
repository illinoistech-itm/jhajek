#!/bin/bash

# Riemann and Graphite 
cd ub-graphitea
vagrant up
cd ../ub-graphitemc
vagrant up
cd ../ub-riemanna
vagrant up
cd ../ub-riemannmc
vagrant up

# Elastic, Logstash, and Kibana
cd ../ela1
vagrant up
cd ../ela2
vagrant up
cd ../ela3
vagrant up
cd ../logstash
vagrant up

# Tornado app

cd ../tornado-proxy
vagrant up
cd ../tornado-web1
vagrant up
cd ../tornado-web2
vagrant up
cd ../tornado-api1
vagrant up
cd ../tornado-api2
vagrant up
cd ../tornado-db
vagrant up
cd ../tornado-redis
vagrant up
cd ../