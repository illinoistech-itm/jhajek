sudo apt update

sudo apt install -y qemu-guest-agent
sudo systemctl enable qemu-guest-agent
sudo systemctl start qemu-guest-agent

sudo sed -i '1,$s/#AllowTcpForwarding yes/AllowTcpForwarding no/' /etc/ssh/sshd_config
echo "Ciphers -chacha20-poly1305@openssh.com" >> /etc/ssh/sshd_config.d/disable_chacha20-poly1305.conf
chmod 600 /etc/ssh/sshd_config.d/disable_chacha20-poly1305.conf

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