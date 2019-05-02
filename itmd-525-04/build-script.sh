#!/bin/bash

#mkdir xenial64-{1..4}
vagrant plugin install vagrant-vbguest
d xenial64-1
vagrant up
cd ../xenial64-2
vagrant up
cd ../xenial64-3
vagrant up
cd ../xenial64-4
if [ ! -f /xenial64-4/data ]
then
mkdir ./data
echo "Making data directory in ./xenial64-4"
fi
vagrant up
cd ../

