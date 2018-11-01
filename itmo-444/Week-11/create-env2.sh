#!/bin/bash
# PHP composer install link hhttps://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
sudo apt-get update
sudo apt-get install -y apache2 git curl php php-simplexml unzip zip libapache2-mod-php

# download and install php composer
wget https://raw.githubusercontent.com/composer/getcomposer.org/1b137f8bf6db3e79a38a5bc45324414a6b1f9df2/web/installer -O - -q | php -- --quiet

# download and install aws-skp-php library and package
php -d memory_limit=-1 composer.phar require aws/aws-sdk-php

# move vendor to /home/ubuntu

mv vendor/ /home/ubuntu

cd /var/www/html
sudo git clone https://github.com/illinoistech-itm/jhajek.git  1>> /home/ubuntu/out.log 2>> /home/ubuntu/err.log

