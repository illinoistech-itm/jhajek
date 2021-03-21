Set-Location -path ../../build/

vagrant box add ./sample-server*.box --name sample-server

Set-Location -path ../build-scripts/vagrantfile
