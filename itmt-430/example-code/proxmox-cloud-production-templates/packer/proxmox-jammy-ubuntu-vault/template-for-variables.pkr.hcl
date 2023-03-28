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

variable "TOKEN_SECRET" {
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
  type    = string
  default = "datadisk2"
}

variable "NUMBEROFCORES" {
  type    = string
  default = "1"
}

# This is the password set in the subiquity/http/user-data line 9,
# default password is vagrant, and password auth will be remove 
# and replaced with Public Key Authentication at run time --
# This is only for build time
variable "SSHPW" {
  type      = string
  default   = ""
  sensitive = true
}

variable "ISO-CHECKSUM" {
  type    = string
  default = "sha256:5e38b55d57d94ff029719342357325ed3bda38fa80054f9330dc789cd2d43931"
}

variable "ISO-URL" {
  type    = string
  default = "https://mirrors.edge.kernel.org/ubuntu-releases/22.04.2/ubuntu-22.04.2-live-server-amd64.iso"
}

variable "vault-VMNAME" {
  type = string
  default = ""
}