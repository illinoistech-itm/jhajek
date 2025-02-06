//  variables.pkr.hcl

// For those variables that you don't provide a default for, you must
// set them from the command line, a var-file, or the environment.

# This is the name of the node in the Cloud Cluster where to deploy the virtual instances
locals {
  NODENAME = vault("/secret/data/NODENAME","SYSTEM41")
}

locals {
  USERNAME = vault("/secret/data/SECRETKEY","PK-USERNAME")
}

locals {
  PROXMOX_TOKEN = vault("/secret/data/ACCESSKEY","PK-TOKEN")
}

locals {
  URL = vault("/secret/data/URL","S41")
}

locals {
  SSHPW = vault("/secret/data/SSH","SSHPW")
}

locals {
  SSHUSER = vault("/secret/data/SSH","SSHUSER")
}

variable "MEMORY" {
  type    = string
  default = "4096"
}

# Best to keep this low -- you can expand the size of a disk when deploying 
# instances from templates - but not reduce the disk size -- No need to edit this
variable "DISKSIZE" {
  type    = string
  default = "25G"
}

# This is the name of the disk the build template will be stored on in the 
# Proxmox cloud -- No need to edit this
variable "STORAGEPOOL" {
  type    = string
  default = "datadisk1"
}

variable "NUMBEROFCORES" {
  type    = string
  default = "1"
}

# This is the name of the Virtual Machine Template you want to create
variable "frontend-VMNAME" {
  type    = string
  default = ""
}

# This is the name of the Virtual Machine Template you want to create
variable "backend-VMNAME" {
  type    = string
  default = ""
}

# This is the name of the Virtual Machine Template you want to create
variable "loadbalancer-VMNAME" {
  type    = string
  default = ""
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

# This will be the non-root user account name
variable "DBUSER" {
  type      = string
  sensitive = true
  default   = "REPLACE"
}

# This will be the Database user (non-root) password setup
variable "DBPASS" {
  type      = string
  sensitive = true
  default   = "REPLACE"
}

# This variable is the IP address range to allow your connections
# The SQL wildcard is the %
# 10.110.%.%
variable "CONNECTIONFROMIPRANGE" {
  type      = string
  sensitive = true
  default   = "REPLACE"
}

# This will be the fully qualified domain name: team-00-be-vm0.service.consul
variable "FQDN" {
  type      = string
  sensitive = true
  default   = "REPLACE"
}

# This will be the Database name you default to (like posts or comments or customers)
variable "DATABASE" {
  type      = string
  sensitive = true
  default   = "REPLACE"
}
