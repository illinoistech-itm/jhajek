#!/bin/bash

sudo firewall-cmd --zone=meta-network --add-service=https --permanent

sudo firewall-cmd --reload