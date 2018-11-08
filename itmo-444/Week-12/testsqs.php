<?php

require 'vendor/autoload.php';
//http://docs.aws.amazon.com/aws-sdk-php/guide/latest/service-sqs.html
use Aws\Sqs\SqsClient;

$client = SqsClient::factory(array(
    'region'  => 'us-east-1'
));


$result = $client->getQueueUrl(array(
    // QueueName is required
    'QueueName' => 'itmo544jrhsqs',
  //  'QueueOwnerAWSAccountId' => '',
));

echo $result['QueueUrl'];
/*
$client->sendMessage(array(
    'QueueUrl'    => $queueUrl,
    'MessageBody' => 'An awesome message!',
));
*/
?>
