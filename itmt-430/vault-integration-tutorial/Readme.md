# Vault Integration Tutorial

This tutorial will walk through the installation and configuration of a Hashicorp Vault for Secrets Storage. All data is taken from the [Hashicorp Vault Tutorial](https://developer.hashicorp.com/vault/docs "webpage for hashicorp vault tutorial").

## Outcomes

Walking through this written and demo tutorial you will find how to create a Vault with secrets, creating limited access to those secrets, and finally removing hardcoding any secrets into files

### What is Vault

> *Vault is an identity-based secret and encryption management system.*

> *Secure applications and protect sensitive data. Create and secure access to tokens, passwords, certificates, and encryption keys.*

> *The kv secrets engine is a generic Key-Value store used to store arbitrary secrets within the configured physical storage for Vault. This backend can be run in one of two modes; either it can be configured to store a single value for a key or, versioning can be enabled and a configurable number of versions for each key will be stored.*

### First Steps with Packer

Each team will need to build and deploy their own Vault server. There is a new Packer build template provided in the `three-tier` example code to build a template/image just to host your Vault server. Vault is sperate from the Packer build template used to create frontend, backend, and load-balancers. The Vault server lives outside of the application so that is why we have a second Packer build template.

There is a simple shell provisioner under the `three-tier` > `vault` folder to open a firewall port (8200) on the `meta-network` to listen for credential requests and to install the Vault software. This will allow you to build a vm template that has Vault installed and firewall port opened. There are no settings to configure here, we will be entering all the vault credentials ourselves.

### Second Steps with Terraform

You will find a sample Terraform plan in the `example-code` > `proxmox-cloud-production-templates` > `terraform` `proxmox-jammy-ubuntu-vault` sample code. You will modify the `template-terraform.tfvars` as noted. Execute `terraformm apply`.

### Confuguring Vault

Following these few steps we can configure a simple Vault K/V pair server with our secrets and then integrate those secrets into our Packer build templates. Note that Vault is has a wide range of features far beyond this simple tutorial, it has built in AWS integration as well. This is just the tip of the iceberg showing how to run a production Vault.

* SSH into your new Vault server
* Add to your .bashrc on your new Vault server the following:
  * `export VAULT_ADDR='https://127.0.0.1:8200'`
  * `export VAULT_SKIP_VERIFY="true"`
    * This will allow for communication over TLS using a self-signed cert
  * Run the command to re-read the `.bashrc` file: `. ~/.bashrc`
* `sudo systemctl start vault`
* `sudo systemctl enable vault`
  * Normally services auto-start in Ubuntu but not Vault
* `vault operator init`
  * This will start a vault
  * Creates 5 unseal keys
  * Creates 1 root key
  * Save these somewhere safe
  * No need to use `sudo`
* `vault operator unseal`
  * Need to execute this three times and give three of the five undeal keys (1 each time) to unseal the Vault
* `vault login`
  * No need to use `sudo`
  * Give the root key give when the `vault operator init` was shown
* `vault secrets enable -version=2 -path=secret kv`
  * This enables the `secret` storage engine version 2
  * A storage engine needs to be enabled before anything can be stored
* Create a policy file named team00.hcl using vim
  * Adjust your team name file accordingly

```hcl
# This gives complete access to secrets written in your vault.
# Careful using this wide open of permissions
path "secret/data/*" {
  capabilities = ["read","create", "update","delete"]
}
```

* Write policy file into Vault
  * `vault policy write team00 ./team00.hcl`
* Create a token for your team to authenticate with
  * `vault token create --ttl=21600 -policy=team00`   
  * ttl here is 15 days in hours
  * Token expires at that time
  * Copy down the token created here -- this will be used by Packer to authenticate
  * We don't want to use the `root` key -- as little as possible
* Lets create some secrets
  * `vault kv put -mount=secret team00-db DBPASS=letmein DBUSER=controller FQDN=team000-fe.service.consul DATABASENAME=foo`
  * `vault kv put -mount=secret team00-ssh SSHPASS=vagrant`
* You can seal up the Vault so that no one can use it
  * `vault operator seal`
  * This shuts the vault down from answering any requests -- needs to be unsealed when you want to use it again

### Adjustments to your user account on the buildserver

* On your account in the IT/Ops buildserver login and edit your (this sprints IT/OPs person) `~/.bashrc`
* Add these value to the end, replacing of course with your values
  * `export VAULT_ADDR='https://vault-team000-vm0.service.consul:8200'`
  * `export VAULT_SKIP_VERIFY="true"`
  * `export VAULT_TOKEN="hvs.CAESIANek…`
    * This is the key generated earlier by the command: `vault token create --ttl=21600 -policy=team00`
    * We don't want to use the `root` key -- as little as possible
 * Save and exit
 * Issue the command `. ~/.bashrc` to re-process your changes to the `.bashrc` file on the Buildserver

Now your Packer build will connect and authenticate to retrieve these secrets

### Packer and Vault Integration

You will find sample code in the `packer` > `proxmox-jammy-ubuntu-sample-vars-using-vault` directory. Note this is not a working Proxmox integrated sample, you will use pieces from this sample. 

In the `template-for-variables.pkr.hcl` you will find two new values starting on line 15 and 29

```hcl
# Syntax
# https://developer.hashicorp.com/packer/docs/templates/hcl_templates/functions/contextual/vault
locals {
  user-ssh-password = vault("/secret/data/team00-ssh","SSHPASS")
}

# Syntax
# https://developer.hashicorp.com/packer/docs/templates/hcl_templates/functions/contextual/vault
locals {
  db_user = vault("/secret/data/team00-db", "DBUSER")
}
```

In place of the keyword `variable` you are now using the term `locals`.  You access the values from Vault ia the `vault()` function. The path `secret/data/` is part of the default we set up.  We initialized the `secret` engine and this is where the root path of `secret` came from.  Vault uses a file like hierarchy for storing and giving permissions to secrets. 

`vault kv put -mount=secret team00-ssh SSHPASS=vagrant`

Looking back at the `vault kv put` command we see where the remaining path comes from.  

### Using Vault Secrets in the main Packer build template

Now that we have variables reading from Vault, we can access these variables in the main Packer build template. In the example-code, this is called: `proxmox-jammy-ubuntu-sample-vars-using-vault.pkr.hcl`. 

You can see on line 35 the first time we use one of the Vault secrets for our Vagrant SSH password and that we use the prefix `${local}` and not `${var}`.

```hcl
  # Make use of the ${local} and not ${var} when using Vault variables
  ssh_password            = "${local.user-ssh-password}"
  ```

  and again on line 59:

  ```hcl
    provisioner "shell" {
    inline = ["echo $DBUSER", "echo $DBUSER > /home/vagrant/TEST"]
    environment_vars = ["DBUSER=${local.db_user}"]
  }
  ```

### Check if it Works

You can see if you can succesfully authenticate to Vault as well as all the variables are properly defined using the `packer validate .` -- this command takes on new meaning using Vault Packer intergrations.

## Conclusion

Congratualations. You have succesfully walked through creating a secure secrets environment, increased security by reducing manual secret management, and creating central secret integration. This is one of the first steps in deploying cloud native applications is a secure manner.
