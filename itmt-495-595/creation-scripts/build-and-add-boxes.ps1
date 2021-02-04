# Shell script to build the virtual machines via Packer and add them to Vagrant

packer build -var-file=.\variables.json .\web-application-parallel-build.json

# Change location to the build directory
Set-Location -path ..\build\

# Add the Load Balancer Box 
vagrant add ./lb/lb-virtualbox*.box --name lb
# Add the Web Server 1
vagrant add ./ws1/ws1-virtualbox*.box --name ws1
# Add the Web Server 2 
vagrant add ./ws2/ws2-virtualbox*.box --name ws2
# Add the Web Server 3 
vagrant add ./ws3/ws3-virtualbox*.box --name ws3
