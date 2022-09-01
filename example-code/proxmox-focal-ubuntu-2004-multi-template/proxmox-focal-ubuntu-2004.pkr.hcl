locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }
#################################################################
# Packer init command to get the latest proxmox plugin
# run the command:  packer init . 
# do this before you run the command: packer build .
#################################################################

packer {
  required_plugins {
    proxmox = {
      version = ">= 1.0.6"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/from-1.5/blocks/source
source "proxmox-iso" "web-server" {
  boot_command = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter><wait>"]
  boot_wait    = "5s"
  cores        = "${var.NUMBEROFCORES}"
  node         = "${var.NODENAME}"
  username     = "${var.USERNAME}"
  token        = "${var.PROXMOX_TOKEN}"
  cpu_type     = "host"
  disks {
    disk_size         = "${var.DISKSIZE}"
    storage_pool      = "${var.STORAGEPOOL}"
    storage_pool_type = "lvm"
    type              = "virtio"
  }
  http_directory   = "subiquity/http"
  http_port_max    = 9200
  http_port_min    = 9001
  iso_checksum     = "sha256:28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
  iso_urls         = ["http://mirrors.kernel.org/ubuntu-releases/20.04.4/ubuntu-20.04.4-live-server-amd64.iso"]
  iso_storage_pool = "local"
  memory           = "${var.MEMORY}"
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  network_adapters {
    bridge = "vmbr1"
    model  = "virtio"
  }
  network_adapters {
    bridge = "vmbr2"
    model  = "virtio"
  }
  os                       = "l26"
  proxmox_url              = "${var.URL}"
  insecure_skip_tls_verify = true
  unmount_iso              = true
  qemu_agent               = true
  cloud_init               = true
  cloud_init_storage_pool  = "local"
  ssh_password             = "vagrant"
  ssh_username             = "${var.SSHPW}"
  ssh_wait_timeout         = "1200s"
  template_description     = "A Packer template to create a Promox Template - Vanilla Ubuntu"
  vm_name                  = "jrh-ws-template"
}

source "proxmox-iso" "database" {
  boot_command = ["<enter><enter><f6><esc><wait> ", "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/", "<enter><wait>"]
  boot_wait    = "5s"
  cores        = "${var.NUMBEROFCORES}"
  node         = "${var.NODENAME}"
  username     = "${var.USERNAME}"
  token        = "${var.PROXMOX_TOKEN}"
  cpu_type     = "host"
  disks {
    disk_size         = "${var.DISKSIZE}"
    storage_pool      = "${var.STORAGEPOOL}"
    storage_pool_type = "lvm"
    type              = "virtio"
  }
  http_directory   = "subiquity/http"
  http_port_max    = 9200
  http_port_min    = 9001
  iso_checksum     = "sha256:28ccdb56450e643bad03bb7bcf7507ce3d8d90e8bf09e38f6bd9ac298a98eaad"
  iso_urls         = ["http://mirrors.kernel.org/ubuntu-releases/20.04.4/ubuntu-20.04.4-live-server-amd64.iso"]
  iso_storage_pool = "local"
  memory           = "${var.MEMORY}"
  network_adapters {
    bridge = "vmbr0"
    model  = "virtio"
  }
  network_adapters {
    bridge = "vmbr1"
    model  = "virtio"
  }
  network_adapters {
    bridge = "vmbr2"
    model  = "virtio"
  }
  os                       = "l26"
  proxmox_url              = "${var.URL}"
  insecure_skip_tls_verify = true
  unmount_iso              = true
  qemu_agent               = true
  cloud_init               = true
  cloud_init_storage_pool  = "local"
  ssh_password             = "vagrant"
  ssh_username             = "${var.SSHPW}"
  ssh_wait_timeout         = "1200s"
  template_description     = "A Packer template to create a Promox Template - Vanilla Ubuntu"
  vm_name                  = "jrh-db-template"
}

build {
  sources = ["source.proxmox-iso.web-server","source.promox-iso.database"]

  ########################################################################################################################
  # Using the file provisioner to SCP this file to the instance 
  # Add .hcl configuration file to register the systems DNS - base template
  ########################################################################################################################

  provisioner "file" {
    source      = "./system.hcl"
    destination = "/home/vagrant/"
  }

  ########################################################################################################################
  # Add a post_install_iptables-dns-adjustment.sh to the system for consul dns lookup adjustment to the iptables
  ########################################################################################################################

  provisioner "file" {
    source      = "../scripts/proxmox/core-focal/post_install_iptables-dns-adjustment.sh"
    destination = "/home/vagrant/"
  }

  ########################################################################################################################
  # Command to move dns-adjustment script so the Consul DNS service will start on boot/reboot
  ########################################################################################################################

  provisioner "shell" {
    inline = [
      "sudo mv /home/vagrant/post_install_iptables-dns-adjustment.sh /etc",
      "sudo chmod u+x /etc/post_install_iptables-dns-adjustment.sh"
    ]
  }

  ########################################################################################################################
  # This is the script that will open the default firewall ports, all ports except 22, 8301, and 8500 are locked down
  # by default.  Edit this script if you want to open additional ports
  ########################################################################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-focal/post_install_prxmx-firewall-configuration.sh"]
  }

  ########################################################################################################################
  # These shell scripts are needed to create the cloud instance and register the instance with Consul DNS
  # Don't edit this
  ########################################################################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-focal/post_install_prxmx_ubuntu_2004.sh",
                       "../scripts/proxmox/core-focal/post_install_prxmx_start-cloud-init.sh",
                       "../scripts/proxmox/core-focal/post_install_prxmx-ssh-restrict-login.sh",
                       "../scripts/proxmox/core-focal/post_install_prxmx_install_hashicorp_consul.sh",
                       "../scripts/proxmox/core-focal/post_install_prxmx_update_dns_to_use_systemd_for_consul.sh"]
  }

  ########################################################################################################################
  # Script to change the bind_addr in Consul to the dynmaic Go lang call to
  # Interface ens18
  # https://www.consul.io/docs/troubleshoot/common-errors
  ########################################################################################################################
  
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-focal/post_install_change_consul_bind_interface.sh"]
  }
  
  ############################################################################################
  # Script to give a dynamic message about the consul DNS upon login
  #
  # https://ownyourbits.com/2017/04/05/customize-your-motd-login-message-in-debian-and-ubuntu/
  #############################################################################################
  
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-focal/post_install_update_dynamic_motd_message.sh"]
  }  
  
  ############################################################################################
  # Script to install telegraf dependencies for collecting hardware metrics
  #
  #############################################################################################
  
  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-focal/post_install_prxmx_ubuntu_install-telegraf.sh"]
  }  

  ########################################################################################################################
  # Uncomment this block to add your own custom bash install scripts
  # This block you can add your own shell scripts to customize the image you are creating
  ########################################################################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts          = ["../scripts/proxmox/research/install-nginx.sh",
                        "../scripts/proxmox/research/open-firewall-ws.sh"]
    only             = ["promox-iso.web-server"]
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts          = ["../scripts/proxmox/research/install-mariadb.sh",
                        "../scripts/proxmox/research/open-firewall-db.sh"]
    only             = ["promox-iso.database"]
  }


}
