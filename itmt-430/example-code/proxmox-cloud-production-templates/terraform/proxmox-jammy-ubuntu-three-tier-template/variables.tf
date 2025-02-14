#https://registry.terraform.io/providers/Telmate/proxmox/latest/docs

variable "error_level" {
  default = "debug"
}

variable "pm_log_enable" {}

variable "pm_parallel" {}

variable "pm_timeout" {}

variable "pm_log_file" {}

variable "frontend-numberofvms" {}
variable "backend-numberofvms" {}
variable "lb-numberofvms" {}

variable "frontend-desc" {}
variable "backend-desc" {}
variable "lb-desc" {}
variable "lb-macaddr" {}

variable "frontend-template_to_clone" {}
variable "backend-template_to_clone" {}
variable "lb-template_to_clone" {}

variable "frontend-memory" {}
variable "backend-memory" {}
variable "lb-memory" {}

variable "frontend-cores" {}
variable "backend-cores" {}
variable "lb-cores" {}

variable "frontend-sockets" {}
variable "backend-sockets" {}
variable "lb-sockets" {}

variable "frontend-disk_size" {}
variable "backend-disk_size" {}
variable "lb-disk_size" {}

variable "keypath" {}

variable "frontend-yourinitials" {}
variable "backend-yourinitials" {}
variable "lb-yourinitials" {}

variable "fe-tags" {}
variable "lb-tags" {}
variable "be-tags" {}

variable "consul-service-tag-contact-email" {}

variable "additional_wait" {
  default = 30
}

variable "clone_wait" {
  default = 30
}
###############################################################################
# This is the consul dns master -- no need to edit this
###############################################################################
variable "consulip-240-prod-system28" {
  default = "10.110.0.59"
}

variable "consulip-240-student-system41" {
  default = "10.110.0.58"
}

variable "consulip-242-room" {
  default = "10.110.0.38"
}

