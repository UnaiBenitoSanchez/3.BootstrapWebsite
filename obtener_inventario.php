<?php

$servername = "localhost";
$username = "enzo";
$password = "xd";
$dbname = "proyectozombozo";


$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

$sql = "SELECT p.id_producto, p.nombre, p.descripcion, p.precio, i.cantidad_disponible
        FROM producto p
        INNER JOIN inventario i ON p.id_producto = i.producto_id_producto";

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