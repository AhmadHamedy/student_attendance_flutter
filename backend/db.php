<?php
$host = "fdb1032.awardspace.net"; 
$user = "4716591_attendence";
$pass = "3j_9L@[S9KyJs*N?";
$db   = "4716591_attendence";

$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>