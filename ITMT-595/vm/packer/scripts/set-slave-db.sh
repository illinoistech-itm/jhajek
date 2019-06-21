#!/bin/bash

echo "192.168.50.14  mongodb-rep1-server" >> /etc/hosts
echo "192.168.50.15  redis-caching-server" >> /etc/hosts

# Create mongodb config
sudo chown vagrant /etc/mongod.conf

sudo cat <<EOT > /etc/mongod.conf
# mongod.conf

# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# Where and how to store data.
storage:
  dbPath: /var/lib/mongodb
  journal:
    enabled: true
#  engine:
#  mmapv1:
#  wiredTiger:

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log

# network interfaces
net:
  port: 27017
  bindIp: mongodb-rep1-server


# how the process runs
processManagement:
  timeZoneInfo: /usr/share/zoneinfo

#security:

#operationProfiling:

#replication:

#sharding:

## Enterprise-Only Options:

#auditLog:

#snmp:

setParameter:
   enableLocalhostAuthBypass: false
EOT

sudo cat <<EOT > ~/rsInit.js
rs.status()
EOT

sudo cat <<EOT > ~/setSlave.js
db.getMongo().setSlaveOk()
EOT

sudo mongod --fork --logpath /var/log/mongodb.log --config /etc/mongod.conf --replSet rs0 --enableMajorityReadConcern
sudo mongo --host mongodb-rep1-server ~/rsInit.js
sudo mongo --host mongodb-rep1-server < ~/setSlave.js

sudo kill -9 $(pidof mongod)
echo "[MONGODB REP1] Set slave database..."
