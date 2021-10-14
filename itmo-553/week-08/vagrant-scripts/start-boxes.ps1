param($vagrantboxes)
foreach ($box in $vagrantboxes) 
{
    write-host "Starting: $($box)"
    Set-Location $box
    vagrant up
    write-host "Sleeping for 10 seconds..."
    Start-Sleep 10
    Set-Location ../
}
