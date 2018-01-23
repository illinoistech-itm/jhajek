#!/bin/bash

##################################################
# Script to combine a decade at a times txt files
##################################################

for i in {1990..1999}
  do
     cat $i/$i.txt >> $1.txt
  done    
  echo "Making decade directory"
  hadoop fs -mkdir -p /user/$USER/ncdc/$1/
  echo "Making gzip file"
  gzip -kv $1.txt
  echo "putting to Hadoop Cluster"
  hadoop fs -copyFromLocal ./$1.txt.gz /user/$USER/ncdc/$1/
  rm $i.txt.gz
  echo "Making bzip2 file"
  bzip2 -zkv $1.txt
  echo "putting to Hadoop Cluster"
  hadoop fs -copyFromLocal ./$1.txt.gz /user/$USER/ncdc/$1/
  rm $i.txt.bz