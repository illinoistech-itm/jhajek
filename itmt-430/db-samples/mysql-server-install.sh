#!/bin/bash

sudo apt-get update

sudo apt-get -y install mysql-server

# Need to add a line here using the command: sed Addthat will replace the bind-address value in /etc/mysql/my.cnf to give the value of your public IP address - so your client can connect to it
