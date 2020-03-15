

vagrant plugin install vagrant-vbguest
#cd packer/scripts/
#bash build-script.sh
#bash add-all-vms.sh || exit 1
#bash start-vms-script.sh

packer build --var-files=./variables.json mongodb-server.json
packer build --var-files=./variables.json nginx-web-server.json
packer build --var-files=./variables.json node-application-server.json
packer build --var-files=./variables.json redis-caching-server.json

echo "[PACKER] build finished..."
