# Bring up Vagrant Boxes

Set-Location -path ../build

# Change location to the lb directory
Set-Location -path ./lb
vagrant halt
# Change location to the ws1 directory
Set-Location -path ../ws1
vagrant halt
# Change location to the ws2 directory
Set-Location -path ../ws2
vagrant halt
# Change location to the ws3 directory
Set-Location -path ../ws3
vagrant halt
Set-Location -path ../
