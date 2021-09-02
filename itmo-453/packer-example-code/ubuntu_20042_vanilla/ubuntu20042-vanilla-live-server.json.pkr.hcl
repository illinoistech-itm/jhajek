
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "virtualbox-iso" "ubuntu-20042-live-server" {
  boot_command            = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter><wait>"]
  boot_wait               = "5s"
  disk_size               = 10000
  guest_additions_mode    = "disable"
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "Ubuntu_64"
  http_directory          = "subiquity/http"
  http_port_max           = 9050
  http_port_min           = 9001
  iso_checksum            = "sha256:f8e3086f3cea0fb3fefb29937ab5ed9d19e767079633960ccb50e76153effc98"
  iso_urls                = ["http://mirrors.kernel.org/ubuntu-releases/20.04.3/ubuntu-20.04.3-live-server-amd64.iso"]
  shutdown_command        = "echo 'ubuntu' | sudo -S shutdown -P now"
  #ssh_handshake_attempts  = "80"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "vagrant"
  ssh_port                = 2222
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory_amount}"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "ubuntu-20042-live-server"
  headless                = "${var.headless_build}"
}

build {
  sources = ["source.virtualbox-iso.ubuntu-20042-live-server"]

  provisioner "shell" {
    #inline_shebang  =  "#!/usr/bin/bash -e"
    inline          = ["echo 'Resetting SSH port to default!'", "sudo rm /etc/ssh/sshd_config.d/packer-init.conf"]
    }

  provisioner "shell" {
    execute_command = "echo 'ubuntu' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_2004_vagrant.sh"
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "../build/{{ .BuildName }}-${local.timestamp}.box"
  }
}
