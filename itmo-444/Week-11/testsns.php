<?php
require 'vendor/autoload.php';

 echo "hello world!\n";

$sqs = new Aws\Sns\SnsClient([
    'version' => 'lates,
    'region'  => 'us-east-1'
]);


$result = $sqs->listTopics([
    
]);

print_r ( $result['Topics']);
?>
