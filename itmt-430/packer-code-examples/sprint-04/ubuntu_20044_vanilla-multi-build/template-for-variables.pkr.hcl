variable "headless_build" {
  type =  bool
  default = false
  # If using the IIT Build Server - change this value to true
}

variable "memory_amount" {
  type =  string
  default = "4096"
}

variable "SSHPW" {
  sensitive = true
  type = string
  default = ""
}

variable "build_artifact_location" {
  type = string
  # default = "../build/"
  # If building the artifact on your local system -- keep the default
  # If you are building on the ITM Build Server (192.168.172.44) then 
  # uncomment the value below and comment out the initial default value
  # The teamXX can be replaced by your team number
  default = "/datadisk2/boxes/teamXX-"
}

variable "non-root-user-for-database-password" {
  type = string
  sensitive = true
  default = ""
}

variable "non-root-user-for-database-username" {
  type = string
  sensitive = true
  default = ""
}

variable "restrict-firewall-access-to-this-ip-range-virtualbox" {
  type = string
  sensitive = true
  default = ""
}

variable "restrict-firewall-access-to-this-ip-range-proxmox" {
  type = string
  sensitive = true
  default = ""
}

//  variables for PROXMOX Cloud Instances

// For those variables that you don't provide a default for, you must
// set them from the command line, a var-file, or the environment.

# This is the name of the node in the Cloud Cluster where to deploy the virtual instances
variable "NODENAME" {
  type    = string
  default = ""
}

variable "USERNAME" {
  sensitive = true
  type   = string
  default = ""
}

variable "PROXMOX_TOKEN" {
  sensitive = true
  type   = string
  default = ""
}

variable "URL" {
  type = string
  # https://x.x.x.x:8006/api2/json
  default = ""
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
  type = string
  default = "datadisk2"
}

variable "NUMBEROFCORES" {
  type    = string
  default = "1"
}

# This is the name of the Virtual Machine Template you want to create
variable "VMNAME" {
  type    = string
  default = ""
}

variable "KEYNAME" {
  type = string
  # Name of public key to insert to the template 
  default = ""
}

# This is the name of the Virtual Machine Template you want to create
variable "LBNAME" {
  type    = string
  default = ""
}

# This is the name of the Virtual Machine Template you want to create
variable "WSNAME" {
  type    = string
  default = ""
}

# This is the name of the Virtual Machine Template you want to create
variable "DBNAME" {
  type    = string
  default = ""
}

# Team Number with leading Zeros
variable "TEAMNUMBER" {
  type    = string
  default = ""
}