<?php

# https://docs.aws.amazon.com/aws-sdk-php/v3/api/class-Aws.Sns.SnsClient.html
require '/home/vagrant/vendor/autoload.php';

use Aws\Sns\SnsClient;

$client = new SnsClient([
    'profile' => 'default',
    'region'  => 'us-east-1',
    'version' => 'latest'
]);

# list topic ARN

# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-sns-2010-03-31.html#subscribe
$result = $client->subscribe([
    'Endpoint' => '16306389708',  // this number is taken from the form on index.php POST action
    'Protocol' => sms, // REQUIRED
    'ReturnSubscriptionArn' => true || false,
    'TopicArn' => '<string>', // REQUIRED
]);


# https://docs.aws.amazon.com/aws-sdk-php/v3/api/api-sns-2010-03-31.html#confirmsubscription
$result = $client->confirmSubscription([
    'AuthenticateOnUnsubscribe' => '<string>',
    'Token' => '<string>', // REQUIRED  sent during subscribe
    'TopicArn' => '<string>', // REQUIRED
]);


?>