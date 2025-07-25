# Add values
# Use the AMI of the custom Ec2 image you previously created
imageid                = "ami-021769d848635b6f4"
# Use t2.micro for the AWS Free Tier
instance-type          = "t2.micro"
key-name               = "vagrant-463-key-pair"
vpc_security_group_ids = "sg-0fafd233da91b97bd"
tag-name               = "module-06"
temp-tag               = "temp-instance-for-mod-06"
user-sns-topic         = "jrh-updates"
elb-name               = "jrh-elb"
tg-name                = "jrh-tg"
asg-name               = "jrh-asg"
desired                = 3
min                    = 2
max                    = 5
number-of-azs          = 3
region                 = "us-east-2"
raw-s3-bucket          = "jrh-raw-bucket"
finished-s3-bucket     = "jrh-finished-bucket"
dbname                 = "company"
username               = "controller"
