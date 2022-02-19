#!/bin/bash

################################################################################################
# This script is meant to be run on the build-server to delete your previous .box files 
# before you build new ones so that you don't get out of sync and only have 1 set of .box files
# always the latest
################################################################################################

if [ $# -eq 1 ]
then
num=$1
echo "The team number you entered is $num"
# Names of the boxes
DIRECTORIES=( lb ws1 ws2 ws3 db )

for DIRECTORY in ${DIRECTORIES[@]}
do
    echo "Deleting box /datadisk2/boxes/team$num-$DIRECTORY.box"
    rm -v /datadisk2/boxes/team$num-$DIRECTORY.box
    echo "Box deleted."
done

else
  echo "To run the script you need to type: ./remove-previous-box-files.sh XX -- where XX is your team number, with leading zero"
fi  