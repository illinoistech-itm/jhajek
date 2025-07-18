# Terraform has datatypes, like a programming language we need to define our variables
# We can have default values or define at run time or via a terraform.tfvars file


# https://developer.hashicorp.com/terraform/language/expressions/types
# string: a sequence of Unicode characters representing some text, like "hello".
# number: a numeric value. The number type can represent both whole numbers like 15 and fractional values like 6.283185.
# bool: a boolean value, either true or false. bool values can be used in conditional logic.
# list (or tuple): a sequence of values, like ["us-west-1a", "us-west-1c"]. Identify elements in a list with consecutive whole numbers, starting with zero.
# set: a collection of unique values that do not have any secondary identifiers or ordering.
# map (or object): a group of values identified by named labels, like {name = "Mabel", age = 52}.

# Default types are stings, lists, and maps

variable "instance-type" {}
variable "key-name" {}
variable "az" { default = ["us-east-2a", "us-east-2b", "us-east-2c"] }
variable "tag" {}
variable "tg-name" {}
variable "elb-name" {}
variable "asg-name" {}
variable "lt-name" {}
