###############################################################################################
# This template demonstrates a Terraform plan to deploy one Ubuntu Focal 20.04 instance.
# Run this by typing: terraform apply -parallelism=1
###############################################################################################
resource "random_id" "id" {
  byte_length = 8
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle#example-usage
resource "random_shuffle" "datadisk" {
  input        = ["datadisk3","datadisk4","datadisk5"]
  result_count = 1
}

###############################################################################################
# This launches an instance of the focal-ws template
###############################################################################################

resource "proxmox_vm_qemu" "focal-ws" {
  count           = var.numberofvms-ws
  name            = "${var.yourinitials-ws}-vm${count.index}"
  desc            = var.desc-ws
  target_node     = var.target_node
  clone           = var.template_to_clone-ws
  os_type         = "cloud-init"
  memory          = var.memory
  cores           = var.cores
  sockets         = var.sockets
  scsihw          = "virtio-scsi-pci"
  bootdisk        = "virtio0"
  boot            = "cdn"
  agent           = 1

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

  disk {
    type    = "virtio"
    storage = random_shuffle.datadisk.result[0]
    size    = var.disk_size
  }

  provisioner "remote-exec" {
    # This inline provisioner is needed to accomplish the final fit and finish of your deployed
    # instance and condigure the system to register the FQDN with the Consul DNS system
    inline = [
      "sudo hostnamectl set-hostname ${var.yourinitials-ws}-vm${count.index}",
      "sudo sed -i 's/changeme/${random_id.id.dec}${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/replace-name/${var.yourinitials-ws}-vm${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/focal/${var.yourinitials-ws}-vm${count.index}/' /etc/hosts",
      "sudo sed -i 's/#datacenter = \"my-dc-1\"/datacenter = \"rice-dc-1\"/' /etc/consul.d/consul.hcl",
      "echo 'retry_join = [\"${var.consulip}\"]' | sudo tee -a /etc/consul.d/consul.hcl",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart consul.service",
      "sudo systemctl restart post_install_iptables-dns-adjustment.service",
      "sudo cat /opt/consul/node-id",
      "sudo rm /opt/consul/node-id",
      "sudo systemctl restart consul"
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

###############################################################################################
# This launches an instance of the focal-db template
###############################################################################################

resource "proxmox_vm_qemu" "focal-db" {
  count           = var.numberofvms
  name            = "${var.yourinitials-db}-vm${count.index}"
  desc            = var.desc-db
  target_node     = var.target_node
  clone           = var.template_to_clone-db
  os_type         = "cloud-init"
  memory          = var.memory
  cores           = var.cores
  sockets         = var.sockets
  scsihw          = "virtio-scsi-pci"
  bootdisk        = "virtio0"
  boot            = "cdn"
  agent           = 1

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

  disk {
    type    = "virtio"
    storage = random_shuffle.datadisk.result[0]
    size    = var.disk_size
  }

  provisioner "remote-exec" {
    # This inline provisioner is needed to accomplish the final fit and finish of your deployed
    # instance and condigure the system to register the FQDN with the Consul DNS system
    inline = [
      "sudo hostnamectl set-hostname ${var.yourinitials-db}-vm${count.index}",
      "sudo sed -i 's/changeme/${random_id.id.dec}${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/replace-name/${var.yourinitials-db}-vm${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/ubuntu-server/${var.yourinitials-db}-vm${count.index}/' /etc/hosts",
      "sudo sed -i 's/FQDN/${var.yourinitials-db}-vm${count.index}.service.consul/' /etc/update-motd.d/999-consul-dns-message",
      "sudo sed -i 's/#datacenter = \"my-dc-1\"/datacenter = \"rice-dc-1\"/' /etc/consul.d/consul.hcl",
      "echo 'retry_join = [\"${var.consulip}\"]' | sudo tee -a /etc/consul.d/consul.hcl",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart consul.service",
      "sudo systemctl restart post_install_iptables-dns-adjustment.service",
      "sudo cat /opt/consul/node-id",
      "sudo rm /opt/consul/node-id",
      "sudo systemctl restart consul"
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
###############################################################################################
# This launches an instance of the focal-lb template
###############################################################################################

resource "proxmox_vm_qemu" "focal-lb" {
  count           = var.numberofvms
  name            = "${var.yourinitials-lb}-vm${count.index}"
  desc            = var.desc-lb
  target_node     = var.target_node
  clone           = var.template_to_clone-lb
  os_type         = "cloud-init"
  memory          = var.memory
  cores           = var.cores
  sockets         = var.sockets
  scsihw          = "virtio-scsi-pci"
  bootdisk        = "virtio0"
  boot            = "cdn"
  agent           = 1

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

  disk {
    type    = "virtio"
    storage = random_shuffle.datadisk.result[0]
    size    = var.disk_size
  }

    ###############################################################################################
    # Added explicit dependency to make sure all resources started before the load balancer
    # The DNS with Consul needs to be registered first or the load balancer will crash
    ###############################################################################################
    depends_on = [proxmox_vm_qemu.focal-ws, proxmox_vm_qemu.focal-db]

  provisioner "remote-exec" {
    # This inline provisioner is needed to accomplish the final fit and finish of your deployed
    # instance and condigure the system to register the FQDN with the Consul DNS system
    inline = [
      "sudo hostnamectl set-hostname ${var.yourinitials-lb}-vm${count.index}",
      "sudo sed -i 's/changeme/${random_id.id.dec}${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/replace-name/${var.yourinitials-lb}-vm${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/ubuntu-server/${var.yourinitials-lb}-vm${count.index}/' /etc/hosts",
      "sudo sed -i 's/FQDN/${var.yourinitials-lb}-vm${count.index}.service.consul/' /etc/update-motd.d/999-consul-dns-message",
      "sudo sed -i 's/#datacenter = \"my-dc-1\"/datacenter = \"rice-dc-1\"/' /etc/consul.d/consul.hcl",
      "echo 'retry_join = [\"${var.consulip}\"]' | sudo tee -a /etc/consul.d/consul.hcl",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart consul.service",
      "sudo systemctl restart post_install_iptables-dns-adjustment.service",
      "sudo cat /opt/consul/node-id",
      "sudo rm /opt/consul/node-id",
      "sudo systemctl restart consul"
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
