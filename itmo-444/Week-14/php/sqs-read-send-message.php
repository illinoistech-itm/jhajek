<?php

# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-sqs-2012-11-05.html#listqueues
# 
require '/home/vagrant/vendor/autoload.php';

use Aws\Sqs\SqsClient;

$client = new SqsClient([
    'profile' => 'default',
    'region'  => 'us-east-1',
    'version' => 'latest'
]);

$result = $client->listQueues([
    'QueueNamePrefix' => 'inclass-jrh',
]);

print_r($result['QueueUrls']);
$queueURL = $result['QueueUrls'][0];

# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-sqs-2012-11-05.html#getqueueurl
// or this is a valid approach too
$result = $client->getQueueUrl([
    'QueueName' => 'inclass-jrh', // REQUIRED
    //'QueueOwnerAWSAccountId' => '<string>',  // optional
]);

print_r($result['QueueURL']);
$URL = $result['QueueURL'];

# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-sqs-2012-11-05.html#sendmessage

$resultsqs = $client->sendMessage([
    'MessageBody' => uniqid(), // put UUID or receipt value here for look up. 
    'QueueUrl' => $queueURL, // REQUIRED
]);

print_r($resultsqs);

# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-sqs-2012-11-05.html#receivemessage
$result = $client->receiveMessage([
    'QueueUrl' => $URL, // REQUIRED
    'VisibilityTimeout' => 300,
    'WaitTimeSeconds' => 30,
]);

print_r($result['Messages']);
print_r($result['Messages'][0]['Body']);
print_r($result['Messages'][0]['MessageId']);
print_r($result['Messages'][0]['ReceiptHandle']);
$handle = $result['Messages'][0]['ReceiptHandle'];
# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-sqs-2012-11-05.html#deletemessage

$result = $client->deleteMessage([
    'QueueUrl' => $URL, // REQUIRED
    'ReceiptHandle' => $handle, // REQUIRED
]);

?>