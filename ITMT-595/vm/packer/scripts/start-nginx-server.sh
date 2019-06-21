#!/bin/bash
#Self signed cert
#https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-18-04

sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=US/ST=Illinois/L=Chicago/O=IIT-Company/OU=Org/CN=192.168.50.11"
# While we are using OpenSSL, we should also create a strong Diffie-Hellman group, which is used in negotiating Perfect Forward Secrecy with clients.

sudo openssl dhparam -dsaparam -out /etc/nginx/dhparam.pem 2048

sudo chmod 777 /etc/nginx/snippets/
sudo cat <<EOT > /etc/nginx/snippets/self-signed.conf
ssl_certificate /etc/ssl/certs/nginx-selfsigned.conf;
ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
EOT

# The parameters we will set can be reused in future Nginx configurations 
# Second, we will comment out the line that sets the strict transport security header. Before uncommenting this line, you should take take a moment to read up on HTTP Strict Transport Security, or HSTS, and specifically about the "preload" functionality. Preloading HSTS provides increased security, but can have far reaching consequences if accidentally enabled or enabled incorrectly.

cat <<EOT > /etc/nginx/snippets/ssl-params.conf
ssl_protocols TLSv1.2;
ssl_prefer_server_ciphers on;
ssl_dhparam /etc/nginx/dhparam.pem;
ssl_ciphers ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384;
ssl_ecdh_curve secp384r1; # Requires nginx >= 1.1.0
ssl_session_timeout  10m;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off; # Requires nginx >= 1.5.9
ssl_stapling on; # Requires nginx >= 1.3.7
ssl_stapling_verify on; # Requires nginx => 1.3.7
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s;
# Disable strict transport security for now. You can uncomment the following
# line if you understand the implications.
# add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;
add_header X-XSS-Protection "1; mode=block";
EOT

sudo chown vagrant /etc/nginx/sites-available/
sudo unlink /etc/nginx/sites-enabled/default

cd /etc/nginx/sites-available
sudo touch reverse-proxy.conf

# Give ownership over file
sudo chown vagrant /etc/nginx/sites-available/reverse-proxy.conf

# Create reverse proxy config
# https://www.scaleway.com/docs/how-to-configure-nginx-reverse-proxy/
cat <<EOT > /etc/nginx/sites-available/reverse-proxy.conf
server {
    listen nginx-web-server:443 ssl;
    listen [::]:443 ssl;
    include snippets/self-signed.conf;
    include snippets/ssl-params.conf;

    server_name nginx-web-server;
    location / {
        proxy_pass http://node-application-server:8080;
        proxy_http_version 1.1;
        proxy_set_header Connection 'upgrade';
    }
}
EOT

# cat <<EOT >> /etc/nginx/sites-available/reverse-proxy.conf
# server {
#     listen nginx-web-server:80;
#     listen [::]:80;

#     server_name nginx-web-server;

#     return 302 https://$host:8080$request_uri;
# }
# EOT



# Rename file in /etc/ssl/certs
sudo mv /etc/ssl/certs/nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.conf

#Allow HTTPS traffic
sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'

# Start nginx web server
sudo systemctl stop nginx.service
sudo nginx

echo "[NGINX] server running..."
