<?php
//conection: 

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
$rdsIP = $result['DBInstances'][0]['Endpoint']['Address'];
echo $rdsIP;

echo "Hello world"; 
$link = mysqli_connect($rdsIP,"controller","ilovebunnies") or die("Error " . mysqli_error($link)); 

echo "Here is the result: " . $link;


$sql = "CREATE TABLE comments 
(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
PosterName VARCHAR(32),
Title VARCHAR(32),
Content VARCHAR(500)
)";

$con->query($sql);


?>
