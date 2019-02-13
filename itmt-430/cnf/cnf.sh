#!/bin/bash

# Inject the username and password for autologin later in a ~/.my.cnf file
# http://serverfault.com/questions/103412/how-to-change-my-mysql-root-password-back-to-empty/103423#103423
# https://stackoverflow.com/questions/8020297/mysql-my-cnf-file-found-option-without-preceding-group

echo -e "[mysqld]" > ~/.my.cnf
echo -e "\n\n[client]\nuser = root\npassword = $DBPASS" >> ~/.my.cnf
echo -e "\nport = 3306\nsocket = /var/run/mysqld/mysqld.sock\n" >> ~/.my.cnf

echo -e "[mysqld]\n\n" > ~/.my.cnf.user
echo -e "[client]\nuser = worker\npassword = $USERPASS" >> ~/.my.cnf.user
echo -e "\nport = 3306\nsocket = /var/run/mysqld/mysqld.sock\n" >> ~/.my.cnf.user
echo -e "\ndefault-character-set = utf8mb4\n" >> ~/.my.cnf.user
