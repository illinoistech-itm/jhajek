<?php



echo "begin database";
$link = mysqli_connect($endpoint,"controller","ilovebunnies","itmo544db") or die("Error " . mysqli_error($link));

/* check connection */
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

$delete_table = 'DROP TABLE IF EXISTS items';
$del_tbl = $link->query($delete_table);
if ($delete_table) {
        echo "Table items has been deleted";
}
else {
        echo "error!!";

}

$link->close();
?>
