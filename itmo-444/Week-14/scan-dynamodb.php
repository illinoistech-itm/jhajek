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
        '#S3R' => 'S3finishedurl',
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
print_r($result);

# retrieve the number of elements being returned -- use this to control the for loop
$len = $result['Count'];
echo "Len: " . $len . "\n";
print_r($result['Items'][0]['S3rawurl']['S']);
echo "\n";
print_r($result['Items'][0]['S3finishedurl']['S']);
echo "\n";
# for loop to iterate through all the elements of the returned matches
for ($i=0; $i < $len; $i++) {
    echo "\n";
    print_r($result['Items'][$i]['S3rawurl']['S']);
    echo "\n";
    print_r($result['Items'][$i]['S3finishedurl']['S']);
}
