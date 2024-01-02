<?php

$servername = "localhost";
$username = "unai";
$password = "xd";
$dbname = "bootstrapwebsite";

try {
    $conn = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    $sql = "SELECT p.id_product, p.name, p.description, p.price, i.available_quantity
            FROM product p
            INNER JOIN inventory i ON p.id_product = i.product_id_product";

    $stmt = $conn->query($sql);

    $data = array();
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $data[] = $row;
    }

    echo json_encode($data);
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
} finally {
    $conn = null;
}
?>
