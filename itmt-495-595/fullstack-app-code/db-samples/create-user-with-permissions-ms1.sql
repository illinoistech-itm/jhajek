-- This file creates a user named worker and passes in the password declared in the environment variables
-- Depending on the user, you may not want CREATE and DELETE permissions

-- https://devopscube.com/setup-mysql-master-slave-replication/
STOP SLAVE;
CHANGE MASTER TO MASTER_HOST='$MMIP',MASTER_USER='replicauser', MASTER_PASSWORD='$USERPASS', MASTER_LOG_FILE='mysql-bin.000001', MASTER_LOG_POS=  313;
START SLAVE;
SHOW SLAVE STATUS