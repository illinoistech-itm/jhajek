locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

# Packer Proxmox Plugin Docs
# https://github.com/hashicorp/packer-plugin-proxmox/tree/main/docs
packer {
  required_plugins {
    virtualbox = {
      version = ">= 1.1.8"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

source "proxmox-iso" "kali-summer-camp" {
  #boot_command            = ["<esc><wait>","auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>","locale=en_US <wait>","keymap=us <wait>","<enter><wait>"]
  boot_command = ["<esc><wait>",
        "install <wait>",
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
        "debian-installer=en_US.UTF-8 <wait>",
        "auto <wait>",
        "locale=en_US.UTF-8 <wait>",
        "kbd-chooser/method=us <wait>",
        "keyboard-configuration/xkb-keymap=us <wait>",
        "fb=false <wait>",
        "debconf/frontend=noninteractive <wait>",
        "console-setup/ask_detect=false <wait>",
        "console-keymaps-at/keymap=us <wait>",
        "interface=eth0 <wait>",
        "interface=eth1 <wait>",
        "interface=eth2 <wait>",
        "ip=eth0:dhcp <wait>",
        "ip=eth1:dhcp <wait>",
        "ip=eth2:dhcp <wait>",
        "<enter><wait>"]
  boot_wait = "5s"
  cores     = "${var.NUMBEROFCORES}"
  node      = "${local.NODENAME}"
  username  = "${local.USERNAME}"
  token     = "${local.PROXMOX_TOKEN}"
  cpu_type  = "host"
  disks {
    disk_size    = "${var.DISKSIZE}"
    storage_pool = "${var.STORAGEPOOL}"
    #type = "virtio"
    #io_thread = true
  }
  http_directory   = "preseed"
  http_bind_address = "10.110.0.45"
  http_port_max    = 9200
  http_port_min    = 9001
  iso_checksum     = "${var.iso_checksum}"
  iso_urls         = "${var.iso_urls}"
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
  proxmox_url              = "${local.URL}"
  insecure_skip_tls_verify = true
  unmount_iso              = true
  qemu_agent               = true
  scsi_controller          = "lsi"
  #scsi_controller          = "virtio-scsi-single"
  cloud_init               = true
  cloud_init_storage_pool  = "${var.STORAGEPOOL}"
  ssh_password             = "${local.SSHPW}"
  ssh_username             = "kali"
  ssh_timeout              = "22m"
  template_description     = "A Kali template for summer camp"
  vm_name                  = "${var.VMNAME}"
}

build {
  sources = ["source.proxmox-iso.kali-summer-camp"]

  ########################################################################################################################
  # Using the file provisioner to SCP this file to the instance 
  # Add .hcl configuration file to register an instance with Consul for dynamic DNS on the third interface
  ########################################################################################################################

  provisioner "file" {
    source      = "./system.hcl"
    destination = "/home/vagrant/"
  }

  ########################################################################################################################
  # Copy the node-exporter-consul-service.json file to the instance move this file to /etc/consul.d/ 
  # directory so that each node can register as a service dynamically -- which Prometheus can then 
  # scape and automatically find metrics to collect
  ########################################################################################################################

  provisioner "file" {
    source      = "../scripts/proxmox/jammy-services/node-exporter-consul-service.json"
    destination = "/home/vagrant/"
  }

  ########################################################################################################################
  # Copy the consul.conf file to the instance to update the consul DNS to look on the internal port of 8600 to resolve
  # .consul domain lookups
  ########################################################################################################################

  provisioner "file" {
    source      = "../scripts/proxmox/jammy-services/consul.conf"
    destination = "/home/vagrant/"
  }

  ########################################################################################################################
  # Copy the node_exporter service file to the template so that the instance can publish its own system metrics on the
  # metrics interface
  ########################################################################################################################

  provisioner "file" {
    source      = "../scripts/proxmox/jammy-services/node-exporter.service"
    destination = "/home/vagrant/"
  }

  ########################################################################################################################
  # This is the script that will open the default firewall ports and create the default firewalld zones.
  ########################################################################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-jammy/post_install_prxmx-firewall-configuration.sh"]
  }

  ########################################################################################################################
  # These shell scripts are needed to create the cloud instance and register the instance with Consul DNS
  # Don't edit this
  ########################################################################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts = ["../scripts/proxmox/core-jammy/post_install_prxmx_ubuntu_2204.sh",
      "../scripts/proxmox/core-jammy/post_install_prxmx_start-cloud-init.sh",
      "../scripts/proxmox/core-jammy/post_install_prxmx_install_hashicorp_consul.sh",
    "../scripts/proxmox/core-jammy/post_install_prxmx_update_dns_for_consul_service.sh"]
  }

  ########################################################################################################################
  # Script to change the bind_addr in Consul to the dynmaic Go lang call to
  # Interface ens20
  # https://www.consul.io/docs/troubleshoot/common-errors
  ########################################################################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-jammy/post_install_change_consul_bind_interface.sh"]
  }

  ############################################################################################
  # Script to give a dynamic message about the consul DNS upon login
  #
  # https://ownyourbits.com/2017/04/05/customize-your-motd-login-message-in-debian-and-ubuntu/
  #############################################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-jammy/post_install_update_dynamic_motd_message.sh"]
  }

  ############################################################################################
  # Script to install Prometheus Node Exporter dependencies for collecting hardware metrics
  #
  #############################################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-jammy/post_install_prxmx_ubuntu_install-prometheus-node-exporter.sh"]
  }

  ########################################################################################################################
  # Uncomment this block to add your own custom bash install scripts
  # This block you can add your own shell scripts to customize the image you are creating
  ########################################################################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/kali-summercamp/setup.sh"]
  }

}
