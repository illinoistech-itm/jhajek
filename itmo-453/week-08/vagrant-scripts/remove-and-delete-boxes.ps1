param($vagrantboxes)
foreach ($box in $vagrantboxes) 
{
    write-host "Beginning the process to destroy and remove: $($box)"
    Set-Location $box
    write-host "Stoping $($box)..."
    vagrant halt
    write-host "Destroying $($box)..."
    vagrant destroy -f
    write-host "Removing temporary files in .vagrant directory..."
    Remove-Item .vagrant -Recurse -Force	
    write-host "Removing the vagrant box: $($box)..."
    vagrant box remove $box 
    write-host "Sleeping for 10 seconds..."
    Start-Sleep 10
    Set-Location ../
}
