<?php
require 'vendor/autoload.php';

 echo "hello world!\n";

$sqs = new Aws\Sqs\SqsClient([
    'version' => 'latest',
    'region'  => 'us-east-2'
]);

#list the SQS Queue URL
$listQueueresult = $sqs->listQueues([
    
]);
# print out every thing
# print_r ($listQueueresult);  

echo "Your SQS URL is: " . $listQueueresult['QueueUrls'][0] . "\n";
$queueurl = $listQueueresult['QueueUrls'][0];


$receivemessageresult = $sqs->receiveMessage([
    'MaxNumberOfMessages' => 1,
    'QueueUrl' => $queueurl, // REQUIRED
    'VisibilityTimeout' => 60,
    'WaitTimeSeconds' => 5,
]);

# print out content of SQS message - we need to retreive Body and Receipt Handle
print_r ($receivemessageresult['Messages'])

?>