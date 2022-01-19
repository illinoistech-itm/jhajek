# https://www.packer.io/plugins/builders/virtualbox/iso
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "parallels-iso" "proxmox-rockylinux-85-arm" {
  boot_command            = ["<tab> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rockylinux-85.ks<enter>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>"]
  boot_wait               = "10s"
  disk_size               = 15000
  parallels_tools_flavor  = "lin"
  # prlctl create x --distribution list  
  guest_os_type           = "centos"
  http_directory          = "./"
  http_port_min           = 9001
  http_port_max           = 9100
  iso_checksum            = "sha256:ea6947728352a29885c6a20969d2b747efb5ccb2561d0845026231fae0410f40"
  iso_urls                = ["https://download.rockylinux.org/pub/rocky/8/isos/aarch64/Rocky-8.5-aarch64-boot.iso"]
  shutdown_command        = "echo 'vagrant' | sudo -S /sbin/poweroff"
  ssh_password            = "vagrant"
  ssh_port                = 22
  ssh_timeout             = "30m"
  ssh_username            = "vagrant"
  parallels_tools_mode    = "upload"
  # Hint to fix the problem of "initramfs unpacking failed" error
  # https://askubuntu.com/questions/1269855/usb-installer-initramfs-unpacking-failed-decoding-failed
  prlctl                  = [["set", "{{.Name}}", "--memsize", "${var.memory_amount}"]]
  prlctl_version_file     = ".prlctl_version"
  vm_name                 = "rockylinux-85"  
}

build {
  description = "Build base RockyLinux 8.5"

  sources = ["source.parallels-iso.proxmox-rockylinux-85-arm"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/post_install_vagrant-rockylinux-85-arm.sh"]
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "../build/{{.BuildName}}-{{.Provider}}-{{timestamp}}.box"
  }
}
