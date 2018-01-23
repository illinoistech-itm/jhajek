#!/bin/bash

##################################################
# Script to combine a decade at a times txt files
##################################################

for i in {$1..$2}
  do
     cat $i/$i.txt >> $3.txt
  done    