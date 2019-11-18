<?php
# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-dynamodb-2012-08-10.html#batchgetitem-example-1

require '/home/vagrant/vendor/autoload.php';

use Aws\DynamoDb\DynamoDbClient;

$client = new DynamoDbClient([
    'profile' => 'default',
    'region'  => 'us-east-1',
    'version' => 'latest'
]);

$result = $client->batchGetItem([
    'RequestItems' => [
        'RecordsXYZ' => [
            'Keys' => [
                [
                    'Receipt' => [
                        'S' => $receipt,
                    ],
                    'Email' => [
                        'S' => 'hajek@iit.edu',
                    ],
                ],
            ],
            'ProjectionExpression' => 'S3rawurl', 'S3finishedurl',
        ],
    ],
]);



?>  

