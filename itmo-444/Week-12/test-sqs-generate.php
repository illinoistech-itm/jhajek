<?php
require 'vendor/autoload.php';

 echo "hello world!\n";

$sqs = new Aws\Sqs\SqsClient([
    'version' => 'latest',
    'region'  => 'us-east-2'
]);

$listQueueresult = $sqs->listQueues([
    
]);

print_r ($listQueueresult);  

?>
