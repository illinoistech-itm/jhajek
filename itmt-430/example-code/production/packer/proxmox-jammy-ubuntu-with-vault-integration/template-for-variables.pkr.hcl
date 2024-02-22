//  variables.pkr.hcl

// For those variables that you don't provide a default for, you must
// set them from the command line, a var-file, or the environment.

# This is the name of the node in the Cloud Cluster where to deploy the virtual instances
locals {
  NODENAME = vault("/secret/data/team00-NODENAME","NODENAME4")
}

locals {
  USERNAME = vault("/secret/data/team00-username-packer-system","USERNAME")
}

locals {
  PROXMOX_TOKEN = vault("/secret/data/team00-token-packer-system","TOKEN")
}

locals {
  URL = vault("/secret/data/team00-url","SYSTEM42")
}

locals {
  SSHPW = vault("/secret/data/team00-ssh","SSHPASS")
}

variable "MEMORY" {
  type    = string
  default = "4192"
}

variable "DISKSIZE" {
  type    = string
  default = "25G"
}

variable "STORAGEPOOL" {
  type    = string
  default = "datadisk1"
}

variable "NUMBEROFCORES" {
  type    = string
  default = "1"
}

# This is the name of the Virtual Machine Template you want to create
variable "VMNAME" {
  type    = string
  default = "teamXX-template"
}

variable "iso_checksum" {
  type = string
  default =  "file:https://mirrors.edge.kernel.org/ubuntu-releases/22.04.4/SHA256SUMS"
}

# https://developer.hashicorp.com/terraform/language/values/variables#declaring-an-input-variable
variable "iso_urls" {
  type    = list(string)
  default = ["https://mirrors.edge.kernel.org/ubuntu-releases/22.04.4/ubuntu-22.04.4-live-server-amd64.iso","http://www.releases.ubuntu.com/jammy/ubuntu-22.04.4-live-server-amd64.iso"]
}
  