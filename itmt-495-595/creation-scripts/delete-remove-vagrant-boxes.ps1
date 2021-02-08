# This script will remove the Vagrant boxes (delete) and delete the built artifacts

# Destroy existing vagrant boxes
Set-Location ../build
Set-Location ./lb
vagrant destroy -f
Remove-Item ./.vagrant -Recurse
Set-Location ../ws1
vagrant destroy -f
Remove-Item ./.vagrant -Recurse
Set-Location ../ws2
vagrant destroy -f
Remove-Item ./.vagrant -Recurse
Set-Location ../ws3
vagrant destroy -f
Remove-Item ./.vagrant -Recurse


# Remove existing vagrant boxes
vagrant box remove lb --force 
vagrant box remove ws1 --force
vagrant box remove ws2 --force 
vagrant box remove ws3 --force 

Set-Location -path ../