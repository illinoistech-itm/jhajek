#!/bin/bash

cat << EOT >> /etc/hosts
# Hadoop Datanodes
192.168.1.101 datanode1 datanode1.sat.iit.edu
192.168.1.102 datanode2 datanode2.sat.iit.edu
192.168.1.103 datanode3 datanode3.sat.iit.edu
192.168.1.104 datanode4 datanode4.sat.iit.edu
192.168.1.105 datanode5 datanode5.sat.iit.edu
192.168.1.106 databaseserver databaseserver.sat.iit.edu

# namenode
192.168.1.100 namenode namenode.sat.iit.edu
#riemannmc
10.101.0.2 riemannmc  riemannmc.sat.iit.edu
EOT