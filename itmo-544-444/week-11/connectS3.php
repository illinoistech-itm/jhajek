<?php

require '/home/ubuntu/vendor/autoload.php';

use Aws\S3\S3Client;

$s3 = new Aws\S3\S3Client([
    'profile' => 'default',
    'version' => 'latest',
    'region' => 'us-east-2'
]);

//https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-s3-2006-03-01.html

$result = $s3->listBuckets([
]);

echo $result;
?>