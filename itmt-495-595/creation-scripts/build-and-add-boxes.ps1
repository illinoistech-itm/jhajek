# Shell script to build the virtual machines via Packer and add them to Vagrant

packer build --var-file=.\variables.json .\web-application-parallel-build.json

# Change location to the build directory
Set-Location -path ..\build\

# Add the Load Balancer Box 
vagrant box add ./lb-virtualbox*.box --name lb
# Add the Web Server 1
vagrant box add ./ws1-virtualbox*.box --name ws1
# Add the Web Server 2 
vagrant box add ./ws2-virtualbox*.box --name ws2
# Add the Web Server 3 
vagrant box add ./ws3-virtualbox*.box --name ws3

Set-Location -path ../