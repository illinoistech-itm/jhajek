<?php

require 'vendor/autoload.php';

 echo "hello world!\n";

$cw = new Aws\CloudWatch\CloudWatchClient([
    'version' => 'latest',
    'region'  => 'us-east-2'
]);

?>