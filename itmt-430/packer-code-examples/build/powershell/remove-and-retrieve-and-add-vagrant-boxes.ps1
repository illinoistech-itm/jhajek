######################################################################################
# This PowerShell script will retrieve your team's Vagrant Boxes from the build-server
# http://192.168.172.44/boxes
# As each team is numbered this will allow you to retrieve and to issue the 
# vagrant box add command at the same time.
######################################################################################

# Change XX to your team number with leading Zero
# Create an array of system names
# https://stackoverflow.com/questions/59657293/how-to-check-number-of-arguments-in-powershell
[CmdLetbinding()]
param(
    [Parameter()]
    [String]$num
)
if ($PSBoundParameters.Count -eq 1) {
Write-Host "The team number you entered is $num"
# $boxes="team$num-lb","team$num-ws1","team$num-ws2","team$num-ws3","team$num-db"
$directories='lb','ws1','ws2','ws3','db'
######################################################################################
# Logic to remove the previous iteration of the project - you only have one version
# on your system at one time
######################################################################################
# Setting initial directory location
Write-Host "Setting initial directory location: "
Set-Location -Path ../project

foreach ($directory in $directories)
{
  Write-Host "Entering directory: $directory"
  Set-Location -Path $directory
  # Enter each directory and halt each machine
  Write-Host "Halting $directory"
  vagrant halt -f
  # Issuing the vagrant box destroy command to remove any delta files
  Write-Host "Destroying vagrant box $directory"
  vagrant destroy -f $directory
  # Removing the previously registered vagrant boxes from the system
  Write-Host "Removing vagrant box $directory"
  vagrant box remove -f $directory
  # Removing meta file directory created when vagrant up was last run
  Write-Host "Removing .vagrant directory"
  Remove-Item ./.vagrant -Verbose -Recurse
  Write-Host "Finished removing all previous Vagrant elements of your application"
  # Resetting location up one levels
  Set-Location -Path ../
}
 
######################################################################################
# Logic to retrieve the vagrant *.box files for your application from the build-server
# bring them to your local system and issue the vagrant box add command
######################################################################################
foreach ($directory in $directories)
{
    # Running the command to add the vagrant boxes, you can put a URL and Vagrant 
    # will retrieve the box for you in addition to adding the box
    Write-Host "Vagrant is retrieving and adding the box: team$num-$directory.box"
    vagrant box add http://192.168.172.44/boxes/team$num-$directory.box --name $directory
}
# Show all the Vagrant boxes added properly
vagrant box list 
Write-Host "All finished!"
# Reseting path to the default start location
Set-Location -Path ../powershell
} # end of if
else {
  Write-Host "To run the script you need to type: ./remove-and-retrieve-and-add-vagrant-boxes.ps1 XX -- where XX is your team number, with leading zero"
}
