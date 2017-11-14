<?php
session_start();
echo "The count is: ";

if (!isset($_SESSION['count'])) {
  $_SESSION['count'] = 0;
} else {
  $_SESSION['count']++;
}

echo "The count is: ". $_SESSION['count'];
?> 