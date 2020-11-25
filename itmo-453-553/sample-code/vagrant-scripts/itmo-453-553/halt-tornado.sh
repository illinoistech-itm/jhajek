#!/bin/bash

cd tornado-proxy
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