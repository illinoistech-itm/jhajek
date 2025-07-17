terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" 
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1" # or your preferred version
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  # Change this region to match your default region
  region                   = "us-east-2"
  shared_credentials_files = ["/home/vagrant/.aws/credentials"]
}
