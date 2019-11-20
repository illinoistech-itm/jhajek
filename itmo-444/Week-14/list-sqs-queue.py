import boto3

# https://boto3.amazonaws.com/v1/documentation/api/latest/guide/sqs.html
# Get the service resource
sqs = boto3.resource('sqs')

# Get the queue. This returns an SQS.Queue instance
queue = sqs.get_queue_by_name(QueueName='inclass-jrh')

# You can now access identifiers and attributes
print(queue.url)

# Print out each queue name, which is part of its ARN
for queue in sqs.queues.all():
    print(queue.url)