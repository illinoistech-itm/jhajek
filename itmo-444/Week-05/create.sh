#!/bin/bash

# shell script to create AWS resources

aws ec2 run-instances ami keypair security-group count -f user-data 
