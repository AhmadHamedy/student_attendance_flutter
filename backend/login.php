<?php
include 'db.php';

$email = $_POST['email'];
$password = $_POST['password'];

$result = $conn->query("SELECT * FROM teachers WHERE email='$email'");

if ($row = $result->fetch_assoc()) {
    if (password_verify($password, $row['password'])) {
        echo "success";
    } else {
        echo "fail";
    }
} else {
    echo "fail";
}
?>
