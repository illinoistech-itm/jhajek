

vagrant plugin install vagrant-vbguest
#cd packer/scripts/
#bash build-script.sh
#bash add-all-vms.sh || exit 1
#bash start-vms-script.sh

packer build mongodb-server.json
packer build nginx-web-server.json
packer build node-application-server.json
packer build redis-caching-server.json

echo "[PACKER] build finished..."
