sudo apt update

sudo apt install -y qemu-guest-agent openssh-server fail2ban cloud-init
sudo systemctl start qemu-guest-agent
sudo systemctl enable --now cloud-init
sudo systemctl enable --now sshd
sudo systemctl enable --now fail2ban

sudo sed -i '1,$s/#AllowTcpForwarding yes/AllowTcpForwarding no/' /etc/ssh/sshd_config
echo "Ciphers -chacha20-poly1305@openssh.com" >> /etc/ssh/sshd_config.d/disable_chacha20-poly1305.conf
chmod 600 /etc/ssh/sshd_config.d/disable_chacha20-poly1305.conf

echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGgpyrTX0Gzq1DLtwX2JwzlxfNaNfMtT55GFNbvyK2nv palad@framework' >> ~/.ssh/authorized_keys
echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILku9jD8B9RYDb14u1lo+2Y68i/SzSFfrLLRttrlNqGx palad@framework' >> ~/.ssh/authorized_keys

#############################################################################
# Enable firewalld and allow only ssh through by default
#############################################################################sudo apt-get update
sudo apt-get install -y firewalld

sudo systemctl enable firewalld
sudo systemctl start firewalld
#############################################################################
# sudo firewall-cmd --zone=public --add-interface=ens18 --permanent
# Creates a zone that restricts traffic to that one interface ens18
#############################################################################
sudo firewall-cmd --zone=public --add-interface=ens18 --permanent
sudo firewall-cmd --zone=public --add-service=ssh --permanent

sudo firewall-cmd --reload