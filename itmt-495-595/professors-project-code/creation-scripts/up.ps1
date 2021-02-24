# Bring up Vagrant Boxes

Set-Location -path ../../build

# Change location to the ws3 directory
Set-Location -path ./mm
vagrant up
# Change location to the ws3 directory
Set-Location -path ../ms1
vagrant up
# Change location to the ws3 directory
Set-Location -path ../ms2
vagrant up
# Change location to the lb directory
Set-Location -path ../lb
vagrant up
# Change location to the ws1 directory
Set-Location -path ../ws1
vagrant up
# Change location to the ws2 directory
Set-Location -path ../ws2
vagrant up
# Change location to the ws3 directory
Set-Location -path ../ws3
vagrant up


Set-Location -path ../../professors-project-code/creation-scripts
