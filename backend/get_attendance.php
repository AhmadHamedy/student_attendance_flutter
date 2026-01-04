<?php
include 'db.php';

$student_id = $_GET['student_id'];
$data = [];

$res = $conn->query(
  "SELECT date,status FROM attendance WHERE student_id='$student_id'"
);

while ($row = $res->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode($data);
?>
