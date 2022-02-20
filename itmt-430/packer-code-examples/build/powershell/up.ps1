#########################################################################################
# This script will start all of the Vagrant boxes you have initialized via the
# vagrant up command
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
    vagrant up
    Write-Host "Finished bringing up all previous Vagrant elements of your application"
    # Resetting location up one levels
    Set-Location -Path ../
}
Set-Location -Path ./powershell