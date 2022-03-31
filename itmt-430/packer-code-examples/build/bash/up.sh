#########################################################################################
# This script will start all of the Vagrant boxes you have initialized via the
# vagrant up command
#########################################################################################
# Declare and array of all the box names
DIRECTORIES=( lb ws1 ws2 ws3 db )
# Setting initial directory location
echo "Setting initial directory location: "
if [ $(uname -m) == "arm64" ]
then 
cd ../m1-project
else
cd ../project
fi

for DIRECTORY in ${DIRECTORIES[@]}
do
    echo "Entering directory: $DIRECTORY"
    cd $DIRECTORY
    # Start each virtual machine
    echo "Starting vagrant box: $DIRECTORY"
    vagrant up
    echo "Finished starting all Vagrant Boxes for your application"
    # Resetting location up one levels
    cd ../
done
# Return to bash directory
cd ../bash