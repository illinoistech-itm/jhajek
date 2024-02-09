terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.11"
    }
    consul = {
      source  = "hashicorp/consul"
      version = "2.20.0"
    }
    vault = {
      source = "hashicorp/vault"
      version = "3.23.0"
    }
  }
}

# Credentials defined in ENV .bashrc
# https://registry.terraform.io/providers/hashicorp/vault/latest/docs
provider "vault" {}

provider "proxmox" {
  pm_tls_insecure     = true
  pm_api_url          = data.vault_generic_secret.pm_api_url.data["SYSTEM41"]
  pm_api_token_id     = data.vault_generic_secret.pm_api_token_id.data["USERNAME"]
  pm_api_token_secret = data.vault_generic_secret.pm_api_token_secret.data["TOKEN"]
  pm_log_enable       = var.pm_log_enable
  pm_log_file         = var.pm_log_file
  pm_timeout          = var.pm_timeout
  pm_parallel         = var.pm_parallel
  pm_log_levels = {
    _default    = var.error_level
    _capturelog = ""
  }
} # end of provider "proxmox"

# Configure the Consul provider
provider "consul" {
  # insecure_https = true
  datacenter = "rice-dc-1"
  address    = "${var.consulip-240-prod-system28}:8500"
}
