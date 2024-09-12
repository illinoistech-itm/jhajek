#!/bin/bash

sudo apt update

sudo apt install -y  apache2 mysql-server unzip php libapache2-mod-php php-mysqli

wget https://wordpress.org/latest.zip
unzip latest.zip
# Link for setting up a database and a user with permissions to install Wordpress
# https://stackoverflow.com/questions/31111847/identified-by-password-in-mysql
sudo mysql -e "CREATE DATABASE wp DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "CREATE USER 'worker'@'localhost' IDENTIFIED BY 'securepassword';"
sudo mysql -e "GRANT SELECT,INSERT,CREATE TEMPORARY TABLES ON wp.* TO 'worker'@'localhost';"


sudo mv ./wordpress/ /var/www/html/wordpress
