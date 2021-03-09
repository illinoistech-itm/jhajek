# Bring up Vagrant Boxes

Set-Location -path ../../build

# Change location to the lb directory
Set-Location -path ./lb
vagrant halt
vagrant destroy -f
# Change location to the ws1 directory
Set-Location -path ../ws1
vagrant halt
vagrant destroy -f
# Change location to the ws2 directory
Set-Location -path ../ws2
vagrant halt
vagrant destroy -f
# Change location to the ws3 directory
Set-Location -path ../ws3
vagrant halt
vagrant destroy -f
# Change location to the mm directory
Set-Location -path ../mm
vagrant halt
vagrant destroy -f
# Change location to the ms1 directory
Set-Location -path ../ms1
vagrant halt
vagrant destroy -f
# Change location to the ms2 directory
Set-Location -path ../ms2
vagrant halt
vagrant destroy -f

Set-Location -path ../../professors-project-code/creation-scripts
