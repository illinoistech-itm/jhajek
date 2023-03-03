#!/bin/bash

#!/bin/bash

# Syntax to open a firewall port on the meta-network -- not the public
# network interface as the frontend will only be listening on the 10.110.0.0/16 meta-network
 
# In this example, port 3000 is open because ExpressJS server is listening on that port
# by default -- you should change this to match the port your application is being served on

sudo firewall-cmd --zone=meta-network --add-port=3000/tcp --permanent

sudo firewall-cmd --reload