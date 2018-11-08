<?php

require 'vendor/autoload.php';
//http://docs.aws.amazon.com/aws-sdk-php/guide/latest/service-sns.html
use Aws\Sns\SnsClient;

$client = SnsClient::factory(array(
    'region'  => 'us-east-1'
));

$result = $client->listTopics(array(
//    'NextToken' => 'string',
));


echo $result['Topics'];

foreach ($result->getPath('Topics/*/TopicArn') as $ep) {
    // Do something with the message
    echo "============". $ep . "================";
}





?>
