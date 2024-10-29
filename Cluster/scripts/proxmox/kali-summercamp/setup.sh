#!/bin/bash

# Command to Install Additional Software and Configure Network
# echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list
apt-get update -y
apt-get install -y kali-linux-default kali-desktop-xfce network-manager openssh-server qemu-guest-agent
systemctl start qemu-guest-agent
systemctl enable NetworkManager
systemctl start NetworkManager
systemctl enable ssh
systemctl start ssh

echo "AllowTcpForwarding no" | sudo tee -a /etc/ssh/sshd_config.d/disable-tcp-forwarding.conf
echo "Ciphers -chacha20-poly1305@openssh.com" | sudo tee -a /etc/ssh/sshd_config.d/disable_chacha20-poly1305.conf
sudo chmod 600 /etc/ssh/sshd_config.d/disable_chacha20-poly1305.conf
echo "LoginGraceTime 0" | sudo tee -a /etc/ssh/sshd_config.d/rce.conf
sudo systemctl restart ssh

echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGTi1ciil8RrWQj1Vez1CLkaB4unBLUar/wPTg3wnI3Q palad@framework' >> /home/kali/.ssh/authorized_hosts
echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIxa4g6PfEZ3p7pYdqLnf7X0kiDkGNmQOe5g6HN2PGpB hajek@philedelphiaphilharmonic' >> /home/kali/.ssh/authorized_hosts
echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINrLNQjhEkY4PmTYmioK7vL+XlJpYiKqQB9XOLV55A58 mdawson2@iit.edu' >> /home/kali/.ssh/authorized_hosts
echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL4g3/jRjZXr3Tkm710ARa3lVZgyQ/jDZ2R9yxUC6+Hd izziwa@hawk.iit.edu' >> /home/kali/.ssh/authorized_hosts

# Add user to sudoers groups

echo 'Defaults:vagrant !requiretty' | sudo tee -a /etc/sudoers.d/vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' | sudo tee -a /etc/sudoers.d/vagrant
