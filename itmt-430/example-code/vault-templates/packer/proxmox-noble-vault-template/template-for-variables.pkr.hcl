//  variables.pkr.hcl

// For those variables that you don't provide a default for, you must
// set them from the command line, a var-file, or the environment.

# This is the name of the node in the Cloud Cluster where to deploy the virtual instances
variable "NODENAME" {
  type    = string
  default = ""
}

variable "TOKEN_ID" {
  sensitive = true
  type      = string
  default   = ""
}

variable "TOKEN_VALUE" {
  sensitive = true
  type      = string
  default   = ""
}

variable "URL" {
  type = string
  # https://x.x.x.x:8006/api2/json
  default   = ""
  sensitive = true
}

variable "MEMORY" {
  type    = string
  default = "4096"
}

variable "DISKSIZE" {
  type    = string
  default = "10G"
}

variable "STORAGEPOOL" {
  type    = string
  default = "templatedisk"
}

variable "NUMBEROFCORES" {
  type    = string
  default = "1"
}

variable "BIND_ADDRESS" {
  type    = string
  default = "10.110.0.98"
}

# REPLACE XX with your number
variable "TAGS" {
  type    = string
  default = "teamXX;vault"
}

# This is the name of the Virtual Machine Template you want to create
# REPLACE XX with your number
variable "VMNAME" {
  type    = string
  default = "teamXX-vault-server"
}

variable "SSHPW" {
  type      = string
  default   = "vagrant"
  sensitive = true
}
