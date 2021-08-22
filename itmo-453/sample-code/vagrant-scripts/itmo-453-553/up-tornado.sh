#!/bin/bash

cd tornado-proxy
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
