#!/bin/bash 
set -e
set -v

# http://superuser.com/questions/196848/how-do-i-create-an-administrator-user-on-ubuntu
# http://unix.stackexchange.com/questions/1416/redirecting-stdout-to-a-file-you-dont-have-write-permission-on
# This line assumes the user you created in the preseed directory is vagrant
echo "%admin  ALL=NOPASSWD: ALL" | sudo tee -a /etc/sudoers.d/init-users
sudo groupadd admin
sudo usermod -a -G admin vagrant

# Installing vagrant keys
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
#sudo mkdir -p /home/vagrant/.ssh
sudo chown -R vagrant:vagrant /home/vagrant/.ssh
cat ./vagrant.pub >> /home/vagrant/.ssh/authorized_keys
sudo chown -R vagrant:vagrant /home/vagrant/.ssh/authorized_keys
echo "All Done!"

#http://www.fail2ban.org/wiki/index.php/MANUAL_0_8#Jails
sudo apt-get update
sudo apt-get install -y fail2ban
sudo sed -i "s/bantime  = 600/bantime = -1/g" /etc/fail2ban/jail.conf
sudo systemctl enable fail2ban
sudo service fail2ban restart

##################################################
# Add User customizations below here
##################################################

export DEBIAN_FRONTEND=noninteractive
echo "mariadb-server mysql-server/root_password password $DBPASS" | sudo  debconf-set-selections
echo "mariadb-server mysql-server/root_password_again password $DBPASS" | sudo debconf-set-selections

sudo apt-get update
sudo apt-get install -y mariadb-server 

# chown the cloned github repo files so the user owns it 
###############################################################################
# Replace any occurance of hajek with the name of your own private repository #
###############################################################################

sudo chown -R vagrant:vagrant ~/hajek

# Inject the username and password for autologin later in a ~/.my.cnf file
# http://serverfault.com/questions/103412/how-to-change-my-mysql-root-password-back-to-empty/103423#103423
# https://stackoverflow.com/questions/8020297/mysql-my-cnf-file-found-option-without-preceding-group

echo -e "[mysqld]" > /root/.my.cnf
echo -e "\n\n[client]\nuser = root\npassword = $DBPASS" >> /root/.my.cnf
echo -e "\nport = 3306\nsocket = /var/run/mysqld/mysqld.sock\n" >> /root/.my.cnf

echo -e "[mysqld]" > /home/vagrant/.my.cnf.user
echo -e "\n\n[client]\nuser = worker\npassword = $USERPASS" >> /home/vagrant/.my.cnf.user
echo -e "\nport = 3306\nsocket = /var/run/mysqld/mysqld.sock\n" >> /home/vagrant/.my.cnf.user
echo -e "\ndefault-character-set = utf8mb4\n" >> /home/vagrant/.my.cnf.user

# Changing the mysql bind address with a script
# https://serverfault.com/questions/584607/changing-the-mysql-bind-address-within-a-script
# https://stackoverflow.com/questions/23670282/bind-address-missing-in-my-cnf-in-mysql-centos
# https://en.wikipedia.org/wiki/Sed
# If using mysql instead of MariaDB the path to the cnf file is /etc/mysql/mysql.conf.d/mysql.cnf
# sudo sed -i "s/.*bind-address.*/#bind-address = $DATABASEIP/" /etc/mysql/mysql.conf.d/mysql.cnf
sudo sed -i "s/.*bind-address.*/#bind-address = $MS1IP/" /etc/mysql/mariadb.conf.d/50-server.cnf 
sudo sed -i "s/.*server-id.*/server-id      =2/" /etc/mysql/mariadb.conf.d/50-server.cnf
sudo sed -i "s/.*log_bin.*/log_bin = \/var\/log\/mysql\/mysql-bin.log/" /etc/mysql/mariadb.conf.d/50-server.cnf

# Enable the service and start the service
# Explanation of linked service filenames mysql and mariadb
sudo systemctl daemon-reload
sudo systemctl restart mariadb.service
sudo systemctl status mariadb.service
sudo systemctl enable mariadb.service
sudo systemctl start mariadb.service

# Enable Firewall
# https://serverfault.com/questions/809643/how-do-i-use-ufw-to-open-ports-on-ipv4-only
# DBIP is configured in the packer environment variables to allow access from a variable IP
# https://serverfault.com/questions/790143/ufw-enable-requires-y-prompt-how-to-automate-with-bash-script
ufw --force enable
ufw allow proto tcp to 0.0.0.0/0 port 22
ufw allow from $ACCESSFROMIP to any port 3306

# set the /etc/hosts file to match hostname
echo "$LBIP     lb     lb.class.edu"   | sudo tee -a /etc/hosts
echo "$WS1IP     ws1    ws1.class.edu"  | sudo tee -a /etc/hosts
echo "$WS2IP     ws2  ws2.class.edu"   | sudo tee -a /etc/hosts
echo "$WS3IP     ws3  ws3.class.edu"   | sudo tee -a /etc/hosts
echo "$REDIP     redis  redis.class.edu" | sudo tee -a /etc/hosts
echo "$MMIP     mm  mm.class.edu" | sudo tee -a /etc/hosts
echo "$MS1IP     ms1  ms1.class.edu" | sudo tee -a /etc/hosts
echo "$MS2IP     ms2  ms2.class.edu" | sudo tee -a /etc/hosts
echo "$MS3IP     ms3  ms3.class.edu" | sudo tee -a /etc/hosts
sudo hostnamectl set-hostname ms1

# https://stackoverflow.com/questions/8055694/how-to-execute-a-mysql-command-from-a-shell-script
# This section uses the user environment variables declared in packer json build template
# #USERPASS and $BKPASS

sudo mysql -u root < ~/hajek/itmt-430/db-samples/create-user-with-permissions-ms1.sql

