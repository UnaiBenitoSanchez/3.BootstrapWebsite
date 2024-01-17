<?php
include 'db_connect.php';
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <?php include './controller/head.php'; ?>

    <!-- css -->
    <link rel="stylesheet" href="css/index.css">

    <!-- title -->
    <title>Inventory management dashboard - Login/Register</title>

</head>

<body>

    <div class="container">

        <div class="signup-section">
            <header>Signup</header>
            <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="POST" style="margin-top: 90px;">
                <input type="text" name="fullname" placeholder="Full name">
                <input type="email" name="email" placeholder="Email address">
                <input type="password" name="password" placeholder="Password">

                <label for="factory" style="color: white;">Select your factory:</label>
                <select name="factory" id="factory">
                    <?php
                    $stmt = $conn->query("SELECT id_factory, name FROM factory");
                    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                        echo "<option value='{$row['id_factory']}'>{$row['name']}</option>";
                    }
                    ?>
                </select>

                <div class="separator">
                    <div class="line"></div>
                </div>
                <button type="submit" class="btn" name="signup" style="background-color: white;">Signup</button>
            </form>

            <?php
            if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["signup"])) {
                function textToBrainfuck($text)
                {
                    $brainfuckCode = "";
                    for ($i = 0; $i < strlen($text); $i++) {
                        $asciiCode = ord($text[$i]);
                        $brainfuckCode .= str_repeat("+", $asciiCode) . ".>";
                    }
                    return $brainfuckCode;
                }

                if (empty($_POST['fullname']) || empty($_POST['email']) || empty($_POST['password']) || empty($_POST['factory'])) {
                    echo "<p style='color: #ffffff'>Please fill in all fields, including the factory.<p>";
                } else {
                    $fullname = $_POST['fullname'];
                    $email = $_POST['email'];
                    $password = $_POST['password'];
                    $factoryId = $_POST['factory'];
                    $encryptedPassword = textToBrainfuck($password);

                    if (!preg_match('/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/', $password)) {
                        echo "<p style='color: #ffffff'>Password must contain at least one letter, one number, and be at least 8 characters long.</p>";
                    } else {
                        if ($factoryId == "1") {
                            try {
                                $desiredMattelId = 5;

                                $stmtCheckMattelId = $conn->prepare("SELECT COUNT(*) as MattelCount FROM factory_boss WHERE boss_id_boss_factory = :desiredMattelId");
                                $stmtCheckMattelId->bindParam(':desiredMattelId',  $desiredMattelId);
                                $stmtCheckMattelId->execute();
                                $resultCheckMattelId = $stmtCheckMattelId->fetch(PDO::FETCH_ASSOC);

                                $newMattelId = $resultCheckMattelId['MattelCount'] > 0 ?  $desiredMattelId + 1 :  $desiredMattelId;

                                $stmt = $conn->prepare("INSERT INTO boss (id_boss_factory, name, email, password) VALUES (:id, :fullname, :email, :password)");
                                $stmt->bindParam(':id', $newMattelId);
                                $stmt->bindParam(':fullname', $fullname);
                                $stmt->bindParam(':email', $email);
                                $stmt->bindParam(':password', $encryptedPassword);
                                $stmt->execute();

                                $bossId = $conn->lastInsertId();
                                if (!$bossId) {
                                    echo "Error: Boss insertion failed.";
                                    exit();
                                }

                                $stmt = $conn->prepare("INSERT INTO factory_boss (factory_id_factory, boss_id_boss_factory) VALUES (:factoryId, :bossId)");
                                $stmt->bindParam(':factoryId', $factoryId);
                                $stmt->bindParam(':bossId', $newMattelId);
                                $stmt->execute();

                                echo "<p style='color: white;'>User registered successfully</p>";
                            } catch (PDOException $e) {
                                echo "<p style='color: #ffffff'>Please fill in all fields, including the factory.<p>";
                            }
                        } else if ($factoryId == "2") {
                            try {
                                $desiredLegoId = 7;

                                $stmtCheckLegoId = $conn->prepare("SELECT COUNT(*) as legoCount FROM factory_boss WHERE boss_id_boss_factory = :desiredLegoId");
                                $stmtCheckLegoId->bindParam(':desiredLegoId', $desiredLegoId);
                                $stmtCheckLegoId->execute();
                                $resultCheckLegoId = $stmtCheckLegoId->fetch(PDO::FETCH_ASSOC);

                                $newLegoId = $resultCheckLegoId['legoCount'] > 0 ? $desiredLegoId + 1 : $desiredLegoId;

                                $stmt = $conn->prepare("INSERT INTO boss (id_boss_factory, name, email, password) VALUES (:id, :fullname, :email, :password)");
                                $stmt->bindParam(':id', $newLegoId);
                                $stmt->bindParam(':fullname', $fullname);
                                $stmt->bindParam(':email', $email);
                                $stmt->bindParam(':password', $encryptedPassword);
                                $stmt->execute();

                                $bossId = $conn->lastInsertId();
                                if (!$bossId) {
                                    echo "Error: Boss insertion failed.";
                                    exit();
                                }

                                $stmt = $conn->prepare("INSERT INTO factory_boss (factory_id_factory, boss_id_boss_factory) VALUES (:factoryId, :bossId)");
                                $stmt->bindParam(':factoryId', $factoryId);
                                $stmt->bindParam(':bossId', $newLegoId);
                                $stmt->execute();

                                echo "<p style='color: white;'>User registered successfully</p>";
                            } catch (PDOException $e) {
                                echo "<p style='color: #ffffff'>Please fill in all fields, including the factory.<p>";
                            }
                        } else if ($factoryId == "3") {
                            try {
                                $desiredNerfId = 9;

                                $stmtCheckNerfId = $conn->prepare("SELECT COUNT(*) as NerfCount FROM factory_boss WHERE boss_id_boss_factory = :desiredNerfId");
                                $stmtCheckNerfId->bindParam(':desiredNerfId', $desiredNerfId);
                                $stmtCheckNerfId->execute();
                                $resultCheckNerfId = $stmtCheckNerfId->fetch(PDO::FETCH_ASSOC);

                                $newNerfId = $resultCheckNerfId['NerfCount'] > 0 ? $desiredNerfId + 1 : $desiredNerfId;

                                $stmt = $conn->prepare("INSERT INTO boss (id_boss_factory, name, email, password) VALUES (:id, :fullname, :email, :password)");
                                $stmt->bindParam(':id', $newNerfId);
                                $stmt->bindParam(':fullname', $fullname);
                                $stmt->bindParam(':email', $email);
                                $stmt->bindParam(':password', $encryptedPassword);
                                $stmt->execute();

                                $bossId = $conn->lastInsertId();
                                if (!$bossId) {
                                    echo "Error: Boss insertion failed.";
                                    exit();
                                }

                                $stmt = $conn->prepare("INSERT INTO factory_boss (factory_id_factory, boss_id_boss_factory) VALUES (:factoryId, :bossId)");
                                $stmt->bindParam(':factoryId', $factoryId);
                                $stmt->bindParam(':bossId', $newNerfId);
                                $stmt->execute();

                                echo "<p style='color: white;'>User registered successfully</p>";
                            } catch (PDOException $e) {
                                echo "<p style='color: #ffffff'>Please fill in all fields, including the factory.<p>";
                            }
                        } else if ($factoryId == "4") {
                            try {
                                $desiredPlaytimeId = 11;

                                $stmtCheckPlaytimeId = $conn->prepare("SELECT COUNT(*) as PlaytimeCount FROM factory_boss WHERE boss_id_boss_factory = :desiredPlaytimeId");
                                $stmtCheckPlaytimeId->bindParam(':desiredPlaytimeId', $desiredPlaytimeId);
                                $stmtCheckPlaytimeId->execute();
                                $resultCheckPlaytimeId = $stmtCheckPlaytimeId->fetch(PDO::FETCH_ASSOC);

                                $newPlaytimeId = $resultCheckPlaytimeId['PlaytimeCount'] > 0 ? $desiredPlaytimeId + 1 : $desiredPlaytimeId;

                                $stmt = $conn->prepare("INSERT INTO boss (id_boss_factory, name, email, password) VALUES (:id, :fullname, :email, :password)");
                                $stmt->bindParam(':id', $newPlaytimeId);
                                $stmt->bindParam(':fullname', $fullname);
                                $stmt->bindParam(':email', $email);
                                $stmt->bindParam(':password', $encryptedPassword);
                                $stmt->execute();

                                $bossId = $conn->lastInsertId();
                                if (!$bossId) {
                                    echo "Error: Boss insertion failed.";
                                    exit();
                                }

                                $stmt = $conn->prepare("INSERT INTO factory_boss (factory_id_factory, boss_id_boss_factory) VALUES (:factoryId, :bossId)");
                                $stmt->bindParam(':factoryId', $factoryId);
                                $stmt->bindParam(':bossId', $newPlaytimeId);
                                $stmt->execute();

                                echo "<p style='color: white;'>User registered successfully</p>";
                            } catch (PDOException $e) {
                                echo "<p style='color: #ffffff'>Please fill in all fields, including the factory.<p>";
                            }
                        }
                    }
                }
            }
            ?>

        </div>

        <div class="login-section">
            <header>Login</header>
            <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="POST" style="margin-top: 90px;">
                <input type="email" name="email" placeholder="Email address">
                <input type="password" name="password" placeholder="Password">
                <div class="separator">
                    <div class="line"></div>
                </div>
                <button type="submit" class="btn" name="login">Login</button>
            </form>

            <?php
            if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST["login"])) {
                function textToBrainfuck($text)
                {
                    $brainfuckCode = "";
                    for ($i = 0; $i < strlen($text); $i++) {
                        $asciiCode = ord($text[$i]);
                        $brainfuckCode .= str_repeat("+", $asciiCode) . ".>";
                    }
                    return $brainfuckCode;
                }

                if (empty($_POST['email']) || empty($_POST['password'])) {
                    echo "<p style='color: #ffffff'>Please fill in all fields.<p>";
                } else {
                    $email = $_POST['email'];
                    $password = $_POST['password'];

                    $encryptedPasswordInput = textToBrainfuck($password);

                    try {
                        $stmt = $conn->prepare("SELECT * FROM boss WHERE email = :email");
                        $stmt->bindParam(':email', $email);
                        $stmt->execute();
                        $user = $stmt->fetch(PDO::FETCH_ASSOC);

                        if ($user) {
                            if ($encryptedPasswordInput == $user['password']) {
                                session_start();
                                $_SESSION['user_email'] = $email;
                                echo '<script>window.location.href = "./php/landing_page.php";</script>';
                                exit();
                            } else {
                                echo "Incorrect password";
                            }
                        } else {
                            echo "User not found";
                        }
                    } catch (PDOException $e) {
                        echo "Error: " . $e->getMessage();
                    }
                }
            }
            ?>
        </div>

    </div>

    <script src="js/index.js"></script>

</body>

</html>