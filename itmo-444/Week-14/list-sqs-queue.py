# Get the service resource
sqs = boto3.resource('sqs')

# Get the queue. This returns an SQS.Queue instance
queue = sqs.get_queue_by_name(QueueName='inclass-jrh')

# You can now access identifiers and attributes
print(queue.url)