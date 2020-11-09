import boto3
sqs = boto3.resource('sqs')

# https://boto3.amazonaws.com/v1/documentation/api/latest/guide/sqs.html#processing-messages
# Get the queue
queue = sqs.get_queue_by_name(QueueName='test')

# Process messages by printing out body and optional author name
for message in queue.receive_messages(MessageAttributeNames=['Author']):
    # Get the custom author message attribute if it was set
    author_text = ''
    if message.message_attributes is not None:
        author_name = message.message_attributes.get('Author').get('StringValue')
        if author_name:
            author_text = ' ({0})'.format(author_name)

    # Print out the body and author (if set)
    print('Hello, {0}!{1}'.format(message.body, author_text))

### Connect to Mysql Database and retrieve record relating to the SQS job
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/rds.html
#  SELECT * FROM jobs WHERE id = message.body;

# Retreive image from the S3 bucket

# Process image with PIL 

# Put Image Object back into S3 Bucket

 # SQL UPDATE record where id == message.body  set Stat from 0 to 1

# Let the queue know that the message is processed
message.delete()