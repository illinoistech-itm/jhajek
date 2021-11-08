
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "virtualbox-iso" "ubuntu-2004-ec2" {
  boot_command            = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter><wait>"]
  boot_wait               = "5s"
  disk_size               = 20000
  format                  = "ova"
  http_directory          = "subiquity/http"
  guest_additions_mode    = "disable"
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "Ubuntu_64"
  http_port_max           = 9100
  http_port_min           = 9001
  iso_checksum            = "sha256:f8e3086f3cea0fb3fefb29937ab5ed9d19e767079633960ccb50e76153effc98"
  iso_urls                = ["http://mirrors.kernel.org/ubuntu-releases/20.04.3/ubuntu-20.04.3-live-server-amd64.iso"]
  shutdown_command        = "echo 'ubuntu'| sudo -S shutdown -P now"
  ssh_password            = "ubuntu"
  ssh_port                = 2222
  ssh_username            = "ubuntu"
  ssh_wait_timeout        = "1800s"
  vboxmanage              = [["modifyvm", "{{ .Name }}", "--memory", "2048"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "ubuntu-2004-ec2"
}

build {
  sources = ["source.virtualbox-iso.ubuntu-2004-ec2"]

  provisioner "file" {
    destination = "/home/ubuntu/"
    source      = "./id_rsa_github_deploy_key"
  }

  provisioner "file" {
    destination = "/home/ubuntu/"
    source      = "./config"
  }

  provisioner "shell" {
    execute_command = "echo 'ubuntu' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    inline          = ["mkdir -p /home/ubuntu/.ssh", "mkdir -p /root/.ssh", "chmod 600 /home/ubuntu/id_rsa_github_deploy_key", "cp -v /home/ubuntu/id_rsa_github_deploy_key /home/ubuntu/.ssh/", "cp -v /home/ubuntu/config /home/ubuntu/.ssh/", "cp -v /home/ubuntu/config /root/.ssh/"]
  }

  provisioner "shell" {
    execute_command = "echo 'ubuntu' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_vagrant-EC2.sh"
  }

  post-processor "amazon-import" {
    keep_input_artifact = false
    access_key          = "${var.aws_access_key}"
    region              = "${var.region}"
    s3_bucket_name      = "${var.s3_bucket_name}"
    secret_key          = "${var.aws_secret_key}"
    tags = {
      Description = "packer amazon-import ${local.timestamp}"
    }
  }
}
