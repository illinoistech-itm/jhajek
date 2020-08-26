<?php
require '/home/ubuntu/vendor/autoload.php';

use Aws\S3\S3Client;  
use Aws\Exception\AwsException;

$s3Client = new S3Client([
    'profile' => 'default',
    'region' => 'us-west-2',
    'version' => '2006-03-01'
]);

//Listing all S3 Bucket
$buckets = $s3Client->listBuckets();
foreach ($buckets['Buckets'] as $bucket) {
    echo $bucket['Name'] . "\n";
}

?>