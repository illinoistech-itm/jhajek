# Instructions to run after OS install

Using the `git` command, in your Home directory you need to run a configuration shell script. 

Issue the command `git clone https://github.com/illinoistech-itm/jhajek`

Change directory to: `jhajek/itms-564/` and run the required configuration shell script: `sudo bash ./cluster-script-run-after-install.sh`

These are needed OS modifications required by the OTS Cyber Tech group to let our systems on the network. Reboot after install.

## Items

1. Disable anonymous SSH users
1. Install and enable `qemu-guest-agent` for Proxmox be able to interface with your network
1. Enable Firewalld and open only port 22 (ssh) on ens18 (first ethernet)
1. Disable `chacha20-poly1305` in SSH encryption algorithms
1. Enable `fail2ban` to prevent brute force SSH attacks
