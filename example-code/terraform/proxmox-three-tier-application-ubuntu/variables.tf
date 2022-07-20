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

variable "numberofvms" {}

variable "target_node" {}

variable "memory" {}

variable "cores" {}

variable "sockets" {}

variable "disk_size" {}

variable "keypath" {}

variable "consulip" {}

variable "yourinitials-lb" {}

variable "yourinitials-ws" {}

variable "yourinitials-db" {}

variable "desc-lb" {}

variable "desc-ws" {}

variable "desc-db" {}

variable "template_to_clone-lb" {}

variable "template_to_clone-ws" {}

variable "template_to_clone-db" {}

variable "numberofvms-ws" {}
