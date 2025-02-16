###############################################################################################
# This template demonstrates a Terraform plan to deploy two custom Ubuntu Focal 22.04 instances
###############################################################################################
resource "random_id" "id" {
  byte_length = 8
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle#example-usage
resource "random_shuffle" "datadisk" {
  input        = ["datadisk2", "datadisk3", "datadisk4", "datadisk1"]
  result_count = 1
}
# data.vault_generic_secret.target_node.data
resource "random_shuffle" "nodename" {
  input        = [data.vault_generic_secret.target_node.data["SYSTEM42"], data.vault_generic_secret.target_node.data["SYSTEM41"]]
  result_count = 1
}

##############################################################################
# Connecting Vault with Secrets for Terraform
# https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret
# https://registry.terraform.io/providers/hashicorp/vault/latest/docs
# https://github.com/hashicorp/terraform/issues/16457
##############################################################################
data "vault_generic_secret" "pm_api_url" {
  path = "secret/URL"
}

data "vault_generic_secret" "pm_api_token_id" {
  path = "secret/SECRETKEY"
}

data "vault_generic_secret" "pm_api_token_secret" {
  path = "secret/ACCESSKEY"
}

data "vault_generic_secret" "target_node" {
  path = "secret/NODENAME"
}

##############################################################################

###############################################################################
# Terraform Plan for load balancer instance
###############################################################################

resource "proxmox_vm_qemu" "load-balancer" {
  count       = var.lb-numberofvms
  name        = "${var.lb-yourinitials}-vm${count.index}.service.consul"
  desc        = var.lb-desc
  #target_node = data.vault_generic_secret.target_node.data[random_shuffle.nodename.result[0]]
  target_node = random_shuffle.nodename.result[0]
  clone       = var.lb-template_to_clone
  os_type     = "cloud-init"
  memory      = var.lb-memory
  cores       = var.lb-cores
  sockets     = var.lb-sockets
  scsihw      = "virtio-scsi-pci"
  boot        = "order=virtio0"
  agent       = 1
  tags        = var.lb-tags

  ipconfig0 = "ip=dhcp"
  ipconfig1 = "ip=dhcp"
  ipconfig2 = "ip=dhcp"

  network {
    model  = "virtio"
    bridge = "vmbr0"
    # Edit in the terraform.tfvars and add your assigned mac address
    # https://github.com/illinoistech-itm/jhajek/tree/master/itmt-430/three-tier-tutorial#how-to-assign-a-mac-address-to-get-a-static-ip
    macaddr = var.lb-macaddr
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
  }

  network {
    model  = "virtio"
    bridge = "vmbr2"
  }

  disks {
    virtio {
      virtio0 {
        disk {
          iothread = true
          storage  = random_shuffle.datadisk.result[0]
          size     = var.lb-disk_size
        }
      }
    }
  }
  #https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on
  # Nginx requires that all three nodes be runnning before the load
  # balancer service will start - otherwise your Nginx LB will be in 
  # a "stopped" service state. This forces a dependency that Terraform cannot
  # automatically infer -- hence the need for depends_on
  depends_on = [proxmox_vm_qemu.frontend-webserver]

  provisioner "remote-exec" {
    # This inline provisioner is needed to accomplish the final fit and finish of your deployed
    # instance and condigure the system to register the FQDN with the Consul DNS system
    inline = [
      "sudo hostnamectl set-hostname ${var.lb-yourinitials}-vm${count.index}",
      "sudo sed -i 's/changeme/${random_id.id.dec}${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/replace-name/${var.lb-yourinitials}-vm${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/ubuntu-server/${var.lb-yourinitials}-vm${count.index}/' /etc/hosts",
      "sudo sed -i 's/FQDN/${var.lb-yourinitials}-vm${count.index}.service.consul/' /etc/update-motd.d/999-consul-dns-message",
      "sudo sed -i 's/#datacenter = \"my-dc-1\"/datacenter = \"rice-dc-1\"/' /etc/consul.d/consul.hcl",
      "echo 'retry_join = [\"${var.consulip-240-prod-system28}\",\"${var.consulip-240-student-system41}\",\"${var.consulip-242-room}\"]' | sudo tee -a /etc/consul.d/consul.hcl",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart consul.service",
      "sudo rm /opt/consul/node-id",
      "sudo systemctl restart consul.service",
      "sudo sed -i 's/0.0.0.0/${var.lb-yourinitials}-vm${count.index}.service.consul/' /etc/systemd/system/node-exporter.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable node-exporter.service",
      "sudo systemctl start node-exporter.service",
      "sudo systemctl restart nginx",
      "sudo growpart /dev/vda 3",
      "sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv",
      "sudo resize2fs /dev/ubuntu-vg/ubuntu-lv",
      "echo 'Your FQDN is: ' ; dig +answer -x ${self.default_ipv4_address} +short"
    ]

    connection {
      type        = "ssh"
      user        = "vagrant"
      private_key = file("${path.module}/${var.keypath}")
      host        = self.ssh_host
      port        = self.ssh_port
    }
  }
}

output "proxmox_lb_ip_address_default" {
  description = "Current Public IP"
  value       = proxmox_vm_qemu.load-balancer.*.default_ipv4_address
}

###############################################################################
# Terraform Plan for frontend webserver instances
###############################################################################

resource "proxmox_vm_qemu" "frontend-webserver" {
  count       = var.frontend-numberofvms
  name        = "${var.frontend-yourinitials}-vm${count.index}.service.consul"
  desc        = var.frontend-desc
  #target_node = data.vault_generic_secret.target_node.data[random_shuffle.nodename.result[0]]
  target_node = random_shuffle.nodename.result[0]
  clone       = var.frontend-template_to_clone
  os_type     = "cloud-init"
  memory      = var.frontend-memory
  cores       = var.frontend-cores
  sockets     = var.frontend-sockets
  scsihw      = "virtio-scsi-pci"
  boot        = "order=virtio0"
  agent       = 1
  tags        = var.fe-tags

  ipconfig0 = "ip=dhcp"
  ipconfig1 = "ip=dhcp"
  ipconfig2 = "ip=dhcp"

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
  }

  network {
    model  = "virtio"
    bridge = "vmbr2"
  }

  disks {
    virtio {
      virtio0 {
        disk {
          iothread = true
          storage  = random_shuffle.datadisk.result[0]
          size     = var.frontend-disk_size
        }
      }
    }
  }

  provisioner "remote-exec" {
    # This inline provisioner is needed to accomplish the final fit and finish of your deployed
    # instance and configure the system to register the FQDN with the Consul DNS system
    inline = [
      "sudo hostnamectl set-hostname ${var.frontend-yourinitials}-vm${count.index}",
      "sudo sed -i 's/changeme/${random_id.id.dec}${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/replace-name/${var.frontend-yourinitials}-vm${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/ubuntu-server/${var.frontend-yourinitials}-vm${count.index}/' /etc/hosts",
      "sudo sed -i 's/FQDN/${var.frontend-yourinitials}-vm${count.index}.service.consul/' /etc/update-motd.d/999-consul-dns-message",
      "sudo sed -i 's/#datacenter = \"my-dc-1\"/datacenter = \"rice-dc-1\"/' /etc/consul.d/consul.hcl",
      "echo 'retry_join = [\"${var.consulip-240-prod-system28}\",\"${var.consulip-240-student-system41}\",\"${var.consulip-242-room}\"]' | sudo tee -a /etc/consul.d/consul.hcl",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart consul.service",
      "sudo rm /opt/consul/node-id",
      "sudo systemctl restart consul.service",
      "sudo sed -i 's/0.0.0.0/${var.frontend-yourinitials}-vm${count.index}.service.consul/' /etc/systemd/system/node-exporter.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable node-exporter.service",
      "sudo systemctl start node-exporter.service",
      "sudo growpart /dev/vda 3",
      "sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv",
      "sudo resize2fs /dev/ubuntu-vg/ubuntu-lv",
      "echo 'Your FQDN is: ' ; dig +answer -x ${self.default_ipv4_address} +short"
    ]

    connection {
      type        = "ssh"
      user        = "vagrant"
      private_key = file("${path.module}/${var.keypath}")
      host        = self.ssh_host
      port        = self.ssh_port
    }
  }
}

