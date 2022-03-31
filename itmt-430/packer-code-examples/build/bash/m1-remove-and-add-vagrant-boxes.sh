#!/bin/bash

######################################################################################
# This Bash script will retrieve your team's Vagrant Boxes from the build-server
# http://192.168.172.44/boxes
# As each team is numbered this will allow you to retrieve and to issue the 
# vagrant box add command at the same time.
######################################################################################

# Change XX to your team number with leading Zero
# Create an array of system names
# $boxes="team$num-lb","team$num-ws1","team$num-ws2","team$num-ws3","team$num-db"
DIRECTORIES=( lb ws1 ws2 ws3 db )
######################################################################################
# Logic to remove the previous iteration of the project - you only have one version
# on your system at one time
######################################################################################
# Setting initial directory location
echo "Setting initial directory location: "
cd ../project

for DIRECTORY in ${DIRECTORIES[@]}
do
  echo "Entering directory: $DIRECTORY"
  cd $DIRECTORY
  # Enter each directory and halt each machine
  echo "Halting $DIRECTORY"
  vagrant halt -f
  # Issuing the vagrant box destroy command to remove any delta files
  echo "Destroying vagrant box: $DIRECTORY"
  vagrant destroy -f
  # Removing the previously registered vagrant boxes from the system
  echo "Removing vagrant box $DIRECTORY"
  vagrant box remove -f $DIRECTORY
  # Removing meta file directory created when vagrant up was last run
  echo "Removing .vagrant directory"
  rm -rf ./.vagrant
  echo "Finished removing all previous Vagrant elements of your application"
  # Resetting location up one level
  cd ../
done
 
######################################################################################
# Logic to cd to the local build directory on your M1 mac -- where the Parallel Boxes
# are located
######################################################################################
cd ../packer-build-templates/build


for DIRECTORY in ${DIRECTORIES[@]}
do
    # Running the command to add the vagrant boxes, you can put a URL and Vagrant 
    # will retrieve the box for you in addition to adding the box
    echo "Vagrant is adding the box: $DIRECTORY-arm.box"
    vagrant box add --provider parallels $DIRECTORY-arm.box --name $DIRECTORY
done
# Show all the Vagrant boxes added properly
vagrant box list 
echo "All finished!"
# Return to bash directory
cd ../../bash
