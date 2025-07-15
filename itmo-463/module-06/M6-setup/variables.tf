#Types
#The Terraform language uses the following types for its values:

# https://developer.hashicorp.com/terraform/language/expressions/types
# string: a sequence of Unicode characters representing some text, like "hello".
# number: a numeric value. The number type can represent both whole numbers like 15 and fractional values like 6.283185.
# bool: a boolean value, either true or false. bool values can be used in conditional logic.
# list (or tuple): a sequence of values, like ["us-west-1a", "us-west-1c"]. Identify elements in a list with consecutive whole numbers, starting with zero.
# set: a collection of unique values that do not have any secondary identifiers or ordering.
# map (or object): a group of values identified by named labels, like {name = "Mabel", age = 52}.

# Default types are stings, lists, and maps

variable "imageid" {}
variable "instance-type" {}
variable "key-name" {}
variable "vpc_security_group_ids" {}
variable "az" { default = ["us-east-2a", "us-east-2b", "us-east-2c"] }
variable "tag-name" {}
variable "user-sns-topic" {}
variable "elb-name" {}
variable "tg-name" {}
variable "asg-name" {}
variable "min" {}
variable "max" {}
variable "desired" {}
variable "number-of-azs" {}
variable "region" {}
variable "raw-s3-bucket" {}
variable "finished-s3-bucket" {}
variable "dbname" {}
variable "username" {}
