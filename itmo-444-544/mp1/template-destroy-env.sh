#/bin/bash


# Sample code to retrieve objects (file) names
# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/list-objects-v2.html
aws s3api list-objects-v2 --bucket jrh-itmo-raw --query 'Contents[*].Key'
FILENAME=$(aws s3api list-objects-v2 --bucket jrh-itmo-raw --query 'Contents[*].Key')

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/delete-object.html
aws s3api delete-object --bucket jrh-itmo-raw --key $FILENAME

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/delete-bucket.html
aws s3api delete-bucket --buket jrh-itmo-raw


##################################################################################
# Sample code to iterate through all your buckets and delete any objects they contain
# Then delete your buckets -- warning will delete everything in your S3 account
#####################################################################################
# Get a list of S3 buckets in your account
BUCKETLIST=$(aws s3api list-buckets --query 'Buckets[*].Name')
# Convert the list to an Array
BUCKETLISTARRAY=($BUCKETLIST)
# Create two embedded for each loops to iterate through the buckets deleting and content
for BUCKET in ${BUCKETLISTARRAY[@]};
  do
    OBJECTLIST=$(aws s3api list-objects-v2 --bucket $BUCKET
    OBJECTLISTARRAY=($OBJECTLIST)
    for OBJECT in ${OBJECTLISTARRAY[@]};
      do
        echo "Objects in bucket: $OBJECT"
        aws s3api delete-object --bucket $BUCKET --key $OBJECT
      done
    aws s3api delete-bucket --bucket $BUCKET
  done