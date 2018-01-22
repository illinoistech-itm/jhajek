#!/bin/bash

##################################################################
#  This code will take the raw NCDC data which is stored in small gzipped files
#  It will extract it and combine it into a single txt file, gzip it and upload to Hadoop, then bzip it and upload to hadoop
#  
####################################################################


for i in {1949..1999}
do

    for file in ./$i/* ; do gunzip -c $file >> ./$i/$i.txt ; done
    echo "Finished creating combined file of $i"
    hadoop fs -mkdir /user/$USER/ncdc/$i
    hadoop fs -copyFromLocal ./$i/$i.txt /user/$USER/ncdc/$i
    gzip -ckv $i/$i.txt | hadoop fs -put - /user/$USER/ncdc/$i/
    bzip2 -zkv $i/$i.txt | hadoop fs -put - /user/$USER/ncdc/$i/

done