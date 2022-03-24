
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "virtualbox-iso" "lb" {
  boot_command            = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter><wait>"]
  boot_wait               = "5s"
  disk_size               = 15000
  guest_additions_mode    = "disable"
  guest_os_type           = "Ubuntu_64"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum            = "sha256:28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
  iso_urls                = ["http://mirrors.kernel.org/ubuntu-releases/20.04.4/ubuntu-20.04.4-live-server-amd64.iso"]
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "${var.SSHPW}"
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory_amount}"]]
  vm_name                 = "lb"
  headless                = "${var.headless_build}"
}

source "virtualbox-iso" "ws1" {
  boot_command            = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter><wait>"]
  boot_wait               = "5s"
  disk_size               = 15000
  guest_additions_mode    = "disable"
  guest_os_type           = "Ubuntu_64"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum            = "sha256:28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
  iso_urls                = ["http://mirrors.kernel.org/ubuntu-releases/20.04.4/ubuntu-20.04.4-live-server-amd64.iso"]  
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "${var.SSHPW}"
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory_amount}"]]
  vm_name                 = "ws1"
  headless                = "${var.headless_build}"
}

source "virtualbox-iso" "ws2" {
  boot_command            = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter><wait>"]
  boot_wait               = "5s"
  disk_size               = 15000
  guest_additions_mode    = "disable"
  guest_os_type           = "Ubuntu_64"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum            = "sha256:28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
  iso_urls                = ["http://mirrors.kernel.org/ubuntu-releases/20.04.4/ubuntu-20.04.4-live-server-amd64.iso"]  
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "${var.SSHPW}"
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory_amount}"]]
  vm_name                 = "ws2"
  headless                = "${var.headless_build}"
}

source "virtualbox-iso" "ws3" {
  boot_command            = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter><wait>"]
  boot_wait               = "5s"
  disk_size               = 15000
  guest_additions_mode    = "disable"
  guest_os_type           = "Ubuntu_64"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum            = "sha256:28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
  iso_urls                = ["http://mirrors.kernel.org/ubuntu-releases/20.04.4/ubuntu-20.04.4-live-server-amd64.iso"]
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "${var.SSHPW}"
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory_amount}"]]
  vm_name                 = "ws3"
  headless                = "${var.headless_build}"
}

source "virtualbox-iso" "db" {
  boot_command            = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter><wait>"]
  boot_wait               = "5s"
  disk_size               = 15000
  guest_additions_mode    = "disable"  
  guest_os_type           = "Ubuntu_64"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum            = "sha256:28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
  iso_urls                = ["http://mirrors.kernel.org/ubuntu-releases/20.04.4/ubuntu-20.04.4-live-server-amd64.iso"]  
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "${var.SSHPW}"
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "${var.memory_amount}"]]
  vm_name                 = "db"
  headless                = "${var.headless_build}"
}

build {
  sources = ["source.virtualbox-iso.lb","source.virtualbox-iso.ws1","source.virtualbox-iso.ws2","source.virtualbox-iso.ws3","source.virtualbox-iso.db"]

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
    script          = "../scripts/post_install_ubuntu_2004_vagrant.sh"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_lb.sh"
    only            = ["virtualbox-iso.lb"]
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_ws.sh"
    only            = ["virtualbox-iso.ws1","virtualbox-iso.ws2","virtualbox-iso.ws3"]
  }

#########################################################################################
# Environment Vars are read from the variables.pkr.hcl file and are a way to pass user 
# variables -- things such as passwords that need to be set at run time and passed into 
# an application -- but would be dangerous to hardcode.
#########################################################################################

    provisioner "shell" {
    environment_vars = ["USERPASS=${var.non-root-user-for-database-password}",
                        "ACCESSFROMIP=${var.restrict-firewall-access-to-this-ip-range}",
                        "USERNAME=${var.non-root-user-for-database-username}"]
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_db.sh"
    only            = ["virtualbox-iso.db"]
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "${var.build_artifact_location}{{ .BuildName }}.box"
  }
}
