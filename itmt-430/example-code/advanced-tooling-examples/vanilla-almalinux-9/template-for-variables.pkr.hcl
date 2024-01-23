variable "headless_build" {
  type =  bool
  default = false
}

variable "memory_amount" {
  type =  string
  default = "2048"
}

variable "SSHPW" {
  sensitive = true
  type = string
  default = ""
}

variable "build_artifact_location" {
  type = string
  default = "../build/"
}