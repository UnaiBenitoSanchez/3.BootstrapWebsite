<?php

$servername = "localhost";
$username = "enzo";
$password = "xd";
$dbname = "projectzombozo";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$sql = "SELECT p.id_product, p.name, p.description, p.price, i.available_quantity
        FROM product p
        INNER JOIN inventory i ON p.id_product = i.product_id_product";

$result = $conn->query($sql);

$data = array();
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

echo json_encode($data);

$conn->close();
?>
