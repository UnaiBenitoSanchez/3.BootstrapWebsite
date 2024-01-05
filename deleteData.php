<?php
require_once 'db_connect.php';

$idProduct = $_POST['id_producto'];

$sqlInventory = "DELETE FROM inventory WHERE product_id_product = $idProduct";

$sqlProduct = "DELETE FROM product WHERE id_product = $idProduct";

try {
    $conn->beginTransaction();

    $conn->exec($sqlInventory);

    $conn->exec($sqlProduct);

    $conn->commit();

    echo "Producto eliminado correctamente";
} catch (PDOException $e) {

    $conn->rollBack();
    
    echo "Error al eliminar el producto: " . $e->getMessage();
}

$conn = null;
?>
