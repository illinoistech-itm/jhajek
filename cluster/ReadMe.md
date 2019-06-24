########################################################
# Custom command added by Professor Jeremy to handle Ubuntu 18.04 using systemd-networkd by default 
# this will create a minimal netplan config and change control back to network manager.
#
##########################################################
d-i preseed/late_command string in-target wget -P /tmp/ $server/script.sh; in-target chmod $+x /tmp/script.sh; in-target /tmp/script.sh

https://askubuntu.com/questions/294338/is-it-possible-to-download-a-bash-script-and-execute-it-from-a-preseed-file

https://raw.githubusercontent.com/illinoistech-itm/jhajek/master/cluster/config.yaml

https://stackoverflow.com/questions/1125476/retrieve-a-single-file-from-a-repository