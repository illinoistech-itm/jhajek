#https://registry.terraform.io/providers/Telmate/proxmox/latest/docs
variable "pm_api_url" {}

variable "pm_api_token_id" {
  sensitive = true
}

variable "pm_api_token_secret" {
  sensitive = true
}

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

variable "target_node" {}

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
variable "consulip" {
  default = "10.110.0.36"
}
