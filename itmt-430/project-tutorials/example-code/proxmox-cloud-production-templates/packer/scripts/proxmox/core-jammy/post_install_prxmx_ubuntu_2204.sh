#!/bin/bash 
set -e
set -v

# http://superuser.com/questions/196848/how-do-i-create-an-administrator-user-on-ubuntu
# http://unix.stackexchange.com/questions/1416/redirecting-stdout-to-a-file-you-dont-have-write-permission-on
# This line assumes the user you created in the preseed directory is vagrant
echo "%admin  ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/init-users
sudo groupadd admin
sudo usermod -a -G admin vagrant

sudo apt-get update
sudo apt-get dist-upgrade -y

# https://github.com/hashicorp/terraform-provider-vsphere/issues/516
# Remove /etc/machine-id so that all the cloned machines will get their own IP address upon DHCP request
# https://unix.stackexchange.com/questions/402999/is-it-ok-to-change-etc-machine-id
# Clones of machine-id due to /etc/machine-id and /var/lib/dbus/machine-id 
sudo rm -f /etc/machine-id
sudo touch /etc/machine-id

# turns out /etc/machine-id just reads from /var/lib/dbus/machine-id...
sudo rm -f /var/lib/dbus/machine-id
sudo touch /var/lib/dbus/machine-id