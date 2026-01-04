<?php
include 'db.php';

$data = [];
$res = $conn->query("SELECT * FROM students");

while ($row = $res->fetch_assoc()) {
    $data[] = $row;
}

echo json_encode($data);
?>