output "proxmox_frontend_ip_address_default" {
  description = "Current Public IP"
  value       = proxmox_vm_qemu.frontend-webserver.*.default_ipv4_address
}


###############################################################################
# Terraform Plan for backend Database instances
###############################################################################
resource "proxmox_vm_qemu" "backend-database" {
  count       = var.backend-numberofvms
  name        = "${var.backend-yourinitials}-vm${count.index}.service.consul"
  desc        = var.backend-desc
  #target_node = data.vault_generic_secret.target_node.data[random_shuffle.nodename.result[0]]
  target_node = random_shuffle.nodename.result[0]
  clone       = var.backend-template_to_clone
  os_type     = "cloud-init"
  memory      = var.backend-memory
  cores       = var.backend-cores
  sockets     = var.backend-sockets
  scsihw      = "virtio-scsi-pci"
  boot        = "order=virtio0"
  agent       = 1
  tags        = var.be-tags

  ipconfig0 = "ip=dhcp"
  ipconfig1 = "ip=dhcp"
  ipconfig2 = "ip=dhcp"

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
  }

  network {
    model  = "virtio"
    bridge = "vmbr2"
  }

  disks {
    virtio {
      virtio0 {
        disk {
          iothread = true
          storage  = random_shuffle.datadisk.result[0]
          size     = var.backend-disk_size
        }
      }
    }
  }

  provisioner "remote-exec" {
    # This inline provisioner is needed to accomplish the final fit and finish of your deployed
    # instance and configure the system to register the FQDN with the Consul DNS system
    inline = [
      "sudo hostnamectl set-hostname ${var.backend-yourinitials}-vm${count.index}",
      "sudo sed -i 's/changeme/${random_id.id.dec}${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/replace-name/${var.backend-yourinitials}-vm${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/ubuntu-server/${var.backend-yourinitials}-vm${count.index}/' /etc/hosts",
      "sudo sed -i 's/FQDN/${var.backend-yourinitials}-vm${count.index}.service.consul/' /etc/update-motd.d/999-consul-dns-message",
      "sudo sed -i 's/#datacenter = \"my-dc-1\"/datacenter = \"rice-dc-1\"/' /etc/consul.d/consul.hcl",
      "echo 'retry_join = [\"${var.consulip-240-prod-system28}\",\"${var.consulip-240-student-system41}\",\"${var.consulip-242-room}\"]' | sudo tee -a /etc/consul.d/consul.hcl",
      "sudo sed -i 's/HAWKID/${var.consul-service-tag-contact-email}/' /etc/consul.d/node-exporter-consul-service.json",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart consul.service",
      "sudo rm /opt/consul/node-id",
      "sudo systemctl restart consul.service",
      "sudo sed -i 's/0.0.0.0/${var.backend-yourinitials}-vm${count.index}.service.consul/' /etc/systemd/system/node-exporter.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable node-exporter.service",
      "sudo systemctl start node-exporter.service",
      "sudo systemctl stop mariadb.service",
      "sudo sed -i '1,$s/127.0.0.1/${var.backend-yourinitials}-vm${count.index}.service.consul/g' /etc/mysql/mariadb.conf.d/50-server.cnf",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart mariadb.service",
      "sudo growpart /dev/vda 3",
      "sudo lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv",
      "sudo resize2fs /dev/ubuntu-vg/ubuntu-lv",
      "echo 'Your FQDN is: ' ; dig +answer -x ${self.default_ipv4_address} +short"
    ]

    connection {
      type        = "ssh"
      user        = "vagrant"
      private_key = file("${path.module}/${var.keypath}")
      host        = self.ssh_host
      port        = self.ssh_port
    }
  }
}

output "proxmox_backend_ip_address_default" {
  description = "Current Public IP"
  value       = proxmox_vm_qemu.backend-database.*.default_ipv4_address
}
