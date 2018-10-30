aws ec2 run-instances --image-id ami-51537029 --count 3 --instance-type t2.micro --key-name x44-sp2 --security-groups inclass2018 --user-data file://create-env2.sh

VAR=`aws ec2 describe-instances --query 'Reservations[0].Instances[*].InstanceId'`

aws ec2 wait instance-running --instance-ids $VAR 

aws elb create-load-balancer --load-balancer-name inclass-2018 --listeners "Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=80" --availability-zones us-west-2a


aws elb register-instances-with-load-balancer --load-balancer-name inclass-2018 --instances $VAR 



