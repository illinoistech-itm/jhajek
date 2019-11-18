<?php
# https://stackoverflow.com/questions/25806267/need-a-complete-example-for-dynamodb-with-php

require '/home/vagrant/vendor/autoload.php';

use Aws\DynamoDb\DynamoDbClient;

$client = new DynamoDbClient([
    'profile' => 'default',
    'region'  => 'us-east-1',
    'version' => 'latest'
]);

$response = $client->putItem(array(
    'TableName' => '[Table_Name]', 
    'Item' => array(
        '[Hash_Name]'   => array('S' => '[Hash_Value]'),
        '[Range_Name]'  => array('S' => '[Range_Value]')
    )
));

//Echoing the response is only good to check if it was successful. Status: 200 = Success
echo $response;

# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-dynamodb-2012-08-10.html#putitem
# PHP UUID generator for Receipt- https://www.php.net/manual/en/function.uniqid.php

$recipt = uniqid(); 
echo $receipt;

$result = $client->putItem([
'Item' => [ // REQUIRED
    'Receipt' => ['S' => $receipt],
    'Email' => ['S' => $_POST['email'],
    'Phone' => ['S'] => $_POST['phone'],
    'Filename' => ['S' => $uploadfile],
    'S3rawurl' => ['S' => $url],
    'S3finishedurl' => ['S' => ''],     
    'Status' => ['B' => False],
    'Issubscribed' => ['B' => FALSE]     
    ],
    'TableName' => 'RecordsXYZ', // REQUIRED
    ]);

printr($result);

?>
