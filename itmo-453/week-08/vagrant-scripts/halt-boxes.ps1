param($vagrantboxes)
foreach ($box in $vagrantboxes) 
{
    write-host "Stoping: $($box)"
    Set-Location $box
    vagrant halt 
    write-host "Sleeping for 10 seconds..."
    Start-Sleep 10
    Set-Location ../
}
