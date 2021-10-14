#!/bin/bash

for system in $@;
do
        echo $system
        sleep 25
        cd $system
        `vagrant up`
        cd ../
done