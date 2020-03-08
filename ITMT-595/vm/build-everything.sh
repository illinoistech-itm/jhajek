#!/bin/bash

vagrant plugin install vagrant-vbguest
cd packer/scripts/
bash build-script.sh
bash add-all-vms.sh || exit 1
bash start-vms-script.sh
