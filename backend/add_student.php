<?php
include 'db.php';

$student_id = $_POST['student_id'];
$name = $_POST['name'];
$department = $_POST['department'];
$level = $_POST['level'];

$conn->query(
  "INSERT INTO students (student_id,name,department,level)
   VALUES ('$student_id','$name','$department','$level')"
);

echo "success";
?>
