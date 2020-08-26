<?php

// Include the SDK using the Composer autoloader
require 'vendor/autoload.php';

use Aws\Sns\SnsClient;

/*
 If you instantiate a new client for Amazon Simple Storage Service (S3) with
 no parameters or configuration, the AWS SDK for PHP will look for access keys
 in the AWS_ACCESS_KEY_ID and AWS_SECRET_KEY environment variables.

 For more information about this interface to Amazon S3, see:
 http://docs.aws.amazon.com/aws-sdk-php-2/guide/latest/service-s3.html#creating-a-client
*/
$client = SnsClient::factory(array(
'region'  => 'us-east-1'
));

$result = $client->publish(array(
    'TopicArn' => 'arn:aws:sns:us-east-1:602645817172:itmo544jrh',
    //'TargetArn' => 'string',
    // Message is required
    'Message' => 'Success!',
    'Subject' => 'itmo544jrh',
    'MessageStructure' => 'string',
   /* 'MessageAttributes' => array(
        // Associative array of custom 'String' key names
        'String' => array(
            // DataType is required
            'DataType' => 'string',
            'StringValue' => 'string',
            'BinaryValue' => 'string',
        ),
        // ... repeated
    ), */
));

echo "topic published!";

?>
