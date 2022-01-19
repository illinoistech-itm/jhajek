# https://www.packer.io/plugins/builders/virtualbox/iso
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "virtualbox-iso" "proxmox-rockylinux-85" {
  boot_command            = ["<tab> text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rockylinux-85.ks<enter>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>"]
  boot_wait               = "10s"
  disk_size               = 15000
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "RedHat_64"
  hard_drive_interface    = "sata"
  http_directory          = "./"
  http_port_min           = 9001
  http_port_max           = 9100
  iso_checksum            = "sha256:5a0dc65d1308e47b51a49e23f1030b5ee0f0ece3702483a8a6554382e893333c"
  iso_urls                = ["https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-boot.iso"]
  shutdown_command        = "echo 'vagrant' | sudo -S /sbin/poweroff"
  ssh_password            = "vagrant"
  ssh_port                = 22
  ssh_timeout             = "30m"
  ssh_username            = "vagrant"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "2048"], ["modifyvm", "{{ .Name }}", "--cpus", "2"]]
  virtualbox_version_file = ".vbox_version"
  headless                = "${var.headless_build}"
}

build {
  description = "Build base RockyLinux 8.5"

  sources = ["source.virtualbox-iso.proxmox-rockylinux-85"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/post_install_vagrant-rockylinux-85.sh"]
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "../build/{{.BuildName}}-{{.Provider}}-{{timestamp}}.box"
  }
}
