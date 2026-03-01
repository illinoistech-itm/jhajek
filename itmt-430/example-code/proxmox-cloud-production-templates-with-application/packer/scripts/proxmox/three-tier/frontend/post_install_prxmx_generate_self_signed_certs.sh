#!/bin/bash

# https://stackoverflow.com/questions/10175812/how-to-create-a-self-signed-certificate-with-openssl
# https://ethitter.com/2016/05/generating-a-csr-with-san-at-the-command-line/
sudo openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /home/flaskuser/signed.key -out /home/flaskuser/signed.crt -subj "/C=US/ST=IL/L=Chicago/O=IIT/OU=rice/CN=iit.edu"
sudo openssl dhparam -out /etc/nginx/dhparam.pem 2048

# Change ownership of generated keys so that the user: flaskapp can access them
sudo chown flaskuser:flaskuser /home/flaskuser/signed.key
sudo chown flaskuser:flaskuser /home/flaskuser/signed.crt
