#!/bin/bash

sudo firewall-cmd --zone=public --add-service=http --permanent

sudo firewall-cmd --reload