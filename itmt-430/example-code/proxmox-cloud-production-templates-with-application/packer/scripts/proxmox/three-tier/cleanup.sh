#!/bin/bash

# Cleaning up all the left over files in the user's home directory

rm -v node-exporter.service
rm -v consul.conf
rm -rfv node_exporter-1.4.0.linux-amd64
rm -rfv node_exporter-1.4.0.linux-amd64.tar.gz
rm -v /home/vagrant/.ssh/id_ed25519*