param($vagrantboxes)
foreach ($box in $vagrantboxes) 
{
    write-host "Destroying: $($box)"
    Set-Location $box
    vagrant stop
    Remove-Item .vagrant -Recure -Force
    vagrant destroy -f
    write-host "Sleeping for 10 seconds..."
    Start-Sleep 10
    Set-Location ../
}
