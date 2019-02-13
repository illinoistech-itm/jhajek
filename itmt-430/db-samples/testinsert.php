<?php

echo "begin database";
$link = mysqli_connect("AWS URL *.us-east-1.rds.amazonaws.com","username","password","databasename") or die("Error " . mysqli_error($link));

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}


   # id INT NOT NULL AUTO_INCREMENT,
   # name VARCHAR(200) NOT NULL,
   # age INT NOT NULL,

/* Prepared statement, stage 1: prepare */
if (!($stmt = $link->prepare("INSERT INTO student (id, email,phone,filename,s3rawurl,s3finishedurl,status,issubscribed) VALUES (NULL,?,?,?,?,?,?,?)"))) {
    echo "Prepare failed: (" . $mysqli->errno . ") " . $mysqli->error;
}

$email = $_POST["useremail"];
$phone = $_POST["phone"];
$s3rawURL = $result['ObjectURL'];
$filename = basename($_FILES['username']['name']);
$s3finishedurl = "none";
$status =0;
$issubscribed=0;

$stmt->bind_param("sssssii",$email,$phone,$filename,$s3rawurl,$s3finishedurl,$status,$issubscribed);

if (!$stmt->execute()) {
    echo "Execute failed: (" . $stmt->errno . ") " . $stmt->error;
}

printf("%d Row inserted.\n", $stmt->affected_rows);


/* explicit close recommended */
$stmt->close();

$link->real_query("SELECT * FROM items");
$res = $link->use_result();

echo "Result set order...\n";
while ($row = $res->fetch_assoc()) {
    echo " id = " . $row['id'] . "\n";
}


$link->close();




?>
