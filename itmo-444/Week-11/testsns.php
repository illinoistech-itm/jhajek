<?php
require 'vendor/autoload.php';

 echo "hello world!\n";

$sqs = new Aws\Sns\SnsClient([
    'version' => 'latest',
    'region'  => 'us-east-2'
]);


$result = $sqs->listTopics([
    
]);
print_r ( $result['Topics']);
$topicarn = $result['Topics'][0]['TopicArn'];

echo "Your Topic ARN: " . $topicarn . "\n";

$subscriberesult = $sqs->subscribe([
    'Endpoint' => 'hajek@iit.edu',
    'Protocol' => 'email', // REQUIRED
    'TopicArn' => $topicarn, // REQUIRED
]);

//List S3 buckets
$s3 = new Aws\S3\S3Client([
    'version' => 'latest',
    'region'  => 'us-west-2'
]);

$listbucketresult = $s3->listBuckets([
    ]);

echo "\n" . $listbucketresult['Buckets'];


// Publsih a message
$publishresult = $sqs->publish([
    'Message' => 'Hello World -- its a bit rainy', // REQUIRED
    'Subject' => 'Contact from ITMO-5444',
    'TopicArn' => $topicarn
]);




?>
