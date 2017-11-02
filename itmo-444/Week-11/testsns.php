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

echo "Your Topic ARN: " . $topicarn;

?>
