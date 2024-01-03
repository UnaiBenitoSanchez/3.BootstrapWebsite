<?php

require_once 'db_connect.php';

try {
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
    echo "Error: " . $e->getMessage();
} finally {
    $conn = null;
}
