vagrant halt
vagrant destroy -f
vagrant box remove sample-server
Remove-Item -Verbose ./.vagrant -Recurse

Set-Location -path ../../build/

Remove-Item -Verbose ./*.box

Set-Location -path ../build-scripts/vagrantfile