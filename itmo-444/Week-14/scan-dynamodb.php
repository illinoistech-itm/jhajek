<?php
# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-dynamodb-2012-08-10.html#scan
# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-dynamodb-2012-08-10.html#scan-example-1

require '/home/vagrant/vendor/autoload.php';

use Aws\DynamoDb\DynamoDbClient;

$client = new DynamoDbClient([
    'profile' => 'default',
    'region'  => 'us-east-1',
    'version' => 'latest'
]);


$result = $client->scan([
    'ExpressionAttributeNames' => [
        '#S3R' => 'S3finsihedurl',
        '#S3F' => 'S3rawurl',
    ],
    'ExpressionAttributeValues' => [
        ':e' => [
            'S' => 'hajek@iit.edu',
        ],
    ],
    'FilterExpression' => 'Email = :e',
    'ProjectionExpression' => '#S3F, #S3R',
    'TableName' => 'RecordsXYZ',
]);

print_r($result['Items'][*]['S3rawurl']['S']);
echo "\n";
print_r($result['Items'][*]['S3finshedurl']['S']);

