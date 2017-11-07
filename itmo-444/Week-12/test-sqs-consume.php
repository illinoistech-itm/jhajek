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
#print_r ($receivemessageresult['Messages'])
$receiptHandle = $receivemessageresult['Messages'][0]['ReceiptHandle'];
$uuid = $receivemessageresult['Messages'][0]['Body'] . "\n";
echo "The content of the message is: " . $receivemessageresult['Messages'][0]['Body'] . "\n";

# Now in your data base do a select * from records where uuid=$uuid;
# What will this give you?  S3 URL for the raw bucket

# Include your S3 code to retreive the object from the S3URL -- save file local in a tmp file name

# Pass this image into your image manipulation function  

# upon completion put the finished image into the S3 bucket for finsihed images

# Update your Database record using the UPDATE and the $uuid as the search term  
#  * Add S3 finsihed URL 
#  * change status from 0 to 1 (done)

# SNS would then xend your user a text with the finsihed URL 

?>