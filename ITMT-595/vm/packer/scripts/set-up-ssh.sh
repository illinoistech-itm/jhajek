#!/bin/bash

mv id_rsa_github_deploy_key /home/vagrant/.ssh/
cd .ssh
chmod 400 /home/vagrant/.ssh/id_rsa_github_deploy_key
eval "$(ssh-agent -s)"
ssh-add /home/vagrant/.ssh/id_rsa_github_deploy_key

cat <<EOT > /home/vagrant/.ssh/config
Host github.com
User git
Port 22
Hostname github.com
IdentityFile ~/.ssh/id_rsa_github_deploy_key
TCPKeepAlive yes
IdentitiesOnly yes
StrictHostKeyChecking no
EOT
