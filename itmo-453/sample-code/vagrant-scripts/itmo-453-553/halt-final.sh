#!/bin/bash

# Riemann and Graphite 
cd ub-graphitea
vagrant halt
cd ../ub-graphitemc
vagrant halt
cd ../ub-riemanna
vagrant halt
cd ../ub-riemannmc
vagrant halt

# Elastic, Logstash, and Kibana
cd ../ela1
vagrant halt
cd ../ela2
vagrant halt
cd ../ela3
vagrant halt
cd ../logstash
vagrant halt

# Tornado app

cd ../tornado-proxy
vagrant halt
cd ../tornado-web1
vagrant halt
cd ../tornado-web2
vagrant halt
cd ../tornado-api1
vagrant halt
cd ../tornado-api2
vagrant halt
cd ../tornado-db
vagrant halt
cd ../tornado-redis
vagrant halt
cd ../