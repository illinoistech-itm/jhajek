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

# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-sqs-2012-11-05.html#sendmessage

$resultsqs = $client->sendMessage([
    'MessageBody' => uniqid(), // put UUID or receipt value here for look up. 
    'QueueUrl' => $queueURL, // REQUIRED
]);

print_r($resultsqs);