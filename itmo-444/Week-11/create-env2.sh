#!/bin/bash
# PHP composer install link hhttps://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
sudo apt-get update
sudo apt-get install -y apache2 git curl php php-simplexml unzip zip 

wget https://raw.githubusercontent.com/composer/getcomposer.org/1b137f8bf6db3e79a38a5bc45324414a6b1f9df2/web/installer -O - -q | php -- --quiet

php -d memory_limit=-1 composer.phar require aws/aws-sdk-php

cd /var/www/html
sudo git clone https://github.com/illinoistech-itm/jhajek.git  1>> /home/ubuntu/out.log 2>> /home/ubuntu/err.log

# command to copy index.html to /ver/www/html
