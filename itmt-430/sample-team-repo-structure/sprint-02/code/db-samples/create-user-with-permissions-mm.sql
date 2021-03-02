-- This file creates a user named worker and passes in the password declared in the environment variables
-- Depending on the user, you may not want CREATE and DELETE permissions

-- GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON posts.* TO worker@'$ACCESSFROMIP' IDENTIFIED BY '$USERPASS'; flush privileges;
GRANT SELECT,INSERT,CREATE TEMPORARY TABLES ON posts.* TO worker@'$ACCESSFROMIP' IDENTIFIED BY '$USERPASS'; flush privileges;

-- https://devopscube.com/setup-mysql-master-slave-replication/
-- create two accounts for each of the slave systems to connect to the master to begin replication

GRANT REPLICATION SLAVE ON *.* TO 'replicauser'@'$MS1IP' IDENTIFIED BY '$USERPASS';
GRANT REPLICATION SLAVE ON *.* TO 'replicauser'@'$MS2IP' IDENTIFIED BY '$USERPASS';

flush privileges;