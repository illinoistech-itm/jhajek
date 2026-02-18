#!/bin/bash

# GPG keyring file
#Depending on what version of gpg that is used, different filenames are used for the keyring. "pubring.gpg", "trustedkeys.gpg"

sudo mkdir /opt/UbuntuMirror/mirrorkeyring/
gpg --no-default-keyring --keyring /opt/UbuntuMirror/mirrorkeyring/trustedkeys.gpg --import /usr/share/keyrings/ubuntu-archive-keyring.gpg

#Now change the permissions and ownership on the mirror.

# The group name is your username:

sudo chown -R root:vagrant /opt/UbuntuMirror/mirrorkeyring
sudo chmod -R 571 /opt/UbuntuMirror/mirrorkeyring
# Run the program 
# And the final part of setting up the mirror is to execute the files:

# /opt/UbuntuMirror/mirrorbuild.sh

# Now walk away. Your machine has a lot of downloading to do! Seriously... it'll take hours to download > 140 Gigabyte of data.

# Set up the remote access to the mirror via http
# We need to install Apache2. You could choose Apache version 1.3 but that is beyond the scope of this document.
# We can do this with sudo apt-get install apache2

ln -s /opt/UbuntuMirror/ubuntu-mirror /var/www/html/ubuntu
# This means when you go to download from your mirror, you will visit http://${mirrorbox-hostname}/ubuntu/.

# to test from commandline:

#wget  http://192.168.172.40/ubuntu/dists/focal-security/Release.gpg