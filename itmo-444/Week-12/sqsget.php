<?php
/*
 * Copyright 2013. Amazon Web Services, Inc. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
**/

// Include the SDK using the Composer autoloader
require 'vendor/autoload.php';

use Aws\Sqs\SqsClient;

/*
 If you instantiate a new client for Amazon Simple Storage Service (S3) with
 no parameters or configuration, the AWS SDK for PHP will look for access keys
 in the AWS_ACCESS_KEY_ID and AWS_SECRET_KEY environment variables.

 For more information about this interface to Amazon S3, see:
 http://docs.aws.amazon.com/aws-sdk-php-2/guide/latest/service-s3.html#creating-a-client
*/
$client = SqsClient::factory(array(
'region'  => 'us-east-1'
));


$result = $client->receiveMessage(array(
    // QueueUrl is required
    'QueueUrl' => 'https://sqs.us-east-1.amazonaws.com/602645817172/itmo544jobqueue',
    'MaxNumberOfMessages' => 1,
    'VisibilityTimeout' => 30,
//    'WaitTimeSeconds' => 60,
));
$SqsURL = "https://sqs.us-east-1.amazonaws.com/602645817172/itmo544jobqueue";
$messageBody = "";
$receiptHandle = "";

foreach ($result->getPath('Messages/*/Body') as $messageBody) {
    // Do something with the message
    echo $messageBody ."\n";
}

foreach ($result->getPath('Messages/*/ReceiptHandle') as $receiptHandle) {
    // Do something with the message
    echo $receiptHandle ."\n";
}

$result = $client->deleteMessage(array(
    // QueueUrl is required
    'QueueUrl' => $SqsURL,
    // ReceiptHandle is required
    'ReceiptHandle' => $receiptHandle,
));

echo "Message has been deleted!";
?>





















