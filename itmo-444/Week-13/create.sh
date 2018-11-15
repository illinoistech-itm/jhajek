#!/bin/bash

aws autoscaling create-launch-configuration --launch-configuration-name jrh-asg-lc --image-id ami-51537029 --iam-instance-profile inclass-project --instance-type t2.micro --key-name thinkpad --security-groups inclass2018 --user-data file://create-env.sh

aws elb create-load-balancer --load-balancer-name inclass-2018 --listeners "Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80" --availability-zones us-west-2a

sleep 25

aws autoscaling create-auto-scaling-group --auto-scaling-group-name jrh-asg --launch-configuration-name jrh-asg-lc --load-balancer-names inclass-2018 --health-check-type ELB --health-check-grace-period 120 --min 2 --max 4 --desired-capacity 3 --availability-zone us-west-2a
 
 aws elb describe-load-balancers

 aws autoscaling describe-auto-scaling-groups