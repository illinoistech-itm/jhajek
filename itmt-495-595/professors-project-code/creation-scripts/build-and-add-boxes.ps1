# Shell script to build the virtual machines via Packer and add them to Vagrant

Set-Location -path ..\
# Script to build 4 instances in parallel
packer build -force --var-file=./variables.json web-application-parallel-build.json

# Change location to the build directory
Set-Location -path ..\build\

# Test to see if the building of the boxes was succesful
if (Test-Path -Path ./lb-virtualbox*.box -PathType Leaf) {
    # Add the Load Balancer Box 
    vagrant box add ./lb-virtualbox*.box --name lb
} else {
    Write-Host "lb-virtualbox*.box build did not succeed as .box artifact isn't there..."
}

if (Test-Path -Path ./ws1-virtualbox*.box -PathType Leaf) {
    # Add the Web Server 1
    vagrant box add ./ws1-virtualbox*.box --name ws1
} else {
    Write-Host "ws1-virtualbox*.box build did not succeed as .box artifact isn't there..."
}

if (Test-Path -Path ./ws2-virtualbox*.box -PathType Leaf) {
    # Add the Web Server 2 
    vagrant box add ./ws2-virtualbox*.box --name ws2
} else {
    Write-Host "ws2-virtualbox*.box build did not succeed as .box artifact isn't there..."
}

if (Test-Path -Path ./ws3-virtualbox*.box -PathType Leaf) {
    # Add the Web Server 3 
    vagrant box add ./ws3-virtualbox*.box --name ws3
} else {
    Write-Host "ws3-virtualbox*.box build did not succeed as .box artifact isn't there..."
}

Set-Location -path ../professors-project-code/creation-scripts
