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

### 
# you need some code to insert records into the database -- make sure you retrieve the UUID into a variable so you can pass it to the SQS message

$uuid = uniqid();
echo $uuid . '\n';

### send message to the SQS Queue
$sendmessageresult = $sqs->sendMessage([
    'DelaySeconds' => 30,
    'MessageBody' => $uuid, // REQUIRED
    'QueueUrl' => $queueurl // REQUIRED
]);

echo "The messageID is: ". $sendmessageresult['MessageId'] . "\n";

?>
