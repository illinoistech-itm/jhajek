
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "parallels-iso" "ubuntu-20043-live-server-arm" {
  # https://github.com/chef/bento/blob/main/packer_templates/ubuntu/ubuntu-20.04-arm64.json
  boot_command          = ["<esc>", "linux /casper/vmlinuz"," quiet"," autoinstall"," ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/'","<enter>","initrd /casper/initrd <enter>","boot <enter>"]
  boot_wait               = "15s"
  disk_size               = 15000
  parallels_tools_flavor  = "lin"
  guest_os_type           = "ubuntu"
  http_directory          = "subiquity/http"
  http_port_max           = 9050
  http_port_min           = 9001
  iso_checksum            = "sha256:d6fea1f11b4d23b481a48198f51d9b08258a36f6024cb5cec447fe78379959ce"
  iso_urls                = ["https://cdimage.ubuntu.com/releases/20.04/release/ubuntu-20.04.3-live-server-arm64.iso"]
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "${var.SSHPW}"
  ssh_port                = 2222
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  parallels_tools_mode    = "upload"
  # Hint to fix the problem of "initramfs unpacking failed" error
  # https://askubuntu.com/questions/1269855/usb-installer-initramfs-unpacking-failed-decoding-failed
  prlctl                  = [["set", "{{.Name}}", "--memsize", "${var.memory_amount}"]]
  prlctl_version_file     = ".prlctl_version"
  vm_name                 = "ubuntu-focal"
}

build {
  sources = ["source.parallels-iso.ubuntu-20043-live-server-arm"]

  provisioner "shell" {
    #inline_shebang  =  "#!/usr/bin/bash -e"
    inline          = ["echo 'Resetting SSH port to default!'", "sudo rm /etc/ssh/sshd_config.d/packer-init.conf"]
    }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_2004_vagrant-arm.sh"
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "../build/{{ .BuildName }}-${local.timestamp}.box"
  }
}
