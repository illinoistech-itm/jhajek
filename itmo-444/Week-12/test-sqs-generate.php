<?php
require 'vendor/autoload.php';

 echo "hello world!\n";

$sqs = new Aws\Sqs\SqsClient([
    'version' => 'latest',
    'region'  => 'us-east-2'
]);

$listQueueresult = $sqs->listQueues([
    
]);
# print out every thing
# print_r ($listQueueresult);  

echo "Your SQS URL is: " . $listQueueresult[QueueUrls][0] . "\n";

?>
