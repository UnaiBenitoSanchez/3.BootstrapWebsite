<?php
include 'db_connect.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    try {
        $factoryId = $_POST['factoryId'];
        $editedFactoryName = $_POST['editedFactoryName'];
        $editedEmployeeCount = $_POST['editedEmployeeCount'];

        // Update the database
        $updateSql = "UPDATE factory SET name = :editedFactoryName, employee_count = :editedEmployeeCount WHERE id_factory = :factoryId";
        $updateStmt = $conn->prepare($updateSql);
        $updateStmt->bindParam(':factoryId', $factoryId);
        $updateStmt->bindParam(':editedFactoryName', $editedFactoryName);
        $updateStmt->bindParam(':editedEmployeeCount', $editedEmployeeCount);
        $updateStmt->execute();

        echo "Factory information updated successfully.";
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    } finally {
        $conn = null;
    }
}
?>
