#!/bin/bash
# PHP composer install link hhttps://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
sudo apt-get update
sudo apt-get install -y apache2 git curl php php-simplexml unzip zip libapache2-mod-php

# download and install php composer - https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md

EXPECTED_SIGNATURE="$(wget -q -O - https://composer.github.io/installer.sig)"
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
ACTUAL_SIGNATURE="$(php -r "echo hash_file('SHA384', 'composer-setup.php');")"

if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
then
    >&2 echo 'ERROR: Invalid installer signature'
    rm composer-setup.php
    exit 1
fi

php composer-setup.php --quiet
RESULT=$?


# download and install aws-skp-php library and package
php -d memory_limit=-1 composer.phar require aws/aws-sdk-php

# move vendor to /home/ubuntu

mv vendor/ /home/ubuntu

cd /var/www/html
sudo git clone https://github.com/illinoistech-itm/jhajek.git  1>> /home/ubuntu/out.log 2>> /home/ubuntu/err.log

