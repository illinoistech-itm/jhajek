# This Python program will make use of the python3 AWS SDK
# https://aws.amazon.com/sdk-for-python/
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/index.html

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/s3.html#S3.Client.list_buckets
import boto3

client = boto3.client('s3')

response = client.list_buckets()

# You will check 3 things
# Query for your SQS queue name
# check to see if any new queue messages have been placed on the queue
# consume the message and change the message's visibility to invisible

sqsclient = boto3.client('sqs')

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/sqs.html#SQS.Client.list_queues
# List queues

sqsresponse = sqsclient.list_queues()

# To retreive the URL of the queue you would access the sqsresponse object -- it is of type Python Dictionary
print (sqsresponse)
print (sqsresponse["QueueUrls"])
SQSURL=(sqsresponse["QueueUrls"])

# this code will check for a message
sqsresponse = client.receive_message(
    QueueUrl=SQSURL,
    VisibilityTimeout=120,
)


# Based on the UUID placed into the body of the SQS message, issue a database SQL query to select all data contained in that record

# Retrieve the image from the RAW S3 bucket
# Run the image through a python library called Pillow (image manipulation program)
# Store the modified image in the FIN S3 bucket

# Update the Mysql record to have the URL to the finished object

