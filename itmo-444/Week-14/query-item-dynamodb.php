<?php
# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-dynamodb-2012-08-10.html#query
# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-dynamodb-2012-08-10.html#query-example-1

require '/home/vagrant/vendor/autoload.php';

use Aws\DynamoDb\DynamoDbClient;

$client = new DynamoDbClient([
    'profile' => 'default',
    'region'  => 'us-east-1',
    'version' => 'latest'
]);

# remove ProjectionExpression line to return all values
$result = $client->query([
    'ExpressionAttributeValues' => [
        ':v1' => ['S' => 'hajek@iit.edu'],
        ':v2' => ['S' => '5dd4d65c2099f']
    ],
    'KeyConditionExpression' => 'Receipt = :v2 AND Email = :v1',
    'ProjectionExpression' => 'S3finishedurl', 'S3rawurl',
    'TableName' => 'RecordsXYZ',
]);

print_r($result);

# parse the results to get the URLs of the finished and raw S3 URL
print_r($result['Items'][0]['S3rawurl']['S']);
print_r($result['Items'][0]['S3finishedurl']['S']);

/*
# Result syntax:
[
    'ConsumedCapacity' => [
    ],
    'Count' => 2,
    'Items' => [
        [
            'SongTitle' => [
                'S' => 'Call Me Today',
            ],
        ],
    ],
    'ScannedCount' => 2,
]

*/

?>