#!/bin/bash

# Riemann and Graphite 
cd ub-graphitea
vagrant suspend
cd ../ub-graphitemc
vagrant suspend
cd ../ub-riemanna
vagrant suspend
cd ../ub-riemannmc
vagrant suspend

# Elastic, Logstash, and Kibana
cd ../ela1
vagrant suspend
cd ../ela2
vagrant suspend
cd ../ela3
vagrant suspend
cd ../logstash
vagrant suspend

# Tornado app

cd ../tornado-proxy
vagrant suspend
cd ../tornado-web1
vagrant suspend
cd ../tornado-web2
vagrant suspend
cd ../tornado-api1
vagrant suspend
cd ../tornado-api2
vagrant suspend
cd ../tornado-db
vagrant suspend
cd ../tornado-redis
vagrant suspend
cd ../