#!/bin/bash

############################################################################################
# Script to give a dynamic message about the consul DNS upon login
#
# https://landoflinux.com/linux_ssh_login_banner.html
#############################################################################################

sudo cat > /etc/profile.d/motd.sh <<'EOF'
#!/bin/sh
echo
echo "############################################################"
echo "This is an ITM Cloud Lab Elastic Instance."
echo "This cloud provides dynamic DNS resolution."
echo "Any instance in the cloud can be accessed by attaching the hostname to *.service.consul" 
echo "Your Fully Qualified Domain Name is: `hostname`.service.consul"
echo "The private meta-network attached to your instance: `hostname  -I | awk '{print $2}'`"
echo "############################################################"
echo
EOF

sudo chmod a+x /etc/profile.d/motd.sh