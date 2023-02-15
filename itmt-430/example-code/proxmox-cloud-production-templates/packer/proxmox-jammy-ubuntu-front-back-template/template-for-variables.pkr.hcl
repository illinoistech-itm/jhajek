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
  type   = string
  default = ""
}

variable "TOKEN_SECRET" {
  sensitive = true
  type   = string
  default = ""
}

variable "URL" {
  type = string
  # https://x.x.x.x:8006/api2/json
  default = ""
  sensitive = true
}

variable "MEMORY" {
  type    = string
  default = "4192"
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
  type = string
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

# This is the password set in the subiquity/http/user-data line 9,
# default password is vagrant, and password auth will be remove 
# and replaced with Public Key Authentication at run time --
# This is only for build time
variable "frontend-SSHPW" {
  type    = string
  default = ""
  sensitive = true
}

# This is the name of the Virtual Machine Template you want to create
variable "backend-VMNAME" {
  type    = string
  default = ""
}

# This is the password set in the subiquity/http/user-data line 9,
# default password is vagrant, and password auth will be remove 
# and replaced with Public Key Authentication at run time --
# This is only for build time
variable "backend-SSHPW" {
  type    = string
  default = ""
  sensitive = true
}
