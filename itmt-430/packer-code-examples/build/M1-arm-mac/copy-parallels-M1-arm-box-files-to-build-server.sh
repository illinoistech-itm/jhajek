#!/bin/bash

#####################################################################################################
# This script is for automating the placing of vagrant boxes built for Parallels using the M1 mac
#####################################################################################################
if [ $# -eq 2 ]
then
num=$1
HAWKID=$2
echo "The team number you entered is $num"
echo "The Hawk ID you entered is $HAWKID"
# Names of the boxes
DIRECTORIES=( lb ws1 ws2 ws3 db )

for DIRECTORY in ${DIRECTORIES[@]}
do
    if [ -e ./team$num-$DIRECTORY-arm.box ]
    then
      echo "Copying vagrant box: ../team$num-$DIRECTORY-arm.box to remote build server..."
      scp -i ~/.ssh/id_ed25519_$HAWKID_key ../team$num-$DIRECTORY-arm.box $HAWKID@192.168.172.44:/datadisk2/boxes/
      echo "Vagrant Box copied."
    else
      echo "Box ./team$num-$DIRECTORY-arm.box does not exist, perhaps you are in the wrong directory (../build)?"
    fi
done

else
  echo "To run the script you need to type: ./copy-parallels-M1-arm-box-files-to-build-server.sh XX HAWKID -- where XX is your team number, with leading zero and HAWKID is your hawk id, in lowercase.  And this assumes your private key is named: id_ed25519_$HAWKID_key"
fi  

