<!DOCTYPE html>
<html lang="en">

<head>

  <?php include './controller/head.php'; ?>

  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

  <?php

  include 'db_connect.php';
  session_start();

  $product_id = 11;
  
  $productNameStmt = $conn->prepare("SELECT p.name 
                                     FROM product p
                                     INNER JOIN inventory i ON p.id_product = i.product_id_product
                                     WHERE i.product_id_product = :product_id");
  $productNameStmt->bindParam(':product_id', $product_id, PDO::PARAM_INT);
  $productNameStmt->execute();
  $productName = $productNameStmt->fetch(PDO::FETCH_ASSOC)['name'];

  $historyStmt = $conn->prepare("SELECT ih.change_timestamp, ih.change_quantity 
                                  FROM inventory_history ih 
                                  INNER JOIN inventory i ON ih.product_id_product = i.product_id_product
                                  WHERE i.product_id_product = :product_id");
  $historyStmt->bindParam(':product_id', $product_id, PDO::PARAM_INT);
  $historyStmt->execute();

  $chartData = array();
  $chartData[] = array('Timestamp', 'Quantity');

  while ($row = $historyStmt->fetch(PDO::FETCH_ASSOC)) {
    $chartData[] = array($row['change_timestamp'], (int)$row['change_quantity']);
  }
  ?>

  <script type="text/javascript">
    google.charts.load('current', {
      'packages': ['corechart']
    });
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
      var data = google.visualization.arrayToDataTable(<?php echo json_encode($chartData); ?>);

      var options = {
        title: 'Product: <?php echo $productName ?>', 
        curveType: 'function',
        legend: {
          position: 'bottom'
        }
      };

      var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

      chart.draw(data, options);
    }
  </script>

  <!-- title -->
  <title>Inventory management dashboard</title>

</head>

<body>

  <?php include './controller/navbar.php'; ?>
  <div id="curve_chart" style="width: 900px; height: 500px"></div>

  <?php
  $conn = null;
  ?>

</body>

</html>
