#!/bin/bash

######################################################################
# Since all elements have been created no need to send any inputs 
# use the --query to get all of the needed IDs and reverse everything
# you did in the create-env.sh 
# you may need to use WAIT in some steps
######################################################################

# You can speed up your RDS termination by requesting RDS to skip taking a final snapshot of data upon delete for a database.

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/rds/delete-db-instance.html 

`--skip-final-snapshot`
