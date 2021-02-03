#!/bin/bash

packer build --var-file=variables-lb.json ./ubuntu-lb-multi.json ; packer build --var-file=variables-ws.json ./ubuntu-ws1-multi.json ; packer build --var-file=variables-ws.json ./ubuntu-ws2-multi.json ; packer build --var-file=variables-ws.json ./ubuntu-ws3-multi.json