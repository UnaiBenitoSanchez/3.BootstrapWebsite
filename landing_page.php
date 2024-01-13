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
          <img src="img/mattel4.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Barbie Cutie Reveal Serie Phantasy Unicorn</h5>
            <p class="card-text">Open the box and you'll see inside a soft plush unicorn and four surprise bags. Remove the rainbow unicorn costume and you'll find a Barbie doll with long hair and sparkly details. Open the surprise bags and discover sparkly clothes, accessories, a sponge-comb and a mini unicorn.</p>
          </div>
        </div>
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="img/mattel5.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Barbie Cutie Reveal Serie Jungle Friends Tiger</h5>
            <p class="card-text">Barbie Cutie Reveal Jungle Series dolls offer the cutest unboxing experience with 10 surprises! Discover a charming Elephant, lovable Tiger, bright Toucan or cheeky Monkey, then remove the plush costume to reveal a posable Barbie doll with long, colorful hair. Which doll will you reveal?</p>
          </div>
        </div>
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="img/mattel6.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Disney Frozen Queen Anna & Elsa Snow Queen</h5>
            <p class="card-text">Set of two classic dolls, Queen Anna and Snow Queen Elsa. Finely detailed features; Elsa snow queen costume includes satin dress with shimmering lavender organza cape and sleeves. Queen Anna costume includes layered green satin dress with glitter, lined cape and tiara. Beautifully styled, rooted hair; molded shoes and boots</p>
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
          <img src="img/lego4.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Cherry Blossoms</h5>
            <p class="card-text">As well as being a celebration gift for kids, the brick-built blossoms make a great gift for grown-ups, who will be delighted to receive these unique flowers onValentine’s Day or Mother’s Day. Once complete, the set makes a beautiful piece of floral decor that will add a touch of spring joy to any space. It can also be combined with other LEGO flowers (sold separately) to create a vibrant bouquet.</p>
          </div>
        </div>
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="img/lego5.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Disney Ariel Mini Castle</h5>
            <p class="card-text">Fans of Disney Princess buildable toys and The Little Mermaid movie aged 12 and up will enjoy endless imaginative role play with this mini model of Ariel’s enchanting palace. Mini Disney Ariel’s Castle (40708) is covered in golden details, incorporates various underwater features and includes an Ariel mini-doll figure. This portable buildable playset is part of the Mini Disney range of companion construction toys, sold separately.</p>
          </div>
        </div>
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="img/lego6.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Natural History Museum</h5>
            <p class="card-text">Discover the first-ever museum to join the Modular Buildings collection. Home to an array of brick-built exhibits it features dual skylights that allow light to permeate the building’s 2 levels, illuminating the towering brachiosaurus skeleton and collection of treasures within.</p>
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
          <img src="img/nerf4.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Nerf DinoSquad Rex-Rampage</h5>
            <p class="card-text">A motorized launcher that roars like the king of the dinosaurs!!!
              It has a 10 dart holder in the butt so you have projectiles for easy reloading.
              Includes 20 Nerf foam darts for quick firing.
              It works with 4 AAA batteries. NOT included.
              Recommended age: +8 years old.
              Safety Warnings: Do not point at eyes or face. Do not modify darts or launcher. Use only darts designated for the launcher. ALWAYS wear protective goggles.</p>
          </div>
        </div>
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="img/nerf5.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Nerf Alpha Strike Slinger SD-1</h5>
            <p class="card-text">The Slinger SD-1 Aiming Set includes 1 launcher, 2 target pieces and 4 Nerf Elite darts. The launcher launches 1 dart at a time and is easy to use. Insert 1 dart into the barrel, pull the handle to set it up and pull the trigger to launch 1 dart. Practice your aiming skills with the 2 target pieces that you can put together to form 1 whole target.</p>
          </div>
        </div>
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="img/nerf6.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Nerf Alpha Strike - Mission Set</h5>
            <p class="card-text">This 31-piece Nerf Alpha Strike Mission Set includes 4 launchers, 25 darts and targets to practice your aim and play Nerf games. Perfect for gifts, parties or play anytime! Includes 2 Stinger SD-1 launchers, 1 Cobra RC-6 launcher, 1 Tiger DB-2 launcher and 2 target pieces that can be snapped together to form 1 whole target.</p>
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
          <img src="img/playtime4.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">DogDay</h5>
            <p class="card-text">This is DogDay, the sunny, strong, and determined leader of our critters! Each trusts him to find the bright side in any situation, and to have a friendly word of encouragement should they feel down. He'll always keep his friends going, no matter what.</p>
          </div>
        </div>
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="img/playtime8.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">CatNap</h5>
            <p class="card-text">CatNap is a calming presence for the critters and ensures he and his friends always have the right amount of sleep to jumpstart the morning's play! End of the day, there's nothing CatNap enjoys more than watching his friends sleep soundly.</p>
          </div>
        </div>
        <div class="card" style="width: 18rem; margin-bottom: 10px; margin-left: 10px;">
          <img src="img/playtime2.jpg" class="card-img-top" alt="...">
          <div class="card-body">
            <h5 class="card-title">Bubba Bubbaphant</h5>
            <p class="card-text">Bubba Bubbaphant is the brains of the critters. Bright and attentive, he keeps his friends steady and always steers them to make smart choices, that way they all might grow up to be bright and brilliant, each in their own right.</p>
          </div>
        </div>
      </div>
    </div>
  <?php endif; ?>

</body>

</html>