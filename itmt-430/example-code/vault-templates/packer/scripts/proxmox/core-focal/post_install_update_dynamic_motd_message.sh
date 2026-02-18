#!/bin/bash

############################################################################################
# Script to give a dynamic message about the consul DNS upon login
#
# https://ownyourbits.com/2017/04/05/customize-your-motd-login-message-in-debian-and-ubuntu/
#############################################################################################

sudo cat > /etc/update-motd.d/999-consul-dns-message <<'EOF'
#!/bin/sh

echo "################################################################################
# This is an ITM Cloud Lab Elastic Instance.                                   #
# This cloud provides dynamic DNS resolution.                                  #
# Instances in the Cloud Lab can be accessed by attaching the hostname         #
# to *.service.consul                                                          #
# Your Fully Qualified Domain Name is: FQDN                                    #
# The meta-network attached to your instance: `hostname  -I | awk '{print $3}'`#
################################################################################"
echo
EOF

sudo chmod a+x /etc/update-motd.d/999-consul-dns-message