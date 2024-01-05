#!/bin/bash

sudo firewall-cmd --zone=public --add-service=https --permanent

sudo firewall-cmd --reload