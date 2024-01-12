<?php
include 'db_connect.php';
session_start();
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <style>
    body {
      background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('img/factory.jpg');
      background-size: cover;
      background-attachment: fixed;
      background-repeat: no-repeat;
      margin: 0;
    }

    .container {
      width: 90%;
      max-width: 900px;
      margin: 20px auto;
      background: transparent;
      border: 2px solid rgba(255, 255, 255, 0.5);
      border-radius: 20px;
      backdrop-filter: blur(30px);
      text-align: center;
      padding: 20px;
      color: white;
    }

    @media (max-width: 768px) {
      .container {
        width: 100%;
      }
    }
  </style>

  <!-- Tu código de encabezado PHP -->
  <?php include './controller/head.php'; ?>

  <!-- title -->
  <title>Inventory management dashboard</title>

</head>

<body>

  <?php include './controller/navbar.php'; ?>

  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['Company', 'Sales', 'Production', 'Profit'],
        ['Hasbro', 38983746, 43240000, 4000000],
        ['Bandai', 50983746, 62240000, 8000000],
        ['Playtime Co.', 63983746, 75240000, 10000000],
        ['MGA Entertainment', 43983746, 56240000, 6000000]
      ]);

      var options = {
        chart: {
          title: 'We have better performance ',
          subtitle: 'per month than other companies',
        },
        backgroundColor: {
          fill: 'transparent'
        },
        chartArea: {
          width: '80%',
        },
        legend: {
          textStyle: {
            color: 'white'
          }
        },
        hAxis: {
          textStyle: {
            color: 'white'
          }
        },
        vAxis: {
          textStyle: {
            color: 'white'
          }
        },
        titleTextStyle: {
          color: 'white'
        }
      };

      var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
      chart.draw(data, google.charts.Bar.convertOptions(options));
    }

    google.charts.load('current', {
      'packages': ['bar']
    });
    google.charts.setOnLoadCallback(drawChart);
  </script>

  <?php

  $boss = $_SESSION['user_email'];

  // Function to check if the boss is associated with "Playtime Co."
  function checkIfPlaytimeBoss($boss)
  {
    // Implement your logic to check if $boss is associated with "Playtime Co."

    $stmtm->
    // Return true if associated, false otherwise
    return true; // Replace with your actual logic
  }

  // Check if the logged-in boss is associated with "Playtime Co."
  $isPlaytimeBoss = checkIfPlaytimeBoss($boss);

  if ($isPlaytimeBoss) {
    echo '<div class="container">';
  }

  ?>

  <div id="columnchart_material" style="width: 100%; height: 500px;"></div>

  <?php

  if ($isPlaytimeBoss) {
    echo '</div>';
  }

  ?>

  <div class="container">
    Our most sold toys:
    <br>
    <div style="justify-content: center; display: flex; flex-wrap: wrap;">
      <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
        <img src="..." class="card-img-top" alt="...">
        <div class="card-body">
          <h5 class="card-title">Boxy Boo</h5>
          <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card\'s content.</p>
        </div>
      </div>
      <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
        <img src="..." class="card-img-top" alt="...">
        <div class="card-body">
          <h5 class="card-title">Bron</h5>
          <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card\'s content.</p>
        </div>
      </div>
      <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
        <img src="..." class="card-img-top" alt="...">
        <div class="card-body">
          <h5 class="card-title">Bubba Bubbaphant</h5>
          <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card\'s content.</p>
        </div>
      </div>
    </div>
  </div>

</body>

</html>