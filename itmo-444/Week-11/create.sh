aws ec2 run-instances --image-id ami-51537029 --count 3 --instance-type t2.micro --key-name x44-sp2 --security-groups inclass2018 --user-data file://create-env2.sh
