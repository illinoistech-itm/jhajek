# Module-07 Assessment

This assignment will have you creating and destroying cloud native infrastructure in a declarative fashion using Terraform and Hashicorp's control language, HCL. You will be converting the content of your `arguments.txt` file into the provided file `terraform.tfvars`. You will be converting the content of your Module-04 assessment into Terraform HCL.

After successfully running the `terraform apply`, run the shell script `bash ./upload-images-to-s3.sh $(< ~/arguments.txt)` to upload the s3 images to your buckets.

## Documentation Links


* Terraform AWS plugin Documentation
  * [AWS VPC](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc "webpage for AWS VPC")
  * [AWS VPCS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpcs "webpage for AWS VPCS")
  * [AWS Availability Zones](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones "webpage for AWS AZs")
  * [AWS Shuffle](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle#example-usage "webpage for AWS shuffle")
  * [AWS Subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets "webpage for subnets")
  * [AWS load-balancers](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb "webpage for AWS LBs")
  * [AWS Target Groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group "webpage for AWS Target Groups")
  * [AWS load-balancer listeners](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener "webpage for AWS LB listeners")
  * [AWS Launch Templates](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/launch_template "webpage for AWS LTs")
  * [AWS Autoscaling groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group "webpage for AWS Autoscaling groups")
  * [AWS Autoscaling attachments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment "webpage for Autoscaling attachments")

## Arguments to Create

Create and fill out these values in your `terraform.tfvars`

1) imageid
1) instance-type
1) key-name
1) vpc_security_group_ids
1) cnt
1) install-env-file
1) elb-name
1) tg-name
1) asg-name
1) lt-name
1) module-tag
1) raw-s3-bucket
1) finished-s3-bucket

## How to run your create script

`terraform apply`

This command will read all of your arguments and pass them into the shell script in order.

## How to grade your create script

After the `terraform apply` run completes you will need to run from the commandline the Python script to test and grade your create script.

`python3 ./terraform-create-env-test.py` 

This script will generate graded output and give you feedback on your deliverable. You are welcome to fix your script and try again in any areas of the grading that fail. Your submission to Coursera will be a `create-env-module-07-results.txt` file.

## How run your destroy script

In addition you are required to find the proper **delete/terminate** commands to tear down the cloud infrastructure you built. This helps you to better understand how the pieces connect and helps prevent you from leaving resources running and incurring extra charges!

`terraform destroy`

## How to grade your destroy script

After the `terraform destroy` run completes you will need to run from the commandline the Python script to test and grade your create script.

`python3 ./terraform-destroy-env-test.py`

This will run tests to make sure all resources from the assignment has been deleted. If any of the tests fail you will be given feedback and can attempt again. Your submission to Coursera will be a `destroy-env-module-07-results.txt` file.
