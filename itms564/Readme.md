# Instructions to run after OS install

Run the shell script: `cluster-script-run-after-install.sh` as `sudo`

These are needed modifications the OTS Cyber Tech requires to let our systems on the network

## Items

1. Disable Annonymous SSH users
1. Install and enable `qemu-guest-agent` for Proxmox be able to interface with your network
1. Enable Firewalld and open only port 22 (ssh) on ens18 (first ethernet)
1. Disable `chacha20-poly1305` in SSH encryption algorithms
