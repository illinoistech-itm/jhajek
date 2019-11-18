<?php
# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-dynamodb-2012-08-10.html#putitem-example-1

require '/home/vagrant/vendor/autoload.php';

use Aws\DynamoDb\DynamoDbClient;

$client = new DynamoDbClient([
    'profile' => 'default',
    'region'  => 'us-east-1',
    'version' => 'latest'
]);


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
