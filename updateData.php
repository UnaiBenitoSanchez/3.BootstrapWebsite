<?php
require_once 'db_connect.php';

$idProduct = $_POST['id_producto'];
$newName = $_POST['nuevo_nombre'];
$newDesc = $_POST['nueva_descripcion'];
$newQuantity = $_POST['nueva_cantidad'];
$newPrice = $_POST['nuevo_precio'];  

try {
    $conn->beginTransaction();

    $stmtProduct = $conn->prepare("UPDATE BootstrapWebsite.product SET name = :nuevoNombre, description = :nuevaDescripcion, price = :nuevoPrecio WHERE id_product = :idProducto");
    $stmtProduct->bindParam(':nuevoNombre', $newName);
    $stmtProduct->bindParam(':nuevaDescripcion', $newDesc);
    $stmtProduct->bindParam(':nuevoPrecio', $newPrice);
    $stmtProduct->bindParam(':idProducto', $idProduct);
    $stmtProduct->execute();

    $stmtInventory = $conn->prepare("UPDATE BootstrapWebsite.inventory SET available_quantity = :nuevaCantidad WHERE product_id_product = :idProducto");
    $stmtInventory->bindParam(':nuevaCantidad', $newQuantity);
    $stmtInventory->bindParam(':idProducto', $idProduct);
    $stmtInventory->execute();

    $conn->commit();

    echo "Data updated";
} catch (PDOException $e) {
    $conn->rollBack();
    echo "Error:" . $e->getMessage();
}

$conn = null;

?>
