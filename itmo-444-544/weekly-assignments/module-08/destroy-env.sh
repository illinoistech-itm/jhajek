#!/bin/bash

# Code for looping though bucket names, finding any objects and deleting them

MYS3BUCKETS=$(aws s3api list-buckets --query "Buckets[*].Name")
MYS3BUCKETS_ARRAY=($MYS3BUCKETS)

for j in "${MYS3BUCKETS_ARRAY[@]}"
do
MYKEYS=$(aws s3api list-objects --bucket $j --query 'Contents[*].Key')
MYKEYS_ARRAY=($MYKEYS)
for k in "${MYKEYS_ARRAY[@]}"
do
aws s3api delete-object --bucket $j --key $k --no-cli-pager
aws s3api wait object-not-exists --bucket $j --key $k --no-cli-pager
done
done
echo "S3 Bucket Keys deleted"

for l in "${MYS3BUCKETS_ARRAY[@]}"
do
aws s3api delete-bucket --bucket $l --region us-east-1 --no-cli-pager
aws s3api wait bucket-not-exists --bucket $l --no-cli-pager
done
echo "S3 Bucket deleted"
