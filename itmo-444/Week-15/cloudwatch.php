<?php

require 'vendor/autoload.php';

 echo "hello world!\n";

$cw = new Aws\CloudWatch\CloudWatchClient([
    'version' => 'latest',
    'region'  => 'us-east-2'
]);

$cwresult = $cw->getMetricStatistics([
  'Dimensions' => [
      [
        'Name' => 'InstanceId',
        'Value' => 'i-0f8ca7a39ae1815eb'
      ],
    ],
    'EndTime' => strtotime('now'), // REQUIRED
    'MetricName' => 'CPUUtilization', // REQUIRED
    'Namespace' => 'AWS/EC2', // REQUIRED
    'Period' => 300, // REQUIRED
    'StartTime' => strtotime('-5 minutes'), // REQUIRED
   // 'Statistics' => ['<string>', ...],
   // 'Unit' => '

]);

print_r($cwresult);

?>