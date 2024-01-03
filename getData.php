<?php

require_once 'db_connect.php';
session_start();

try {

    $bossEmail = $_SESSION['user_email'];

    $sql = "SELECT p.id_product, p.name, p.description, p.price, i.available_quantity
        FROM product p
        INNER JOIN inventory i ON p.id_product = i.product_id_product
        WHERE i.factory_id_factory = (SELECT id_factory FROM factory WHERE boss_id_boss_factory = (SELECT id_boss_factory FROM boss WHERE email = :email))";

    $stmt = $conn->prepare($sql);
    $stmt->bindParam(':email', $bossEmail);
    $stmt->execute();

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
