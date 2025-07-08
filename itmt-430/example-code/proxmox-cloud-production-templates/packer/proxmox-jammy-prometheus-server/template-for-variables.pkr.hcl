//  variables.pkr.hcl

// For those variables that you don't provide a default for, you must
// set them from the command line, a var-file, or the environment.

# This is the name of the node in the Cloud Cluster where to deploy the virtual instances
locals {
  NODENAME1 = vault("/secret/data/proxmox-infra-ssh-NODENAME","NODENAME1")
}

locals {
  NODENAME2 = vault("/secret/data/proxmox-infra-ssh-NODENAME","NODENAME2")
}

locals {
  USERNAME = vault("/secret/data/proxmox-infra-ssh-username-packer-infra","USERNAME")
}

locals {
  PROXMOX_TOKEN = vault("/secret/data/proxmox-infra-ssh-token-packer-infra","TOKEN")
}

locals {
  URL = vault("/secret/data/proxmox-infra-ssh-url","SYSTEM29")
}

locals {
  SSHPW = vault("/secret/data/proxmox-infra-ssh","SSHPW")
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
  type = string
  default = "datadisk1"
}

variable "NUMBEROFCORES" {
  type    = string
  default = "1"
}

# This is the name of the Virtual Machine Template you want to create
variable "VMNAME" {
  type    = string
  default = "jammy-prometheus-infra-template"
}

variable "iso_checksum" {
  type = string
  default =  "file:http://mirrors.edge.kernel.org/ubuntu-releases/22.04.4/SHA256SUMS"
}

# https://developer.hashicorp.com/terraform/language/values/variables#declaring-an-input-variable
variable "iso_urls" {
  type    = list(string)
  default = ["https://mirrors.edge.kernel.org/ubuntu-releases/22.04.4/ubuntu-22.04.4-live-server-amd64.iso","http://www.releases.ubuntu.com/jammy/ubuntu-22.04.4-live-server-amd64.iso"]
}