//  variables.pkr.hcl

// For those variables that you don't provide a default for, you must
// set them from the command line, a var-file, or the environment.

# This is the name of the node in the Cloud Cluster where to deploy the virtual instances
locals {
  NODENAME = vault("/secret/data/team00-NODENAME","NODENAME1")
}

locals {
  NODENAME2 = vault("/secret/data/proxmox-infra-ssh-NODENAME","NODENAME2")
}

locals {
  USERNAME = vault("/secret/data/team00-username-packer-infra","USERNAME")
}

locals {
  PROXMOX_TOKEN = vault("/secret/data/team00-token-packer-infra","TOKEN")
}

locals {
  URL = vault("/secret/data/team00-url","SYSTEM29")
}

locals {
  SSHPW = vault("/secret/data/team00-ssh","SSHPASS")
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
  default = "jammy-grafana-infra-template"
}

variable "iso_checksum" {
  type    = string
  default = "file:https://mirrors.edge.kernel.org/ubuntu-releases/22.04.5/SHA256SUMS"
}

variable "iso_urls" {
  type    = list(string)
  default = ["http://mirrors.edge.kernel.org/ubuntu-releases/22.04.5/ubuntu-22.04.5-live-server-amd64.iso"]
}

variable "local_iso_name" {
  type    = string
  default = "ubuntu-22.04.5-live-server-amd64.iso"
}

variable "TAGS" {
  type = string
  default  = "grafana;team00"
}
