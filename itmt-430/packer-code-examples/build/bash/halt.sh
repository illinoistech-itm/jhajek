#########################################################################################
# This script will poweroff or halt all of the Vagrant boxes you have initialized via the
# vagrant halt command
#########################################################################################
# Declare and array of all the box names
DIRECTORIES=( lb ws1 ws2 ws3 db )
# Setting initial directory location
echo "Setting initial directory location: "
cd ../project

for DIRECTORY in ${DIRECTORIES[@]}
do
    echo "Entering directory: $DIRECTORY"
    cd $DIRECTORY
    # Start each virtual machine
    echo "Starting vagrant box: $DIRECTORY"
    vagrant halt
    echo "Finished removing all previous Vagrant elements of your application"
    # Resetting location up one levels
    cd ../
done
