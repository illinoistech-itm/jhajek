<?php
# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-dynamodb-2012-08-10.html#updateitem
# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-dynamodb-2012-08-10.html#updateitem-example-1

require '/home/vagrant/vendor/autoload.php';

use Aws\DynamoDb\DynamoDbClient;

$client = new DynamoDbClient([
    'profile' => 'default',
    'region'  => 'us-east-1',
    'version' => 'latest'
]);

$result = $client->updateItem([
    'TableName' => 'RecordsXYZ',
    'Key' => [
        'Receipt' => ['S' => $receipt],
        'Email' => ['S' => "hajek@iit.edu"]
    ],
    'Update' => [
        'ExpressionAttributeNames' => [
            '#URL' => "S3finishedurl", 
            '#S' => "Status",
            '#SUB' => "Issubscribed"
        ],
        'ExpressionAttributeValues' => [
            ':u' => "S3finishedurl" => ['S' =>  "New-URL"],
            ':s' => "Status" => ["BOOL" => true],
            ':i' => 'Issubscribed' => ["BOOL" => true]

        ],   
    'ReturnValues' => 'ALL_NEW',
    'UpdateExpression' => "SET #S = :u, SET #SUB = :i, SET #S = :s" 
    ]);

      

?>