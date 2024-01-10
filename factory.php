<?php
include 'db_connect.php';
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <?php include './controller/head.php'; ?>
    <!-- title -->
    <title>Inventory management dashboard - Factory</title>
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <style>
    body {
      background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('img/factory.jpg');
    }
  </style>
</head>

<body>
    <?php include './controller/navbar.php'; ?>

    <?php
    session_start();

    if (isset($_SESSION['user_email'])) {
        $userEmail = $_SESSION['user_email'];

        try {
            $sql = "SELECT factory.id_factory, factory.name AS factory_name, 
                    CONCAT(factory.street_address, ', ', factory.city, ', ', factory.state, ', ', factory.country) AS factory_address,
                    factory.employee_count, boss.name AS boss_name
                    FROM factory
                    INNER JOIN factory_boss ON factory.id_factory = factory_boss.factory_id_factory
                    INNER JOIN boss ON factory_boss.boss_id_boss_factory = boss.id_boss_factory
                    WHERE boss.email = :userEmail";

            $stmt = $conn->prepare($sql);
            $stmt->bindParam(':userEmail', $userEmail);
            $stmt->execute();

            if ($stmt->rowCount() > 0) {
    ?>
                <div class="container mt-5">
                    <h2 style="color: white">Factory Information</h2>
                    <?php
                    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                        $factoryAddress = $row['factory_address'];
                    ?>
                        <div class="card mt-4">
                            <div class="card-body">
                                <h5 class="card-title">Factory ID: <?php echo $row['id_factory']; ?></h5>
                                <div id="factoryContent">

                                    <p class="card-text">Factory Name: <span id="factoryName"><?php echo $row['factory_name']; ?></span></p>
                                    <p class="card-text">Boss Name: <?php echo $row['boss_name']; ?></p>
                                    <p class="card-text">Factory Address: <span id="factoryAddress"><?php echo $factoryAddress; ?></span></p>
                                    <p class="card-text">Number of Employees: <?php echo $row['employee_count']; ?></p>
                                </div>
                                <div id="factoryEdit" style="display: none;">

                                    <label for="editFactoryName">Factory Name:</label>
                                    <input type="text" id="editFactoryName" value="<?php echo $row['factory_name']; ?>"><br>
                                    <label for="editEmployeeCount">Number of Employees:</label>
                                    <input type="text" id="editEmployeeCount" value="<?php echo $row['employee_count']; ?>"><br>
                                </div>
                        
                                <div id="map" style="height: 300px;"></div>
                                <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

                                <button class="btn btn-primary" onclick="toggleEdit()">Edit</button>
                                <button class="btn btn-danger" onclick="saveChanges(<?php echo $row['id_factory']; ?>)" style="display: none;">Save</button>

                                <script>
                                    var map = L.map('map').setView([0, 0], 2);
                                    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                                        attribution: '© OpenStreetMap contributors'
                                    }).addTo(map);
                                    fetch('https://nominatim.openstreetmap.org/search?format=json&q=' + encodeURIComponent('<?php echo $factoryAddress; ?>'))
                                        .then(response => response.json())
                                        .then(data => {
                                            if (data && data.length > 0) {
                                                var latlng = [parseFloat(data[0].lat), parseFloat(data[0].lon)];
                                                map.setView(latlng, 13);
                                                L.marker(latlng).addTo(map)
                                                    .bindPopup('<?php echo $factoryAddress; ?>')
                                                    .openPopup();
                                            } else {
                                                console.error('Error retrieving geocoding data for the address: <?php echo $factoryAddress; ?>');
                                            }
                                        })
                                        .catch(error => {
                                            console.error('Error retrieving geocoding data:', error);
                                        });

                                    function toggleEdit() {
                                        var factoryContent = document.getElementById('factoryContent');
                                        var factoryEdit = document.getElementById('factoryEdit');
                                        var editButton = document.querySelector('.btn-primary');
                                        var saveButton = document.querySelector('.btn-danger');

                                        if (factoryContent.style.display === 'none') {
                                            factoryContent.style.display = 'block';
                                            factoryEdit.style.display = 'none';
                                            editButton.style.display = 'block';
                                            saveButton.style.display = 'none';
                                        } else {
                                            factoryContent.style.display = 'none';
                                            factoryEdit.style.display = 'block';
                                            editButton.style.display = 'none';
                                            saveButton.style.display = 'block';
                                        }
                                    }

                                    function saveChanges(factoryId) {

                                        var editedFactoryName = document.getElementById('editFactoryName').value;
                                        var editedEmployeeCount = document.getElementById('editEmployeeCount').value;

                                        var xhr = new XMLHttpRequest();
                                        xhr.open("POST", "update_factory.php", true);
                                        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                        xhr.onreadystatechange = function() {
                                            if (xhr.readyState == 4 && xhr.status == 200) {
                                                console.log(xhr.responseText);
                                                toggleEdit();
                                                updateMap("<?php echo $factoryAddress; ?>");
                                                location.reload();
                                            }
                                        };
                                        
                                        xhr.send("factoryId=" + factoryId +
                                            "&editedFactoryName=" + encodeURIComponent(editedFactoryName) +
                                            "&editedEmployeeCount=" + editedEmployeeCount);
                                    }

                                    function updateMap(updatedAddress) {
                                        fetch('https://nominatim.openstreetmap.org/search?format=json&q=' + encodeURIComponent(updatedAddress))
                                            .then(response => response.json())
                                            .then(data => {
                                                if (data && data.length > 0) {
                                                    var latlng = [parseFloat(data[0].lat), parseFloat(data[0].lon)];
                                                    map.setView(latlng, 13);
                                                    L.marker(latlng).addTo(map)
                                                        .bindPopup(updatedAddress)
                                                        .openPopup();
                                                } else {
                                                    console.error('Error retrieving geocoding data for the address: ' + updatedAddress);
                                                }
                                            })
                                            .catch(error => {
                                                console.error('Error retrieving geocoding data:', error);
                                            });
                                    }
                                </script>
                            </div>
                        </div>
                    <?php
                    }
                    ?>
                </div>
    <?php
            } else {
                echo "No factory information found for the current boss.";
            }
        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        } finally {
            $conn = null;
        }
    } else {
        echo "User not logged in.";
    }
    ?>
</body>

</html>