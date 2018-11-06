<?php

require '/home/ubuntu/vendor/autoload.php';

use Aws\Rds\RdsClient;

$rds = new Aws\Rds\RdsClient([
     'version' => 'latest',
     'region' => 'us-west-2'
 ]);

//https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-rds-2014-10-31.html#describedbinstances
$result = $rds->describeDBInstances([
    'DBInstanceIdentifier' => 'jrh-inclass'
]);

echo "Here is the Address: ". "\n";
echo $result['DBInstances'][0]['Endpoint']['Address'];
