variable "headless_build" {
  # allows you to suppress the VirtualBox GUI (hidden) if set to True
  type =  bool
  default = false
}

variable "memory_amount" {
  type =  string
  default = "4096"
}

variable "user-ssh-password" {
  type = string
  default = ""
  sensitive = true
}

variable "build_artifact_location" {
  # Location on your local Filesystem when the built Vagrant .box file will be exported to
  # The location is arbitrary, but it makes sense to put built artifacts into a directory named: build
  type = string
  default = "../build/"

}