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

$result = $client->query([
    'ExpressionAttributeValues' => [
        ':v1' => ['S' => 'hajek@iit.edu'],
    ],
    'KeyConditionExpression' => 'Email = :v1',
    'ProjectionExpression' => 'S3finishedurl', 'S3rawurl'
    'TableName' => 'RecordsXYZ',
]);

print_r($result);

# parse the results to get the URLs of the finished and raw S3 URL
echo $result['Items']['S3rawurl'].[0];
echo $result['Items']['S3finishedurl'][1];

?>