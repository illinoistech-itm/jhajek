#!/bin/bash

############################################################################################
# Script to give a dynamic message about the consul DNS upon login
#
# https://ownyourbits.com/2017/04/05/customize-your-motd-login-message-in-debian-and-ubuntu/
#############################################################################################

sudo cat > /etc/update-motd.d/999-consul-dns-message <<'EOF'
#!/bin/sh
echo
echo "###############################################################################"
echo "This is an ITM Cloud Lab Elastic Instance."
echo "This cloud provides dynamic DNS resolution."
echo "Any instance in the cloud can be accessed by attaching the hostname to *.service.consul" 
echo "Your Fully Qualified Domain Name is: FQDN"
echo "The private meta-network attached to your instance: `hostname  -I | awk '{print $3}'`"
echo "###############################################################################"
echo
EOF

sudo chmod a+x /etc/update-motd.d/999-consul-dns-message
