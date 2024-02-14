###############################################################################################
# This template demonstrates a Terraform plan to deploy one Ubuntu Focal 20.04 instance.
# Run this by typing: terraform apply -parallelism=1
###############################################################################################
resource "random_id" "id" {
  byte_length = 8
}

# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle#example-usage
resource "random_shuffle" "datadisk" {
  input        = ["datadisk1","datadisk2","datadisk3","datadisk4"]
  result_count = 1
}

resource "random_shuffle" "nodename" {
  input        = ["NODENAME3","NODENAME4"]
  result_count = 1
}

##############################################################################
# Connecting Vault with Secrets for Terraform
# https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret
# https://registry.terraform.io/providers/hashicorp/vault/latest/docs
# https://github.com/hashicorp/terraform/issues/16457
##############################################################################
data "vault_generic_secret" "pm_api_url" {
  path = "secret/team00-url"
}

data "vault_generic_secret" "pm_api_token_id" {
  path = "secret/team00-username-tf-system"
}

data "vault_generic_secret" "pm_api_token_secret" {
  path = "secret/team00-token-tf-system"
}

data "vault_generic_secret" "target_node" {
  path = "secret/team00-NODENAME"
}

resource "proxmox_vm_qemu" "vanilla-server" {
  count           = var.numberofvms
  name            = "${var.yourinitials}-vm${count.index}.service.consul"
  desc            = var.desc
  target_node     = "${data.vault_generic_secret.target_node.data[random_shuffle.nodename.result[0]]}"
  clone           = var.template_to_clone
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
    #macaddr = "04:9F:15:00:00:00" 
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
    #macaddr = "04:9F:15:00:00:00" 
  }

  network {
    model  = "virtio"
    bridge = "vmbr2"
    #macaddr = "04:9F:15:00:00:00" 
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
      "sudo hostnamectl set-hostname ${var.yourinitials}-vm${count.index}",
      "sudo sed -i 's/changeme/${random_id.id.dec}${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/replace-name/${var.yourinitials}-vm${count.index}/' /etc/consul.d/system.hcl",
      "sudo sed -i 's/ubuntu-server/${var.yourinitials}-vm${count.index}/' /etc/hosts",
      "sudo sed -i 's/FQDN/${var.yourinitials}-vm${count.index}.service.consul/' /etc/update-motd.d/999-consul-dns-message",
      "sudo sed -i 's/#datacenter = \"my-dc-1\"/datacenter = \"rice-dc-1\"/' /etc/consul.d/consul.hcl",
      "echo 'retry_join = [\"${var.consulip-240-prod-system28}\",\"${var.consulip-240-student-system41}\",\"${var.consulip-242-room}\"]' | sudo tee -a /etc/consul.d/consul.hcl",
      "sudo systemctl daemon-reload",
      "sudo systemctl restart consul.service",
      "sudo rm /opt/consul/node-id",
      "sudo systemctl restart consul.service",
      "sudo sed -i 's/0.0.0.0/${var.yourinitials}-vm${count.index}.service.consul/' /etc/systemd/system/node-exporter.service",
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

output "proxmox_ip_address_default" {
  description = "Current Pulbic IP"
  value = proxmox_vm_qemu.vanilla-server.*.default_ipv4_address
}
