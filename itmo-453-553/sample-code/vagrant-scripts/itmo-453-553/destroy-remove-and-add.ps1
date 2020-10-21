# Destroy existing vagrant boxes
Set-Location ub-riemanna
vagrant destroy -f
Remove-Item ./.vagrant -Recurse
Set-Location ../centos-riemannb
vagrant destroy -f
Remove-Item ./.vagrant -Recurse
Set-Location ../ub-riemannmc
vagrant destroy -f
Remove-Item ./.vagrant -Recurse
Set-Location ../ub-graphitea
vagrant destroy -f
Remove-Item ./.vagrant -Recurse
Set-Location ../centos-graphiteb
vagrant destroy -f
Remove-Item ./.vagrant -Recurse
Set-Location ../ub-graphitemc
vagrant destroy -f
Remove-Item ./.vagrant -Recurse
Set-Location ../host1
vagrant destroy -f
Remove-Item ./.vagrant -Recurse
Set-Location ../host2
vagrant destroy -f
Remove-Item ./.vagrant -Recurse
Set-Location ../

# Remove existing vagrant boxes
vagrant box remove ub-riemanna --force 
vagrant box remove centos-riemannb --force
vagrant box remove ub-riemannmc --force 
vagrant box remove ub-graphitea --force 
vagrant box remove centos-graphiteb --force 
vagrant box remove ub-graphitemc --force 
vagrant box remove host1 --force
vagrant box remove host2 --force

# Add newly built Vagrant boxes
If (Test-Path -Path ../../itmo-453-553/build/ub-riemanna-virtualbox*.box) {
    vagrant box add ../../itmo-453-553/build/ub-riemanna-virtualbox*.box --name ub-riemanna
} Else {
    Write-Host "File ../../itmo-453-553/build/ub-riemanna-virtualbox*.box doesn't exist"
}
If (Test-Path -Path ../../itmo-453-553/build/centos-riemannb-virtualbox*.box) {
    vagrant box add ../../itmo-453-553/build/centos-riemannb-virtualbox*.box --name centos-riemannb
} Else {
    Write-Host "File ../../itmo-453-553/build/centos-riemannb-virtualbox*.box doesn't exist"
}
If (Test-Path -Path ../../itmo-453-553/build/ub-riemannmc-virtualbox*.box) {
    vagrant box add ../../itmo-453-553/build/ub-riemannmc-virtualbox*.box --name ub-riemannmc
} Else {
    Write-Host "File ../../itmo-453-553/build/ub-riemannmc-virtualbox*.box doesn't exist"
}
If (Test-Path -Path ../../itmo-453-553/build/ub-graphitea-virtualbox*.box) {
    vagrant box add ../../itmo-453-553/build/ub-graphitea-virtualbox*.box --name ub-graphitea
} Else {
    Write-Host "File ../../itmo-453-553/build/ub-graphitea-virtualbox*.box doesn't exist"
}
If (Test-Path -Path ../../itmo-453-553/build/centos-graphiteb-virtualbox*.box) {
    vagrant box add ../../itmo-453-553/build/centos-graphiteb-virtualbox*.box --name centos-graphiteb
} Else {
    Write-Host "File ../../itmo-453-553/build/centos-graphiteb-virtualbox*.box doesn't exist"
}
If (Test-Path -Path ../../itmo-453-553/build/ub-graphitemc-virtualbox*.box) {
    vagrant box add ../../itmo-453-553/build/ub-graphitemc-virtualbox*.box --name ub-graphitemc
} Else {
    Write-Host "File ../../itmo-453-553/build/ub-graphitemc-virtualbox*.box doesn't exist"
}
If (Test-Path -Path ../../itmo-453-553/build/centos-host2-virtualbox*.box) {
    vagrant box add ../../itmo-453-553/build/centos-host2-virtualbox*.box --name host2
} Else {
    Write-Host "File ../../itmo-453-553/build/centos-host2-virtualbox*.box doesn't exist"
}
If (Test-Path -Path ../../itmo-453-553/build/ub-host1-virtualbox*.box) {
    vagrant box add ../../itmo-453-553/build/ub-host1-virtualbox*.box --name host1
} Else {
    Write-Host "File ../../itmo-453-553/build/ub-host1-virtualbox*.box doesn't exist"
}