import boto3
sqs = boto3.resource('sqs',region_name='us-east-1')

# https://boto3.amazonaws.com/v1/documentation/api/latest/guide/sqs.html#processing-messages
# Get the queue
queue = sqs.get_queue_by_name(QueueName='jrh-sqs-itmo-544')

# Process messages by printing out body and optional author name
for message in queue.receive_messages():
  # Print out the body and author (if set)
  print(message.body)                 

### Connect to Mysql Database and retrieve record relating to the SQS job
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/rds.html
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/rds.html#RDS.Client.describe_db_instances
# https://dev.mysql.com/doc/connector-python/en/    
#  SELECT * FROM jobs WHERE id = message.body;

# Retreive image from the S3 bucket

# Process image with PIL 

# Put Image Object back into S3 Bucket

 # SQL UPDATE record where id == message.body  set Stat from 0 to 1

# Let the queue know that the message is processed
message.delete()