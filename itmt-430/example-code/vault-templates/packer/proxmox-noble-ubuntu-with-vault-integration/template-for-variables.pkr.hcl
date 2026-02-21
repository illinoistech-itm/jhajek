//  variables.pkr.hcl

// For those variables that you don't provide a default for, you must
// set them from the command line, a var-file, or the environment.

# This is the name of the node in the Cloud Cluster where to deploy the virtual instances
locals {
  NODENAME = vault("/secret/data/team00-NODENAME", "NODENAME4")
}

locals {
  USERNAME = vault("/secret/data/team00-username-packer-system", "USERNAME")
}

locals {
  PROXMOX_TOKEN = vault("/secret/data/team00-token-packer-system", "TOKEN")
}

locals {
  URL = vault("/secret/data/team00-url", "SYSTEM82")
}

locals {
  SSHPW = vault("/secret/data/team00-ssh", "SSHPASS")
}

variable "MEMORY" {
  type    = string
  default = "8192"
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

# This is the name of the Virtual Machine Template you want to create
variable "VMNAME" {
  type    = string
  default = "teamXX-template"
}

variable "TAGS" {
  # Place your initials first then team name and any other tag seperated via ;
  type    = string
  default = "team;type-of-server"
}

variable "iso_checksum" {
  type    = string
  default = "file:https://mirrors.edge.kernel.org/ubuntu-releases/24.04.5/SHA256SUMS"
}

# https://developer.hashicorp.com/terraform/language/values/variables#declaring-an-input-variable
variable "iso_urls" {
  type    = list(string)
  default = ["https://mirrors.edge.kernel.org/ubuntu-releases/24.04.5/ubuntu-24.04.5-live-server-amd64.iso"]
}
  