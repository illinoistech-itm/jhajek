
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "parallels-iso" "lb" {
  # https://github.com/chef/bento/blob/main/packer_templates/ubuntu/ubuntu-20.04-arm64.json
  boot_command          = ["<esc>", "linux /casper/vmlinuz"," quiet"," autoinstall"," ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/'","<enter>","initrd /casper/initrd <enter>","boot <enter>"]
  boot_wait               = "15s"
  disk_size               = 15000
  parallels_tools_flavor  = "lin"
  guest_os_type           = "ubuntu"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum            = "sha256:fef8bc204d2b09b579b9d40dfd8c5a084f8084a9bffafe8a0f39a0e53606312d"
  iso_urls                = ["https://cdimage.ubuntu.com/releases/20.04.4/release/ubuntu-20.04.4-live-server-arm64.iso"]  
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "${var.SSHPW}"
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  parallels_tools_mode    = "upload"
  # Hint to fix the problem of "initramfs unpacking failed" error
  # https://askubuntu.com/questions/1269855/usb-installer-initramfs-unpacking-failed-decoding-failed
  prlctl                  = [["set", "{{.Name}}", "--memsize", "${var.memory_amount}"]]
  prlctl_version_file     = ".prlctl_version"
  vm_name                 = "lb"
}

source "parallels-iso" "ws1" {
  # https://github.com/chef/bento/blob/main/packer_templates/ubuntu/ubuntu-20.04-arm64.json
  boot_command          = ["<esc>", "linux /casper/vmlinuz"," quiet"," autoinstall"," ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/'","<enter>","initrd /casper/initrd <enter>","boot <enter>"]
  boot_wait               = "15s"
  disk_size               = 15000
  parallels_tools_flavor  = "lin"
  guest_os_type           = "ubuntu"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum            = "sha256:fef8bc204d2b09b579b9d40dfd8c5a084f8084a9bffafe8a0f39a0e53606312d"
  iso_urls                = ["https://cdimage.ubuntu.com/releases/20.04.4/release/ubuntu-20.04.4-live-server-arm64.iso"]  
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "${var.SSHPW}"
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  parallels_tools_mode    = "upload"
  # Hint to fix the problem of "initramfs unpacking failed" error
  # https://askubuntu.com/questions/1269855/usb-installer-initramfs-unpacking-failed-decoding-failed
  prlctl                  = [["set", "{{.Name}}", "--memsize", "${var.memory_amount}"]]
  prlctl_version_file     = ".prlctl_version"
  vm_name                 = "ws1"
}

source "parallels-iso" "ws2" {
  # https://github.com/chef/bento/blob/main/packer_templates/ubuntu/ubuntu-20.04-arm64.json
  boot_command          = ["<esc>", "linux /casper/vmlinuz"," quiet"," autoinstall"," ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/'","<enter>","initrd /casper/initrd <enter>","boot <enter>"]
  boot_wait               = "15s"
  disk_size               = 15000
  parallels_tools_flavor  = "lin"
  guest_os_type           = "ubuntu"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum            = "sha256:fef8bc204d2b09b579b9d40dfd8c5a084f8084a9bffafe8a0f39a0e53606312d"
  iso_urls                = ["https://cdimage.ubuntu.com/releases/20.04.4/release/ubuntu-20.04.4-live-server-arm64.iso"]  
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "${var.SSHPW}"
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  parallels_tools_mode    = "upload"
  # Hint to fix the problem of "initramfs unpacking failed" error
  # https://askubuntu.com/questions/1269855/usb-installer-initramfs-unpacking-failed-decoding-failed
  prlctl                  = [["set", "{{.Name}}", "--memsize", "${var.memory_amount}"]]
  prlctl_version_file     = ".prlctl_version"
  vm_name                 = "ws2"
}

source "parallels-iso" "ws3" {
  # https://github.com/chef/bento/blob/main/packer_templates/ubuntu/ubuntu-20.04-arm64.json
  boot_command          = ["<esc>", "linux /casper/vmlinuz"," quiet"," autoinstall"," ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/'","<enter>","initrd /casper/initrd <enter>","boot <enter>"]
  boot_wait               = "15s"
  disk_size               = 15000
  parallels_tools_flavor  = "lin"
  guest_os_type           = "ubuntu"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum            = "sha256:fef8bc204d2b09b579b9d40dfd8c5a084f8084a9bffafe8a0f39a0e53606312d"
  iso_urls                = ["https://cdimage.ubuntu.com/releases/20.04.4/release/ubuntu-20.04.4-live-server-arm64.iso"]  
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "${var.SSHPW}"
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  parallels_tools_mode    = "upload"
  # Hint to fix the problem of "initramfs unpacking failed" error
  # https://askubuntu.com/questions/1269855/usb-installer-initramfs-unpacking-failed-decoding-failed
  prlctl                  = [["set", "{{.Name}}", "--memsize", "${var.memory_amount}"]]
  prlctl_version_file     = ".prlctl_version"
  vm_name                 = "ws3"
}

source "parallels-iso" "db" {
  # https://github.com/chef/bento/blob/main/packer_templates/ubuntu/ubuntu-20.04-arm64.json
  boot_command          = ["<esc>", "linux /casper/vmlinuz"," quiet"," autoinstall"," ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/'","<enter>","initrd /casper/initrd <enter>","boot <enter>"]
  boot_wait               = "15s"
  disk_size               = 15000
  parallels_tools_flavor  = "lin"
  guest_os_type           = "ubuntu"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum            = "sha256:fef8bc204d2b09b579b9d40dfd8c5a084f8084a9bffafe8a0f39a0e53606312d"
  iso_urls                = ["https://cdimage.ubuntu.com/releases/20.04.4/release/ubuntu-20.04.4-live-server-arm64.iso"]  
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "${var.SSHPW}"
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  parallels_tools_mode    = "upload"
  # Hint to fix the problem of "initramfs unpacking failed" error
  # https://askubuntu.com/questions/1269855/usb-installer-initramfs-unpacking-failed-decoding-failed
  prlctl                  = [["set", "{{.Name}}", "--memsize", "${var.memory_amount}"]]
  prlctl_version_file     = ".prlctl_version"
  vm_name                 = "db"
}

build {
  sources = ["source.parallels-iso.lb","source.parallels-iso.ws1","source.parallels-iso.ws2","source.parallels-iso.ws3","source.parallels-iso.db"]

  provisioner "file" {
    source = "./id_ed25519_github_deploy_key"
    destination = "/home/vagrant/.ssh/"
  }

  provisioner "file" {
    source = "./config"
    destination = "/home/vagrant/.ssh/"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_2004_vagrant-arm.sh"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_lb.sh"
    only            = ["parallels-iso.lb"]
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_ws.sh"
    only            = ["parallels-iso.ws1","parallels-iso.ws2","parallels-iso.ws3"]
  }

    provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_db.sh"
    only            = ["parallels-iso.db"]
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "${var.build_artifact_location}{{ .BuildName }}-arm.box"
  }
}
