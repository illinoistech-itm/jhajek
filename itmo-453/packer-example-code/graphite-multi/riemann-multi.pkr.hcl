
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "virtualbox-iso" "ubuntu-graphitea" {
  boot_command            = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter><wait>"]
  boot_wait               = "5s"
  disk_size               = 10000
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
  vm_name                 = "ubuntu-graphitea"
  headless                = "${var.headless_build}"
}

# Centos 8 Latest Checksum URl 
# http://bay.uchicago.edu/centos/8-stream/isos/x86_64/CHECKSUM
source "virtualbox-iso" "centos-graphiteb" {
  boot_command            = ["<tab> text ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks/centos-8-stream.cfg<enter>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>", "<wait10><wait10><wait10>"]
  boot_wait               = "10s"
  disk_size               = 15000
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "RedHat_64"
  hard_drive_interface    = "sata"
  http_directory          = "."
  http_port_min           = 9001
  http_port_max           = 9100
  iso_checksum            = "7f4c97e1d055ddfbad93fd04b22f5a170f20e04e51fd9aa5c482df485245cdac"
  iso_urls                = ["http://bay.uchicago.edu/centos/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-latest-boot.iso"]
  shutdown_command        = "echo 'vagrant' | sudo -S /sbin/poweroff"
  ssh_password            = "vagrant"
  ssh_port                = 22
  ssh_timeout             = "30m"
  ssh_username            = "vagrant"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "2048"], ["modifyvm", "{{ .Name }}", "--cpus", "2"]]
  virtualbox_version_file = ".vbox_version"
  headless                = "${var.headless_build}"
}


source "virtualbox-iso" "ubuntu-graphitemc" {
  boot_command            = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter><wait>"]
  boot_wait               = "5s"
  disk_size               = 10000
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
  vm_name                 = "ubuntu-graphitemc"
  headless                = "${var.headless_build}"
}

build {
  sources = ["source.virtualbox-iso.ubuntu-graphitea","source.virtualbox-iso.centos-graphiteb","source.virtualbox-iso.ubuntu-graphitemc"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_2004_vagrant.sh"
    only            = ["virtualbox-iso.ubuntu-graphitea","virtualbox-iso.ubuntu-graphitemc"]
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts          = ["../scripts/post_install_vagrant-centos-8.sh"]
    only             = ["virtualbox-iso.centos-graphiteb"]
  }

  provisioner "shell" {
    #inline_shebang  =  "#!/usr/bin/bash -e"
    inline          = ["echo 'Resetting SSH port to default!'", "sudo rm /etc/ssh/sshd_config.d/packer-init.conf"]
    only            = ["virtualbox-iso.ubuntu-graphitea","virtualbox-iso.ubuntu-graphitemc"]
    }

  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "../build/{{ .BuildName }}-${local.timestamp}.box"
  }
}
