packer build --var-file=variables-lb.json ./ubuntu-lb-multi.json ; packer build --var-file=variables-ws.json ./ubuntu-ws1-multi.json ; packer build --var-file=variables-ws.json ./ubuntu-ws2-multi.json ; packer build --var-file=variables-ws.json ./ubuntu-ws3-multi.json

cd ../build/fullstack

./add-boxes.ps1
./start-all.ps1