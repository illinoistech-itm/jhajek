-- This file creates a user named worker and passes in the password declared in the environment variables
-- Depending on the user, you may not want CREATE and DELETE permissions

-- ACCESSFROMIP is defined in variables.pkr.hcl as a USER VARIABLE
-- USERPASS is defined in variables.pkr.hcl as a USER VARIABLE non-root-user-for-database-password 

-- GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,CREATE TEMPORARY TABLES,DROP,INDEX,ALTER ON posts.* TO worker@'$ACCESSFROMIP' IDENTIFIED BY '$USERPASS'; flush privileges;
GRANT SELECT,INSERT,CREATE TEMPORARY TABLES ON posts.* TO '$USERNAME'@'$ACCESSFROMIP' IDENTIFIED BY '$USERPASS'; 

flush privileges;
