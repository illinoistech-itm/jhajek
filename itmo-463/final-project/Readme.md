# Final Project

Your goal in this final project is to use the AWS Language SDK of your choice to create code to verify the results of each of the deployed Module Sample codes you were given. I will be demonstrating using the AWS Python SDK, known as [boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html "webpage for AWS sdk boto3").

## Pre-reqs to Install

You will need to have some Python packages installed on your Vagrant Box.

```bash
sudo apt update
sudo apt install python3-setuptools python3-pip python3-dev
```

Then use the `requirements.txt` to install the needed Python packages. 

```bash
python3 -m pip install --upgrade pip
python3 -m pip install -r requirements.txt
```

### Module 03

Write code to detect, grade, and display if this content is present. This code for module-03 will be provided for you.

1) VPC tagged with module-03
1) Security group tagged
1) HTTP check works
1) **three** EC2 instances (all tagged module-03) 
1) Internet gateway tagged module-03
1) Route table tagged module-03
1) 3 subnets tagged module-03 
1) DHCP options tagged module-03
1) Check to make sure 1 route table is attached to IG

### Module 04

Write code to detect, grade, and display if this content is present. You are able to reuse code from the previous module test.

1) VPC tagged
1) Security group tagged
1) HTTP check works +
1) **three** EC2 instances tagged
1) Internet gateway tagged
1) Route table tagged
1) 3 subnets tagged 
1) DHCP options tagged
1) Check to make sure 1 route table is attached to IG
1) 1 Load Balancer tagged

### Module 05

Write code to detect, grade, and display if this content is present. You are able to reuse code from the previous module test.

1) VPC tagged
1) Security group tagged
1) HTTP check works +
1) **three** EC2 instances tagged
1) Internet gateway tagged
1) Route table tagged
1) 3 subnets tagged 
1) DHCP options tagged
1) Check to make sure 1 route table is attached to IG
1) 1 Load Balancer tagged
1) 1 autoscaling group tagged
1) 1 launch template tagged

### Module 06

Write code to detect, grade, and display if this content is present. You are able to reuse code from the previous module test.

1) VPC tagged
1) Security group tagged
1) HTTP check works +
1) **three** EC2 instances tagged
1) Internet gateway tagged
1) Route table tagged
1) 3 subnets tagged 
1) DHCP options tagged
1) Check to make sure 1 route table is attached to IG
1) 1 Load Balancer tagged
1) 1 autoscaling group tagged
1) 1 launch template tagged
1) Database snapshot tagged (need to add this in your main.tf when creating it)

### Module 07

Write code to detect, grade, and display if this content is present. You are able to reuse code from the previous module test.

1) VPC tagged
1) Security group tagged
1) HTTP check works +
1) **three** EC2 instances tagged
1) Internet gateway tagged
1) Route table tagged
1) 3 subnets tagged 
1) DHCP options tagged
1) Check to make sure 1 route table is attached to IG
1) 1 Load Balancer tagged
1) 1 autoscaling group tagged
1) 1 launch template tagged
1) Database snapshot tagged (need to add this in your main.tf when creating it)
1) 1 RDS DB instance tagged

## Final Deliverable
 
Create a video (pause as necessary) that shows your deployed artifacts from each module (04-07) then show your Python script running and the final grade output. Give a 1-2 minute explanation of what the code from the module does and any insights or issues you had while deploying it.
