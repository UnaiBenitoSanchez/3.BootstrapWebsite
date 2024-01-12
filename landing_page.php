<?php
include 'db_connect.php';
session_start();

function getFactoryNameByBoss($bossEmail)
{
  global $conn;

  $escapedBossEmail = $conn->quote($bossEmail);

  $query = "SELECT f.name FROM factory_boss fb
              JOIN boss b ON fb.boss_id_boss_factory = b.id_boss_factory
              JOIN factory f ON fb.factory_id_factory = f.id_factory
              WHERE b.email = $escapedBossEmail";

  $result = $conn->query($query);

  if ($result) {
    $factoryName = $result->fetchColumn();
    return $factoryName;
  }

  return false;
}

$bossEmail = $_SESSION['user_email'];
$factoryName = getFactoryNameByBoss($bossEmail);

?>

<!DOCTYPE html>
<html lang="en">

<head>

  <?php include './controller/head.php'; ?>

  <!-- title -->
  <title>Inventory management dashboard</title>

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
</head>

<body>

  <?php include './controller/navbar.php'; ?>

  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

  <!-- Mattel -->
  <script type="text/javascript">
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['Company', 'Sales', 'Production', 'Profit'],
        ['Mattel', 63983746, 75240000, 10000000],
        ['Melissa & Doug', 28983746, 33240000, 2000000],
        ['VTech', 50983746, 62240000, 8000000],
        ['Spin Master', 53983746, 66240000, 6000000]
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

      var chart = new google.charts.Bar(document.getElementById('columnchart_material1'));
      chart.draw(data, google.charts.Bar.convertOptions(options));
    }

    google.charts.load('current', {
      'packages': ['bar']
    });
    google.charts.setOnLoadCallback(drawChart);
  </script>

  <!-- Lego -->
  <script type="text/javascript">
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['Company', 'Sales', 'Production', 'Profit'],
        ['Ravensburger', 38983746, 43240000, 4000000],
        ['Lego', 63983746, 75240000, 10000000],
        ['Fisher-Price', 50983746, 62240000, 8000000],
        ['Playmobil', 43983746, 56240000, 6000000]
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

      var chart = new google.charts.Bar(document.getElementById('columnchart_material2'));
      chart.draw(data, google.charts.Bar.convertOptions(options));
    }

    google.charts.load('current', {
      'packages': ['bar']
    });
    google.charts.setOnLoadCallback(drawChart);
  </script>

  <!-- Nerf -->
  <script type="text/javascript">
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['Company', 'Sales', 'Production', 'Profit'],
        ['LeapFrog', 38983746, 43240000, 5000000],
        ['Tomy', 40983746, 52240000, 7000000],
        ['Nerf', 63983746, 75240000, 10000000],
        ['WowWee', 23983746, 36240000, 3000000]
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

      var chart = new google.charts.Bar(document.getElementById('columnchart_material3'));
      chart.draw(data, google.charts.Bar.convertOptions(options));
    }

    google.charts.load('current', {
      'packages': ['bar']
    });
    google.charts.setOnLoadCallback(drawChart);
  </script>

  <!-- Playtime Co. -->
  <script type="text/javascript">
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['Company', 'Sales', 'Production', 'Profit'],
        ['Naipes Heraclio Fournier', 38983746, 43240000, 4000000],
        ['Bandai', 50983746, 62240000, 8000000],
        ['MGA Entertainment', 23983746, 36240000, 4000000],
        ['Playtime Co.', 63983746, 75240000, 10000000]
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

      var chart = new google.charts.Bar(document.getElementById('columnchart_material4'));
      chart.draw(data, google.charts.Bar.convertOptions(options));
    }

    google.charts.load('current', {
      'packages': ['bar']
    });
    google.charts.setOnLoadCallback(drawChart);
  </script>

  <!-- Mattel -->
  <?php if ($factoryName == 'Mattel') : ?>
    <div class="container">
      <div id="columnchart_material1" style="width: 100%; height: 500px;"></div>
    </div>

    <div class="container">
      Our most sold toys:
      <br>
      <div style="justify-content: center; display: flex; flex-wrap: wrap;">
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="..." class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Barbie Cutie Reveal Serie Phantasy Unicorn</h5>
            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card\'s content.</p>
          </div>
        </div>
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="..." class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Barbie Cutie Reveal Serie Jungle Friends Tiger</h5>
            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card\'s content.</p>
          </div>
        </div>
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="..." class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Disney Frozen Queen Anna Y Elsa Snow Queen</h5>
            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card\'s content.</p>
          </div>
        </div>
      </div>
    </div>
  <?php endif; ?>

  <!-- Lego -->
  <?php if ($factoryName == 'Lego') : ?>
    <div class="container">
      <div id="columnchart_material2" style="width: 100%; height: 500px;"></div>
    </div>

    <div class="container">
      Our most sold toys:
      <br>
      <div style="justify-content: center; display: flex; flex-wrap: wrap;">
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="..." class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Cherry Blossoms</h5>
            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card\'s content.</p>
          </div>
        </div>
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="..." class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Disney Ariel Mini Castle</h5>
            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card\'s content.</p>
          </div>
        </div>
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="..." class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Natural History Museum</h5>
            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card\'s content.</p>
          </div>
        </div>
      </div>
    </div>
  <?php endif; ?>

  <!-- Nerf -->
  <?php if ($factoryName == 'Nerf') : ?>
    <div class="container">
      <div id="columnchart_material3" style="width: 100%; height: 500px;"></div>
    </div>

    <div class="container">
      Our most sold toys:
      <br>
      <div style="justify-content: center; display: flex; flex-wrap: wrap;">
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="..." class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Nerf DinoSquad Rex-Rampage</h5>
            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card\'s content.</p>
          </div>
        </div>
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="..." class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Nerf Alpha Strike Slinger SD-1 - Set de puntería</h5>
            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card\'s content.</p>
          </div>
        </div>
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="..." class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Nerf Alpha Strike - Set de misión</h5>
            <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card\'s content.</p>
          </div>
        </div>
      </div>
    </div>
  <?php endif; ?>

  <!-- Playtime Co. -->
  <?php if ($factoryName == 'Playtime Co.') : ?>
    <div class="container">
      <div id="columnchart_material4" style="width: 100%; height: 500px;"></div>
    </div>

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
  <?php endif; ?>

</body>

</html>