#!/bin/bash
# https://stackoverflow.com/questions/2500436/how-does-cat-eof-work-in-bash
cat <<EOF >> /etc/mysql/my.cnf

[client] 
default-character-set = utf8mb4 
[mysqld] 
innodb_file_format = Barracuda 
innodb_file_per_table = 1 
innodb_large_prefix 
character-set-server = utf8mb4 
collation-server = utf8mb4_unicode_ci 
skip-character-set-client-handshake 
[mysql] 
default-character-set = utf8mb4 
EOF