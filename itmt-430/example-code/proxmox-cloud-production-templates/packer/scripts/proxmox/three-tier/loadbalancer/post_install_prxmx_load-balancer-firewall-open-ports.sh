#!/bin/bash

sudo firewall-cmd --zone=meta-network --add-services=https --permanent

sudo firewall-cmd --reload