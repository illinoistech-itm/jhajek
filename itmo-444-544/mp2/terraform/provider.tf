terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
  shared_credentials_files = ["/home/vagrant/.aws/credentials"]
}