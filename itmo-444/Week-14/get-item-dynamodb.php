<?php
# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-dynamodb-2012-08-10.html#getitem
# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-dynamodb-2012-08-10.html#getitem-example-1

require '/home/vagrant/vendor/autoload.php';

use Aws\DynamoDb\DynamoDbClient;

$client = new DynamoDbClient([
    'profile' => 'default',
    'region'  => 'us-east-1',
    'version' => 'latest'
]);

$result = $client->getItem([
    'TableName' => 'RecordsXYZ',
    'Key' => [
                    'Receipt' => ['S' => '5dd3195b3bb72'],
                    'Email' => ['S' => 'hajek@iit.edu'],
            ],
]);

print_r($result);

echo $result['Item'];

/* ProjectionExpression - A string that identifies one or more attributes to retrieve from the table. 
These attributes can include scalars, sets, or elements of a JSON document. The attributes in the expression must
 be separated by commas. If no attribute names are specified, then all attributes are returned. 
 If any of the requested attributes are not found, they do not appear in the result. 
*/

/*
# Return Object
[
    'Item' => [
        'AlbumTitle' => [
            'S' => 'Songs About Life',
        ],
        'Artist' => [
            'S' => 'Acme Band',
        ],
        'SongTitle' => [
            'S' => 'Happy Day',
        ],
    ],
]

*/
?>  

