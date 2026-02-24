##############################################################################
# This file is where we require the Terraform Provider library for AWS
# We also define default region and location of AWS credentials
##############################################################################
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  # Change this region to match your default region
  region                   = "us-east-2"
  shared_credentials_files = ["/home/vagrant/.aws/credentials"]
}

