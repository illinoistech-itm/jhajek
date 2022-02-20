#########################################################################################
# This script will poweroff or halt all of the Vagrant boxes you have initialized via the
# vagrant halt command
#########################################################################################
# Declare and array of all the box names
$directories='lb','ws1','ws2','ws3','db'
# Setting initial directory location
Write-Host "Setting initial directory location: "
Set-Location -Path ../project

ForEach ($directory in $directories)
{
    Write-Host "Entering directory: $directory"
    Set-Location -Path $directory
    # Start each virtual machine
    Write-Host "Starting vagrant box $directory"
    vagrant halt
    Write-Host "Finished halting all previous Vagrant elements of your application"
    # Resetting location up one levels
    Set-Location -Path ../
}
Set-Location -Path ./powershell
