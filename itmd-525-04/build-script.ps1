#mkdir xenial64-1,xenial64-2,xenail64-3,xenial64-4
vagrant plugin install vagrant-vbguest
Set-Location xenial64-1
vagrant up
Set-Location ../xenial64-2
vagrant up
Set-Location ../xenial64-3
vagrant up
Set-Location ../xenial64-4
vagrant up
Set-Location ../

