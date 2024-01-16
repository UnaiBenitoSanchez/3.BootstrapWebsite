<?php
include 'db_connect.php';
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <?php include './controller/head.php'; ?>
    <!-- title -->
    <title>Inventory Management Dashboard - Factory</title>
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <style>
        body {
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('img/factory.jpg');
            background-size: cover;
            background-attachment: fixed;
            background-repeat: no-repeat;
        }
    </style>

    <link rel="stylesheet" href="css/three.css">

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
                <div class="container mt-5">
                    <center>
                        <h2 style="color: white">Bosses:</h2>
                    </center>
                <?php
            } else {
                echo "No factory information found for the current boss.";
            }
        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        }

        try {
                ?>
                <?php
                $sql1 = "SELECT boss_id_boss_factory FROM factory_boss 
                            WHERE factory_id_factory IN (
                                SELECT id_factory FROM factory 
                                INNER JOIN factory_boss ON factory.id_factory = factory_boss.factory_id_factory
                                INNER JOIN boss ON factory_boss.boss_id_boss_factory = boss.id_boss_factory
                                WHERE boss.email = :userEmail
                            )";

                $stmt1 = $conn->prepare($sql1);
                $stmt1->bindParam(':userEmail', $_SESSION['user_email']);
                $stmt1->execute();

                while ($bossRow = $stmt1->fetch(PDO::FETCH_ASSOC)) {
                    $bossMuñecoHtml = '<div class="wrapper">';
                    $bossMuñecoHtml .= '<canvas class="c" id="c_' . $bossRow['boss_id_boss_factory'] . '"></canvas>';
                    $bossMuñecoHtml .= '</div>';
                    echo $bossMuñecoHtml;
                }
                ?>

                </div>
        <?php
        } catch (PDOException $e) {
            echo "Error: " . $e->getMessage();
        } finally {
            $conn = null;
        }
    } else {
        echo "User not logged in.";
    }
        ?>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/three.js/108/three.min.js'></script>
        <script src='https://cdn.jsdelivr.net/gh/mrdoob/Three.js@r92/examples/js/loaders/GLTFLoader.js'></script>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                (function() {
                    let scene,
                        renderer,
                        camera,
                        model,
                        neck,
                        waist,
                        mixer,
                        idle,
                        clock = new THREE.Clock(),
                        loaderAnim = document.getElementById('js-loader');

                    init();

                    function init() {
                        const MODEL_PATH = 'https://s3-us-west-2.amazonaws.com/s.cdpn.io/1376484/stacy_lightweight.glb';
                        const canvasId = 'c_4';
                        const canvas = document.getElementById(canvasId);

                        if (!canvas) {
                            console.error("Canvas element not found.");
                            return;
                        }

                        const backgroundColor = 0xf1f1f1;

                        scene = new THREE.Scene();
                        scene.background = new THREE.Color(backgroundColor);
                        scene.fog = new THREE.Fog(backgroundColor, 60, 100);

                        renderer = new THREE.WebGLRenderer({
                            canvas,
                            antialias: true
                        });
                        renderer.shadowMap.enabled = true;
                        renderer.setPixelRatio(window.devicePixelRatio);
                        document.body.appendChild(renderer.domElement);


                        camera = new THREE.PerspectiveCamera(50, window.innerWidth / window.innerHeight, 0.1, 1000);
                        camera.position.z = 30;
                        camera.position.x = 0;
                        camera.position.y = -3;

                        let stacy_txt = new THREE.TextureLoader().load('https://s3-us-west-2.amazonaws.com/s.cdpn.io/1376484/stacy.jpg');
                        stacy_txt.flipY = false;

                        const stacy_mtl = new THREE.MeshPhongMaterial({
                            map: stacy_txt,
                            color: 0xffffff,
                            skinning: true
                        });

                        var loader = new THREE.GLTFLoader();

                        loader.load(
                            MODEL_PATH,
                            function(gltf) {
                                model = gltf.scene;
                                let fileAnimations = gltf.animations;

                                model.traverse(o => {
                                    if (o.isMesh) {
                                        o.castShadow = true;
                                        o.receiveShadow = true;
                                        o.material = stacy_mtl;
                                    }
                                    if (o.isBone && o.name === 'mixamorigNeck') {
                                        neck = o;
                                    }
                                    if (o.isBone && o.name === 'mixamorigSpine') {
                                        waist = o;
                                    }
                                });

                                model.scale.set(7, 7, 7);
                                model.position.y = -11;

                                const canvasId = 'c_' + <?php echo $bossRow['boss_id_boss_factory']; ?>;
                                const canvas = document.getElementById(canvasId);

                                const scene = new THREE.Scene();
                                scene.background = new THREE.Color(backgroundColor);
                                scene.fog = new THREE.Fog(backgroundColor, 60, 100);

                                const renderer = new THREE.WebGLRenderer({
                                    canvas,
                                    antialias: true
                                });
                                renderer.shadowMap.enabled = true;
                                renderer.setPixelRatio(window.devicePixelRatio);

                                const camera = new THREE.PerspectiveCamera(50, window.innerWidth / window.innerHeight, 0.1, 1000);
                                camera.position.z = 30;
                                camera.position.x = 0;
                                camera.position.y = -3;

                                scene.add(model);

                                mixer = new THREE.AnimationMixer(model);

                                let clips = fileAnimations.filter(val => val.name !== 'idle');
                                possibleAnims = clips.map(val => {
                                    let clip = THREE.AnimationClip.findByName(clips, val.name);
                                    clip.tracks.splice(3, 3);
                                    clip.tracks.splice(9, 3);
                                    clip = mixer.clipAction(clip);
                                    return clip;
                                });

                                let idleAnim = THREE.AnimationClip.findByName(fileAnimations, 'idle');
                                idleAnim.tracks.splice(3, 3);
                                idleAnim.tracks.splice(9, 3);
                                idle = mixer.clipAction(idleAnim);
                                idle.play();
                            },

                            undefined,
                            function(error) {
                                console.error(error);
                            }
                        );

                        let hemiLight = new THREE.HemisphereLight(0xffffff, 0xffffff, 0.61);
                        hemiLight.position.set(0, 50, 0);
                        scene.add(hemiLight);

                        let d = 8.25;
                        let dirLight = new THREE.DirectionalLight(0xffffff, 0.54);
                        dirLight.position.set(-8, 12, 8);
                        dirLight.castShadow = true;
                        dirLight.shadow.mapSize = new THREE.Vector2(1024, 1024);
                        dirLight.shadow.camera.near = 0.1;
                        dirLight.shadow.camera.far = 1500;
                        dirLight.shadow.camera.left = d * -1;
                        dirLight.shadow.camera.right = d;
                        dirLight.shadow.camera.top = d;
                        dirLight.shadow.camera.bottom = d * -1;
                        scene.add(dirLight);

                        let floorGeometry = new THREE.PlaneGeometry(5000, 5000, 1, 1);
                        let floorMaterial = new THREE.MeshPhongMaterial({
                            color: 0xeeeeee,
                            shininess: 0,
                        });

                        let floor = new THREE.Mesh(floorGeometry, floorMaterial);
                        floor.rotation.x = -0.5 * Math.PI;
                        floor.receiveShadow = true;
                        floor.position.y = -11;
                        scene.add(floor);

                        let geometry = new THREE.SphereGeometry(8, 32, 32);
                        let material = new THREE.MeshBasicMaterial({
                            color: 0x9bffaf
                        });
                        let sphere = new THREE.Mesh(geometry, material);

                        sphere.position.z = -15;
                        sphere.position.y = -2.5;
                        sphere.position.x = -0.25;
                        scene.add(sphere);

                        const canvasContainer = document.querySelector('.wrapper');
                        const canvasContainerWidth = 200;
                        const canvasContainerHeight = 0;

                        canvasContainer.style.width = `${canvasContainerWidth}px`;
                        canvasContainer.style.height = `${canvasContainerHeight}px`;
                    }

                    function update() {
                        if (mixer) {
                            mixer.update(clock.getDelta());
                        }

                        if (resizeRendererToDisplaySize(renderer)) {
                            const canvas = renderer.domElement;
                            camera.aspect = canvas.clientWidth / canvas.clientHeight;
                            camera.updateProjectionMatrix();
                        }

                        renderer.render(scene, camera);
                        requestAnimationFrame(update);
                    }

                    update();

                    function resizeRendererToDisplaySize(renderer) {
                        const canvas = renderer.domElement;
                        let width = window.innerWidth;
                        let height = window.innerHeight;
                        let canvasPixelWidth = canvas.width / window.devicePixelRatio;
                        let canvasPixelHeight = canvas.height / window.devicePixelRatio;

                        const needResize =
                            canvasPixelWidth !== width || canvasPixelHeight !== height;
                        if (needResize) {
                            renderer.setSize(width, height, false);
                        }
                        return needResize;
                    }

                    window.addEventListener('click', e => raycast(e));
                    window.addEventListener('touchend', e => raycast(e, true));

                    function raycast(e, touch = false) {
                        var mouse = {};
                        if (touch) {
                            mouse.x = 2 * (e.changedTouches[0].clientX / window.innerWidth) - 1;
                            mouse.y = 1 - 2 * (e.changedTouches[0].clientY / window.innerHeight);
                        } else {
                            mouse.x = 2 * (e.clientX / window.innerWidth) - 1;
                            mouse.y = 1 - 2 * (e.clientY / window.innerHeight);
                        }
                        raycaster.setFromCamera(mouse, camera);

                        var intersects = raycaster.intersectObjects(scene.children, true);

                        if (intersects[0]) {
                            var object = intersects[0].object;

                            if (object.name === 'stacy') {
                                if (!currentlyAnimating) {
                                    currentlyAnimating = true;
                                    playOnClick();
                                }
                            }
                        }
                    }

                    document.addEventListener('mousemove', function(e) {
                        var mousecoords = getMousePos(e);
                        if (neck && waist) {
                            moveJoint(mousecoords, neck, 50);
                            moveJoint(mousecoords, waist, 30);
                        }
                    });

                    function getMousePos(e) {
                        return {
                            x: e.clientX,
                            y: e.clientY
                        };
                    }

                    function moveJoint(mouse, joint, degreeLimit) {
                        let degrees = getMouseDegrees(mouse.x, mouse.y, degreeLimit);
                        joint.rotation.y = THREE.Math.degToRad(degrees.x);
                        joint.rotation.x = THREE.Math.degToRad(degrees.y);
                    }

                    function getMouseDegrees(x, y, degreeLimit) {
                        let dx = 0,
                            dy = 0,
                            xdiff,
                            xPercentage,
                            ydiff,
                            yPercentage;

                        let w = {
                            x: window.innerWidth,
                            y: window.innerHeight
                        };

                        if (x <= w.x / 2) {
                            xdiff = w.x / 2 - x;
                            xPercentage = (xdiff / (w.x / 2)) * 100;
                            dx = ((degreeLimit * xPercentage) / 100) * -1;
                        }

                        if (x >= w.x / 2) {
                            xdiff = x - w.x / 2;
                            xPercentage = (xdiff / (w.x / 2)) * 100;
                            dx = (degreeLimit * xPercentage) / 100;
                        }

                        if (y <= w.y / 2) {
                            ydiff = w.y / 2 - y;
                            yPercentage = (ydiff / (w.y / 2)) * 100;
                            dy = (((degreeLimit * 0.5) * yPercentage) / 100) * -1;
                        }

                        if (y >= w.y / 2) {
                            ydiff = y - w.y / 2;
                            yPercentage = (ydiff / (w.y / 2)) * 100;
                            dy = (degreeLimit * yPercentage) / 100;
                        }
                        return {
                            x: dx,
                            y: dy
                        };
                    }

                })();
            });
        </script>
</body>

</html>