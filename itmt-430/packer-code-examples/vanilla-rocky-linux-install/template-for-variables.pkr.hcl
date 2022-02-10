variable "headless_build" {
  type =  bool
  default = false
}

variable "memory_amount" {
  type =  string
  default = "2048"
}

variable "build_artifact_location" {
  type = string
  default = "../build/"
  # This is the default path on the build-server to place the .box files for download via a webserver
  # XYZ are your team name or initials
  # default = "/datadisk2/boxes/XYZ-"
}