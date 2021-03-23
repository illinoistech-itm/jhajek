-- This file creates a user named worker and passes in the password declared in the environment variables
-- Depending on the user, you may not want CREATE and DELETE permissions

-- GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON posts.* TO worker@'$ACCESSFROMIP' IDENTIFIED BY '$USERPASS'; flush privileges;
GRANT SELECT,INSERT,UPDATE, DELETE, INDEX, ALTER,  DROP, LOCK TABLES, CREATE ON $DATABASENAME.* TO worker@'$ACCESSFROMIP' IDENTIFIED BY '$USERPASS';
flush privileges;