<?php
# https://stackoverflow.com/questions/25806267/need-a-complete-example-for-dynamodb-with-php

require '/home/vagrant/vendor/autoload.php';

require 'aws/aws-autoloader.php';

use Aws\DynamoDb\DynamoDbClient;

$client = new DynamoDbClient([
    'profile' => 'default',
    'region'  => 'us-east-1',
    'version' => 'latest'
]);

$result = $client->describeTable(array(
    'TableName' => 'RecordsXYZ'
));

echo $result;

?>
