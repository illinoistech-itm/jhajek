#!/bin/bash

sudo firewall-cmd --zone=public --add-service=mysql --permanent

sudo firewall-cmd --reload