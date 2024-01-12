<?php
include 'db_connect.php';
session_start();

function checkIfPlaytimeBoss($bossEmail)
{
    global $conn;

    $query = "SELECT name FROM factory WHERE id_factory = (SELECT factory_id_factory 
    FROM factory_boss WHERE boss_id_boss_factory = (SELECT id_boss_factory FROM boss WHERE email = '$bossEmail'))";
    
    $result = $conn->query($query);

    if ($result) {
        $count = $result->fetchColumn();

        return $count > 0;
    }

    return false;
}

$bossEmail = $_SESSION['user_email'];
$isPlaytimeBoss = checkIfPlaytimeBoss($bossEmail);

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

    <?php if ($isPlaytimeBoss) : ?>
        <div class="container">
            <div id="columnchart_material" style="width: 100%; height: 500px;"></div>
        </div>

        <div class="container">
            Our most sold toys:
            <br>
            <div style="justify-content: center; display: flex; flex-wrap: wrap;">
                
            </div>
        </div>
    <?php endif; ?>

</body>

</html>
