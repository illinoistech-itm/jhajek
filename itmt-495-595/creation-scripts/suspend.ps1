# Bring up Vagrant Boxes

Set-Location -path ../build

# Change location to the lb directory
Set-Location -path ./lb
vagrant suspend
# Change location to the ws1 directory
Set-Location -path ../ws1
vagrant suspend
# Change location to the ws2 directory
Set-Location -path ../ws2
vagrant suspend
# Change location to the ws3 directory
Set-Location -path ../ws3s
vagrant suspend
Set-Location -path ../
