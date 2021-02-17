# Shell script to build the virtual machines via Packer and add them to Vagrant

# Change location to the build directory
Set-Location -path ..\..\build\

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

if (Test-Path -Path ./mm-virtualbox*.box -PathType Leaf) {
    # Add the Web Server 3 
    vagrant box add ./mm-virtualbox*.box --name mm
} else {
    Write-Host "mm-virtualbox*.box build did not succeed as .box artifact isn't there..."
}

if (Test-Path -Path ./ms1-virtualbox*.box -PathType Leaf) {
    # Add the Web Server 3 
    vagrant box add ./ms1-virtualbox*.box --name ms1
} else {
    Write-Host "ms1-virtualbox*.box build did not succeed as .box artifact isn't there..."
}

if (Test-Path -Path ./ms2-virtualbox*.box -PathType Leaf) {
    # Add the Web Server 3 
    vagrant box add ./ms2-virtualbox*.box --name ms2
} else {
    Write-Host "ms2-virtualbox*.box build did not succeed as .box artifact isn't there..."
}

Set-Location -path ../professors-project-code/creation-scripts
