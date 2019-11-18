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
                    'Receipt' => ['S' => $receipt],
                    'Email' => ['S' => 'hajek@iit.edu'],
                ],
            ],
            'ProjectionExpression' => 'S3rawurl', 'S3finishedurl'
        ],
    ],
]);

print_r($result);

/* ProjectionExpression - A string that identifies one or more attributes to retrieve from the table. 
These attributes can include scalars, sets, or elements of a JSON document. The attributes in the expression must
 be separated by commas. If no attribute names are specified, then all attributes are returned. 
 If any of the requested attributes are not found, they do not appear in the result. 
*/
?>  

