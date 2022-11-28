#!/bin/bash

######################################################################
# Format of arguments.txt
# $1 image-id
# $2 instance-type
# $3 key-name
# $4 security-group-ids
# $5 count (3)
# $6 availability-zone
# $7 elb name
# $8 target group name
# $9 auto-scaling group name
# ${10} launch configuration name
# ${11} db instance identifier (database name)
# ${12} db instance identifier (for read-replica), append *-rpl*
# ${13} min-size = 2
# ${14} max-size = 5
# ${15} desired-capacity = 3
# ${16} Database engine (use mariadb)
# ${17} Database name ( use company )
# ${18} s3 raw bucket name (use initials and -raw)
# ${19} s3 finished bucket name (use initials and -fin)
# ${20} aws secret name
# ${21} iam-instance-profile
# ${22} sns topic name
######################################################################
