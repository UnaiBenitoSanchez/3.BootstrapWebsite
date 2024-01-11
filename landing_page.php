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
      margin: 20px auto; /* Añadido un margen y centrado horizontalmente */
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

  <?php include './controller/head.php'; ?>

  <!-- title -->
  <title>Inventory management dashboard</title>

  <!-- for the chart -->
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
    google.charts.load('current', {
      'packages': ['bar']
    });
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['Company', 'Sales', 'Production', 'Profit'],
        ['Hasbro', 38983746, 43240000, 4000000],
        ['Bandai', 50983746, 62240000, 8000000],
        ['Mattel', 63983746, 75240000, 10000000],
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
  </script>

</head>

<body>

  <?php include './controller/navbar.php'; ?>

  <div class="container">
    <div id="columnchart_material" style="width: 100%; height: 500px;"></div>
  </div>

  <div class="container">
    Our most sold toys:
    
  </div>

</body>

</html>
