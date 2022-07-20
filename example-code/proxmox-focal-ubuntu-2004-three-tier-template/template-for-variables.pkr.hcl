//  variables.pkr.hcl

// For those variables that you don't provide a default for, you must
// set them from the command line, a var-file, or the environment.

###############################################################################
# These are the connection varaibles to have Packer connect via the Proxmox API
# and create a virtual machine template - these are only set once
###############################################################################

# This value is the name of the proxmox server, we have 4 proxmonster, 
# proxmonster2, proxmonster3, and proxmonster4
variable "NODENAME" {
  type    = string
  default = ""
}

# This is the API token ACCESSKEY (also referred to as a USERNAME but ACCESSKEY
# is the proper cloud term)
variable "USERNAME" {
  sensitive = true
  type   = string
  default = ""
}

# This is the TOKEN_ID provided to you -- also in cloud terms called the SECRETKEY -- technically you could call it a 
# PASSWORD, but that is the wrong terminology
variable "PROXMOX_TOKEN" {
  sensitive = true
  type   = string
  default = ""
}

# This is the URL to connect to the NODENAME defined above: template is https://x.x.x.x:8006/api2/json
variable "URL" {
  type = string
  default = ""
}

######################################################################################################
# These variables are instance variables, meaning you can set the memory,CPU, and other hardware 
# settings for each system independantly -- just by creating a new variable.
# Example: MEMORY can be defined and the same value used for all Packer Source Blocks or you
# could define MEMORY-LB MEMORY-DB and MEMORY-WS in order to assign different amount of memory to each
# template.  In this case we won't do that here -- but let that bedefined when we deploy instances
# via Terraform
######################################################################################################

# This is the place to add the SSH password -- best not to hardcode this into the template code 
variable "SSHPW" {
  type = string
  default = ""
  sensitive = true
}

variable "MEMORY" {
  type    = string
  default = "4096"
}

variable "DISKSIZE" {
  type    = string
  default = "20G"
}

variable "STORAGEPOOL" {
  type = string
  default = "datadisk1"
}

variable "NUMBEROFCORES" {
  type    = string
  default = "1"
}

###################################################################################
# We will have to have multiple variables for VMNAME as we want each template to
# have a different name
###################################################################################

# This is the name of the Virtual Machine Template you want to create
variable "VMNAME-LB" {
  type    = string
  default = ""
}

# This is the name of the Virtual Machine Template you want to create
variable "VMNAME-WS" {
  type    = string
  default = ""
}

# This is the name of the Virtual Machine Template you want to create
variable "VMNAME-DB" {
  type    = string
  default = ""
}
