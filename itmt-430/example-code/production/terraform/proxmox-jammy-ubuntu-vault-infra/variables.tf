#https://registry.terraform.io/providers/Telmate/proxmox/latest/docs
variable "pm_api_url" {}

variable "yourinitials" {}

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

variable "numberofvms" {}

variable "desc" {}

variable "target_node" {}

variable "template_to_clone" {}

variable "memory" {}

variable "cores" {}

variable "sockets" {}

variable "disk_size" {}

variable "keypath" {}

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
