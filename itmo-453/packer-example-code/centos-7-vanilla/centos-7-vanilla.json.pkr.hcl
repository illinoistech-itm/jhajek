
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "virtualbox-iso" "centos-7-vanilla" {
  boot_command         = ["<up><wait><tab><wait> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks/centos-7-base.cfg<enter><wait>"]
  boot_wait            = "5s"
  communicator         = "ssh"
  disk_size            = 10000
  guest_os_type        = "RedHat_64"
  hard_drive_interface = "sata"
  http_directory       = "."
  http_port_min        = 9001
  http_port_max        = 9100
  iso_checksum         = "sha256:07b94e6b1a0b0260b94c83d6bb76b26bf7a310dc78d7a9c7432809fb9bc6194a"
  iso_url              = "http://bay.uchicago.edu/centos/7.9.2009/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso"
  shutdown_command     = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_password         = "vagrant"
  ssh_pty              = "true"
  ssh_username         = "vagrant"
  ssh_wait_timeout     = "30m"
  vboxmanage           = [["modifyvm", "{{ .Name }}", "--memory", "2048"]]
  vm_name              = "centos-7"
}

build {
  sources = ["source.virtualbox-iso.centos-7-vanilla"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_vagrant-centos-7.sh"
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "../build/{{.BuildName}}-{{.Provider}}-{{timestamp}}.box"
  }
}
