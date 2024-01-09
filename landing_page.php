<!DOCTYPE html>
<html lang="en">

<head>

  <?php include './controller/head.php'; ?>

  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

  <?php
  include 'db_connect.php';
  session_start();

  // Obtener el correo del jefe de sesión
  $user_email = $_SESSION['user_email'];

  // Consultar el ID de la fábrica asociada al jefe
  $factoryIdStmt = $conn->prepare("SELECT fb.factory_id_factory
                                   FROM factory_boss fb
                                   INNER JOIN boss b ON fb.boss_id_boss_factory = b.id_boss_factory
                                   WHERE b.email = :user_email");
  $factoryIdStmt->bindParam(':user_email', $user_email, PDO::PARAM_STR);
  $factoryIdStmt->execute();
  $factoryId = $factoryIdStmt->fetch(PDO::FETCH_ASSOC)['factory_id_factory'];

  // Consultar los productos asociados a la fábrica
  $productsStmt = $conn->prepare("SELECT p.id_product, p.name
                                  FROM product p
                                  INNER JOIN inventory i ON p.id_product = i.product_id_product
                                  WHERE i.factory_id_factory = :factory_id");
  $productsStmt->bindParam(':factory_id', $factoryId, PDO::PARAM_INT);
  $productsStmt->execute();
  ?>

  <script type="text/javascript">
    google.charts.load('current', {
      'packages': ['corechart']
    });

    // Función para cargar los gráficos una vez se obtengan los datos
    google.charts.setOnLoadCallback(drawCharts);

    // Función para dibujar gráficos para cada producto
    function drawCharts() {
      <?php
      // Iterar sobre los productos obtenidos
      while ($product = $productsStmt->fetch(PDO::FETCH_ASSOC)) {
        $productId = $product['id_product'];
        $productName = $product['name'];

        // Consulta para obtener datos de la historia del inventario para cada producto
        $historyStmt = $conn->prepare("SELECT ih.change_timestamp, ih.change_quantity 
                                        FROM inventory_history ih 
                                        INNER JOIN inventory i ON ih.product_id_product = i.product_id_product
                                        WHERE i.product_id_product = :product_id");
        $historyStmt->bindParam(':product_id', $productId, PDO::PARAM_INT);
        $historyStmt->execute();

        // Crear un array para los datos del gráfico
        $chartData = array();
        $chartData[] = array('Timestamp', 'Quantity');

        while ($row = $historyStmt->fetch(PDO::FETCH_ASSOC)) {
          // Convert the timestamp to a JavaScript Date object
          $timestamp = date("Y-m-d H:i:s", strtotime($row['change_timestamp']));
          $chartData[] = array($timestamp, (int)$row['change_quantity']);
        }

      ?>

        // Configurar opciones específicas para cada gráfico
        var options_<?php echo $productId; ?> = {
          title: 'Product: <?php echo $productName; ?>',
          curveType: 'function',
          legend: {
            position: 'bottom'
          }
        };

        // Crear el gráfico y dibujarlo en el contenedor correspondiente
        var chart_<?php echo $productId; ?> = new google.visualization.LineChart(document.getElementById('curve_chart_<?php echo $productId; ?>'));
        var data_<?php echo $productId; ?> = google.visualization.arrayToDataTable(<?php echo json_encode($chartData); ?>);
        chart_<?php echo $productId; ?>.draw(data_<?php echo $productId; ?>, options_<?php echo $productId; ?>);

      <?php
      }
      ?>
    }
  </script>

  <!-- title -->
  <title>Inventory management dashboard</title>

</head>

<body>

  <?php include './controller/navbar.php'; ?>

  <?php
  // Reiniciar el puntero del conjunto de resultados
  $productsStmt->execute();
  // Iterar sobre los productos y mostrar los contenedores de gráficos
  while ($product = $productsStmt->fetch(PDO::FETCH_ASSOC)) {
    $productId = $product['id_product'];
  ?>
    <div id="curve_chart_<?php echo $productId; ?>" style="width: 900px; height: 500px"></div>
  <?php
  }
  ?>

  <?php
  // Cerrar la conexión después de usarla
  $conn = null;
  ?>

</body>

</html>