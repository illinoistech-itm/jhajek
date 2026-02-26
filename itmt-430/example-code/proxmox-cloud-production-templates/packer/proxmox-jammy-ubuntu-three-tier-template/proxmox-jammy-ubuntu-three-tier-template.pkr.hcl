locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

packer {
  required_plugins {
    virtualbox = {
      version = ">= 1.2.0"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/from-1.5/blocks/source
# https://github.com/burkeazbill/ubuntu-22-04-packer-fusion-workstation/blob/master/ubuntu-2204-daily.pkr.hcl

###########################################################################################
# This is a Packer build template for the backend database / datastore
###########################################################################################
source "proxmox-iso" "backend-database82" {
  boot_command = [
    "e<wait>",
    "<down><down><down>",
    "<end><bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]
  boot_iso {
    type="scsi"
    iso_file="local:iso/${var.iso_name}"
    unmount=true
    iso_checksum="${var.iso_checksum}"
  }
  boot_wait = "5s"
  cores     = "${var.NUMBEROFCORES}"
  node      = "${local.NODENAME1}"
  username  = "${local.TOKEN_ID}"
  token     = "${local.TOKEN_VALUE}"
  cpu_type  = "host"
  disks {
    disk_size    = "${var.DISKSIZE}"
    storage_pool = "${var.STORAGEPOOL}"
    type         = "virtio"
    io_thread    = true
    format       = "raw"
  }
  http_directory    = "subiquity/http"
  http_bind_address = "${var.BIND_ADDRESS}"
  http_port_max    = 9200
  http_port_min    = 9001
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
  qemu_agent               = true
  cloud_init               = true
  cloud_init_storage_pool  = "local"
  # io thread option requires virtio-scsi-single controller
  scsi_controller          = "virtio-scsi-single"
  ssh_password             = "${local.SSHPW}"
  ssh_username             = "${local.SSHUSER}"
  ssh_timeout              = "28m"
  template_description     = "A Packer template for Ubuntu Noble Database" 
  vm_name                  = "${var.BE-VMNAME}"
  tags                     = "${var.BE-TAGS}"
}

###########################################################################################
# This is a Packer build template for the frontend webserver
###########################################################################################
source "proxmox-iso" "frontend-webserver82" {
  boot_command = [
    "e<wait>",
    "<down><down><down>",
    "<end><bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]
  boot_iso {
    type="scsi"
    iso_file="local:iso/${var.iso_name}"
    unmount=true
    iso_checksum="${var.iso_checksum}"
  }
  boot_wait = "15s"
  cores     = "${var.NUMBEROFCORES}"
  node      = "${local.NODENAME1}"
  username  = "${local.TOKEN_ID}"
  token     = "${local.TOKEN_VALUE}"
  cpu_type  = "host"
  disks {
    disk_size    = "${var.DISKSIZE}"
    storage_pool = "${var.STORAGEPOOL}"
    type         = "virtio"
    io_thread    = true
    format       = "raw"
  }
  http_directory    = "subiquity/http"
  http_bind_address = "${var.BIND_ADDRESS}"
  http_port_max    = 9200
  http_port_min    = 9001
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
  qemu_agent               = true
  cloud_init               = true
  cloud_init_storage_pool  = "local"
  # io thread option requires virtio-scsi-single controller
  scsi_controller          = "virtio-scsi-single"
  ssh_password             = "${local.SSHPW}"
  ssh_username             = "${local.SSHUSER}"
  ssh_timeout              = "28m"
  template_description     = "A Packer template for Ubuntu Noble Frontend webserver"
  vm_name                  = "${var.FE-VMNAME}"
  tags                     = "${var.FE-TAGS}"
}

###########################################################################################
# This is a Packer build template for the load-balancer
###########################################################################################
source "proxmox-iso" "load-balancer82" {
  boot_command = [
    "e<wait>",
    "<down><down><down>",
    "<end><bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]
  boot_iso {
    type="scsi"
    iso_file="local:iso/${var.iso_name}"
    unmount=true
    iso_checksum="${var.iso_checksum}"
  }
  boot_wait = "12s"
  cores     = "${var.NUMBEROFCORES}"
  node      = "${local.NODENAME1}"
  username  = "${local.TOKEN_ID}"
  token     = "${local.TOKEN_VALUE}"
  cpu_type  = "host"
  disks {
    disk_size    = "${var.DISKSIZE}"
    storage_pool = "${var.STORAGEPOOL}"
    type         = "virtio"
    io_thread    = true
    format       = "raw"
  }
  http_directory    = "subiquity/http"
  http_bind_address = "${var.BIND_ADDRESS}"
  http_port_max    = 9200
  http_port_min    = 9001
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
  qemu_agent               = true
  cloud_init               = true
  cloud_init_storage_pool  = "local"
  # io thread option requires virtio-scsi-single controller
  scsi_controller          = "virtio-scsi-single"
  ssh_password             = "${local.SSHPW}"
  ssh_username             = "${local.SSHUSER}"
  ssh_timeout              = "28m"
  template_description     = "A Packer template for Ubuntu Noble Load Balancer"
  vm_name                  = "${var.LB-VMNAME}"
  tags                     = "${var.LB-TAGS}"
}
##############################################################################
# Templates for system83
##############################################################################
source "proxmox-iso" "backend-database83" {
  boot_command = [
    "e<wait>",
    "<down><down><down>",
    "<end><bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]
  boot_iso {
    type="scsi"
    iso_file="local:iso/${var.iso_name}"
    unmount=true
    iso_checksum="${var.iso_checksum}"
  }
  boot_wait = "5s"
  cores     = "${var.NUMBEROFCORES}"
  node      = "${local.NODENAME2}"
  username  = "${local.TOKEN_ID}"
  token     = "${local.TOKEN_VALUE}"
  cpu_type  = "host"
  disks {
    disk_size    = "${var.DISKSIZE}"
    storage_pool = "${var.STORAGEPOOL}"
    type         = "virtio"
    io_thread    = true
    format       = "raw"
  }
  http_directory    = "subiquity/http"
  http_bind_address = "${var.BIND_ADDRESS}"
  http_port_max    = 9200
  http_port_min    = 9001
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
  qemu_agent               = true
  cloud_init               = true
  cloud_init_storage_pool  = "local"
  # io thread option requires virtio-scsi-single controller
  scsi_controller          = "virtio-scsi-single"
  ssh_password             = "${local.SSHPW}"
  ssh_username             = "${local.SSHUSER}"
  ssh_timeout              = "28m"
  template_description     = "A Packer template for Ubuntu Noble Database" 
  vm_name                  = "${var.BE-VMNAME}"
  tags                     = "${var.BE-TAGS}"
}

###########################################################################################
# This is a Packer build template for the frontend webserver
###########################################################################################
source "proxmox-iso" "frontend-webserver83" {
  boot_command = [
    "e<wait>",
    "<down><down><down>",
    "<end><bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]
  boot_iso {
    type="scsi"
    iso_file="local:iso/${var.iso_name}"
    unmount=true
    iso_checksum="${var.iso_checksum}"
  }
  boot_wait = "15s"
  cores     = "${var.NUMBEROFCORES}"
  node      = "${local.NODENAME2}"
  username  = "${local.TOKEN_ID}"
  token     = "${local.TOKEN_VALUE}"
  cpu_type  = "host"
  disks {
    disk_size    = "${var.DISKSIZE}"
    storage_pool = "${var.STORAGEPOOL}"
    type         = "virtio"
    io_thread    = true
    format       = "raw"
  }
  http_directory    = "subiquity/http"
  http_bind_address = "${var.BIND_ADDRESS}"
  http_port_max    = 9200
  http_port_min    = 9001
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
  qemu_agent               = true
  cloud_init               = true
  cloud_init_storage_pool  = "local"
  # io thread option requires virtio-scsi-single controller
  scsi_controller          = "virtio-scsi-single"
  ssh_password             = "${local.SSHPW}"
  ssh_username             = "${local.SSHUSER}"
  ssh_timeout              = "28m"
  template_description     = "A Packer template for Ubuntu Noble Frontend webserver"
  vm_name                  = "${var.FE-VMNAME}"
  tags                     = "${var.FE-TAGS}"
}

###########################################################################################
# This is a Packer build template for the load-balancer
###########################################################################################
source "proxmox-iso" "load-balancer83" {
  boot_command = [
    "e<wait>",
    "<down><down><down>",
    "<end><bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]
  boot_iso {
    type="scsi"
    iso_file="local:iso/${var.iso_name}"
    unmount=true
    iso_checksum="${var.iso_checksum}"
  }
  boot_wait = "12s"
  cores     = "${var.NUMBEROFCORES}"
  node      = "${local.NODENAME2}"
  username  = "${local.TOKEN_ID}"
  token     = "${local.TOKEN_VALUE}"
  cpu_type  = "host"
  disks {
    disk_size    = "${var.DISKSIZE}"
    storage_pool = "${var.STORAGEPOOL}"
    type         = "virtio"
    io_thread    = true
    format       = "raw"
  }
  http_directory    = "subiquity/http"
  http_bind_address = "${var.BIND_ADDRESS}"
  http_port_max    = 9200
  http_port_min    = 9001
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
  qemu_agent               = true
  cloud_init               = true
  cloud_init_storage_pool  = "local"
  # io thread option requires virtio-scsi-single controller
  scsi_controller          = "virtio-scsi-single"
  ssh_password             = "${local.SSHPW}"
  ssh_username             = "${local.SSHUSER}"
  ssh_timeout              = "28m"
  template_description     = "A Packer template for Ubuntu Noble Load Balancer"
  vm_name                  = "${var.LB-VMNAME}"
  tags                     = "${var.LB-TAGS}"
}

##############################################################################
# Templates for system83
##############################################################################
source "proxmox-iso" "backend-database84" {
  boot_command = [
    "e<wait>",
    "<down><down><down>",
    "<end><bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]
  boot_iso {
    type="scsi"
    iso_file="local:iso/${var.iso_name}"
    unmount=true
    iso_checksum="${var.iso_checksum}"
  }
  boot_wait = "5s"
  cores     = "${var.NUMBEROFCORES}"
  node      = "${local.NODENAME3}"
  username  = "${local.TOKEN_ID}"
  token     = "${local.TOKEN_VALUE}"
  cpu_type  = "host"
  disks {
    disk_size    = "${var.DISKSIZE}"
    storage_pool = "${var.STORAGEPOOL}"
    type         = "virtio"
    io_thread    = true
    format       = "raw"
  }
  http_directory    = "subiquity/http"
  http_bind_address = "${var.BIND_ADDRESS}"
  http_port_max    = 9200
  http_port_min    = 9001
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
  qemu_agent               = true
  cloud_init               = true
  cloud_init_storage_pool  = "local"
  # io thread option requires virtio-scsi-single controller
  scsi_controller          = "virtio-scsi-single"
  ssh_password             = "${local.SSHPW}"
  ssh_username             = "${local.SSHUSER}"
  ssh_timeout              = "28m"
  template_description     = "A Packer template for Ubuntu Noble Database" 
  vm_name                  = "${var.BE-VMNAME}"
  tags                     = "${var.BE-TAGS}"
}

###########################################################################################
# This is a Packer build template for the frontend webserver
###########################################################################################
source "proxmox-iso" "frontend-webserver84" {
  boot_command = [
    "e<wait>",
    "<down><down><down>",
    "<end><bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]
  boot_iso {
    type="scsi"
    iso_file="local:iso/${var.iso_name}"
    unmount=true
    iso_checksum="${var.iso_checksum}"
  }
  boot_wait = "15s"
  cores     = "${var.NUMBEROFCORES}"
  node      = "${local.NODENAME3}"
  username  = "${local.TOKEN_ID}"
  token     = "${local.TOKEN_VALUE}"
  cpu_type  = "host"
  disks {
    disk_size    = "${var.DISKSIZE}"
    storage_pool = "${var.STORAGEPOOL}"
    type         = "virtio"
    io_thread    = true
    format       = "raw"
  }
  http_directory    = "subiquity/http"
  http_bind_address = "${var.BIND_ADDRESS}"
  http_port_max    = 9200
  http_port_min    = 9001
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
  qemu_agent               = true
  cloud_init               = true
  cloud_init_storage_pool  = "local"
  # io thread option requires virtio-scsi-single controller
  scsi_controller          = "virtio-scsi-single"
  ssh_password             = "${local.SSHPW}"
  ssh_username             = "${local.SSHUSER}"
  ssh_timeout              = "28m"
  template_description     = "A Packer template for Ubuntu Noble Frontend webserver"
  vm_name                  = "${var.FE-VMNAME}"
  tags                     = "${var.FE-TAGS}"
}

###########################################################################################
# This is a Packer build template for the load-balancer
###########################################################################################
source "proxmox-iso" "load-balancer84" {
  boot_command = [
    "e<wait>",
    "<down><down><down>",
    "<end><bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
    "<f10><wait>"
  ]
  boot_iso {
    type="scsi"
    iso_file="local:iso/${var.iso_name}"
    unmount=true
    iso_checksum="${var.iso_checksum}"
  }
  boot_wait = "9s"
  cores     = "${var.NUMBEROFCORES}"
  node      = "${local.NODENAME3}"
  username  = "${local.TOKEN_ID}"
  token     = "${local.TOKEN_VALUE}"
  cpu_type  = "host"
  disks {
    disk_size    = "${var.DISKSIZE}"
    storage_pool = "${var.STORAGEPOOL}"
    type         = "virtio"
    io_thread    = true
    format       = "raw"
  }
  http_directory    = "subiquity/http"
  http_bind_address = "${var.BIND_ADDRESS}"
  http_port_max    = 9200
  http_port_min    = 9001
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
  qemu_agent               = true
  cloud_init               = true
  cloud_init_storage_pool  = "local"
  # io thread option requires virtio-scsi-single controller
  scsi_controller          = "virtio-scsi-single"
  ssh_password             = "${local.SSHPW}"
  ssh_username             = "${local.SSHUSER}"
  ssh_timeout              = "28m"
  template_description     = "A Packer template for Ubuntu Noble Load Balancer"
  vm_name                  = "${var.LB-VMNAME}"
  tags                     = "${var.LB-TAGS}"
}

build {
  sources = ["source.proxmox-iso.frontend-webserver82","source.proxmox-iso.backend-database82","source.proxmox-iso.load-balancer82","source.proxmox-iso.frontend-webserver83","source.proxmox-iso.backend-database83","source.proxmox-iso.load-balancer83","source.proxmox-iso.frontend-webserver84","source.proxmox-iso.backend-database84","source.proxmox-iso.load-balancer84"]

  #############################################################################
  # Using the file provisioner to SCP this file to the instance 
  # Add .hcl configuration file to register an instance with Consul for dynamic
  # DNS on the third interface
  #############################################################################

  provisioner "file" {
    source      = "./system.hcl"
    destination = "/home/vagrant/"
  }

  #############################################################################
  # Copy the node-exporter-consul-service.json file to the instance move this 
  # file to /etc/consul.d/ directory so that each node can register as a 
  # service dynamically -- which Prometheus can then 
  # scape and automatically find metrics to collect
  #############################################################################

  provisioner "file" {
    source      = "../scripts/proxmox/noble-services/node-exporter-consul-service.json"
    destination = "/home/vagrant/"
  }

  #############################################################################
  # Copy the consul.conf file to the instance to update the consul DNS to look 
  # on the internal port of 8600 to resolve the .consul domain lookups
  #############################################################################

  provisioner "file" {
    source      = "../scripts/proxmox/noble-services/consul.conf"
    destination = "/home/vagrant/"
  }

  #############################################################################
  # Copy the node_exporter service file to the template so that the instance 
  # can publish its own system metrics on the metrics interface
  #############################################################################

  provisioner "file" {
    source      = "../scripts/proxmox/noble-services/node-exporter.service"
    destination = "/home/vagrant/"
  }

  #############################################################################
  # This is the script that will open firewall ports needed for a node to 
  # function on the the School Cloud Platform and create the default firewalld
  # zones.
  #############################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-noble/post_install_prxmx-firewall-configuration.sh"]
  }

  #############################################################################
  # These shell scripts are needed to create the cloud instances and register 
  # the instance with Consul DNS --- Don't edit this
  #############################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts = ["../scripts/proxmox/core-noble/post_install_prxmx_ubuntu_2404.sh",
      "../scripts/proxmox/core-noble/post_install_prxmx_start-cloud-init.sh",
      "../scripts/proxmox/core-noble/post_install_prxmx_install_hashicorp_consul.sh",
    "../scripts/proxmox/core-noble/post_install_prxmx_update_dns_for_consul_service.sh"]
  }

  #############################################################################
  # Script to change the bind_addr in Consul to the dynamic Go lang call to
  # Interface ens20
  # https://www.consul.io/docs/troubleshoot/common-errors
  #############################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-noble/post_install_change_consul_bind_interface.sh"]
  }

  #############################################################################
  # Script to give a dynamic message about the consul DNS upon login
  #
  # https://ownyourbits.com/2017/04/05/customize-your-motd-login-message-in-debian-and-ubuntu/
  #############################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-noble/post_install_update_dynamic_motd_message.sh"]
  }

  #############################################################################
  # Script to install Prometheus Telemetry support
  #############################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts         = ["../scripts/proxmox/core-noble/post_install_prxmx_ubuntu_install-prometheus-node-exporter.sh"]
  }

  #############################################################################
  # Uncomment this block to add your own custom bash install scripts
  # This block you can add your own shell scripts to customize the image you 
  # are creating
  #############################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts = ["../scripts/proxmox/three-tier/frontend/post_install_prxmx_frontend-firewall-open-ports.sh",
      "../scripts/proxmox/three-tier/frontend/post_install_prxmx_frontend-nginx-install.sh"]
    only             = ["proxmox-iso.frontend-webserver82","proxmox-iso.frontend-webserver83","proxmox-iso.frontend-webserver84"]
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts = ["../scripts/proxmox/three-tier/backend/post_install_prxmx_backend-firewall-open-ports.sh",
    "../scripts/proxmox/three-tier/backend/post_install_prxmx_backend-database.sh"]
    only             = ["proxmox-iso.backend-database82","proxmox-iso.backend-database84","proxmox-iso.backend-database84"]
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    scripts = ["../scripts/proxmox/three-tier/loadbalancer/post_install_prxmx_load-balancer-firewall-open-ports.sh",
      "../scripts/proxmox/three-tier/loadbalancer/post_install_prxmx_load_balancer.sh",
   ]
    only = ["proxmox-iso.load-balancer82","proxmox-iso.load-balancer83","proxmox-iso.load-balancer84"]
  }

}