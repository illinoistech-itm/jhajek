<?php

require '/home/vagrant/vendor/autoload.php';

use Aws\DynamoDb\DynamoDbClient;

$client = new DynamoDbClient([
    'profile' => 'default',
    'region'  => 'us-east-1',
    'version' => 'latest'
]);

# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-dynamodb-2012-08-10.html#putitem
# PHP UUID generator for Receipt- https://www.php.net/manual/en/function.uniqid.php

$receipt = uniqid(); 
echo $receipt;

$result = $client->putItem([
'TableName' => "RecordsXYZ", // REQUIRED
'Item' => [ // REQUIRED
    'Receipt' => ['S' => $receipt],
    'Email' => ['S' => "hajek@iit.edu"],
    'Phone' => ['S' => "16306389708"],
    'Filename' => ['S' => substr(md5(rand()), 0, 7)],
    'S3rawurl' => ['S' => "S3://..."],
    'S3finishedurl' => ['S' => ''],     
    'Status' => ['B' => False],
    'Issubscribed' => ['B' => FALSE]     
    ]
   
    ]);

    


printr($result);

?>
