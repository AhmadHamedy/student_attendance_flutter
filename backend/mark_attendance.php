<?php
include 'db.php';

$student_id = $_POST['student_id'];
$status = $_POST['status'];
$date = date("Y-m-d");

$conn->query(
  "INSERT INTO attendance (student_id,date,status)
   VALUES ('$student_id','$date','$status')"
);

echo "success";
?>
