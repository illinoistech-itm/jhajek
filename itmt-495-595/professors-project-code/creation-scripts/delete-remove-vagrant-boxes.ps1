# This script will remove the Vagrant boxes (delete) and delete the built artifacts

# Remove existing vagrant boxes
vagrant box remove lb --force 
vagrant box remove ws1 --force
vagrant box remove ws2 --force 
vagrant box remove ws3 --force 
vagrant box remove mm --force
vagrant box remove ms1 --force 
vagrant box remove ms2 --force 

# Destroy existing vagrant boxes
Set-Location ../../build

Set-Location ./lb
Remove-Item -Verbose -Force ./.vagrant -Recurse

Set-Location ../ws1
Remove-Item -Verbose -Force ./.vagrant -Recurse

Set-Location ../ws2
Remove-Item -Verbose -Force ./.vagrant -Recurse

Set-Location ../ws3
Remove-Item -Verbose -Force ./.vagrant -Recurse

Set-Location ../mm
Remove-Item -Verbose -Force ./.vagrant -Recurse

Set-Location ../ms1
Remove-Item -Verbose -Force ./.vagrant -Recurse

Set-Location ../ms2
Remove-Item -Verbose -Force ./.vagrant -Recurse

Set-Location -path ../../professors-project-code/creation-scripts
