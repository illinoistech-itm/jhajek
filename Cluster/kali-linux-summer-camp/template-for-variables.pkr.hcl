//  variables.pkr.hcl

// For those variables that you don't provide a default for, you must
// set them from the command line, a var-file, or the environment.

# This is the name of the node in the Cloud Cluster where to deploy the virtual instances
locals {
  NODENAME = vault("/secret/data/team00-NODENAME","NODENAME4")
}

locals {
  NODENAME3 = vault("/secret/data/team00-NODENAME","NODENAME3")
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
  SSHPW = vault("/secret/data/team00-ssh","SSHPW")
}

variable "MEMORY" {
  type    = string
  default = "4096"
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
  default = "kali-summer-camp-template"
}

# https://www.kali.org/get-kali/#kali-installer-images
variable "iso_checksum" {
  type = string
  default =  "5eb9dc96cccbdfe7610d3cbced1bd6ee89b5acdfc83ffee1f06e6d02b058390c"
}

# https://developer.hashicorp.com/terraform/language/values/variables#declaring-an-input-variable
variable "iso_urls" {
  type    = list(string)
  default = ["https://cdimage.kali.org/kali-2024.2/kali-linux-2024.2-installer-amd64.iso"]
}
  