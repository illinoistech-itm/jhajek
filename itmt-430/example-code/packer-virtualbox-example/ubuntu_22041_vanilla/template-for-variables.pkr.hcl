variable "headless_build" {
  type =  bool
  default = false
}

variable "memory_amount" {
  type =  string
  default = "4096"
}

variable "user-ssh-password" {
  type = string
  default = "vagrant"
  sensitive = true
}

variable "build_artifact_location" {
 
 # If building on your local laptop use the ../build path
  type = string
  default = "../build/"

 # If building on the school build-server use this default value
  # This is the default path on the build-server to place the .box files for download via a webserver
  # default = "/datadisk2/boxes/jrh-"

}