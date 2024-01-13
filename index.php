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

                    try {
                        $stmt = $conn->prepare("INSERT INTO boss (name, email, password) VALUES (:fullname, :email, :password)");
                        $stmt->bindParam(':fullname', $fullname);
                        $stmt->bindParam(':email', $email);
                        $stmt->bindParam(':password', $encryptedPassword);
                        $stmt->execute();

                        $bossId = $conn->lastInsertId();

                        $stmt = $conn->prepare("INSERT INTO factory_boss (factory_id_factory, boss_id_boss_factory) VALUES (:factoryId, :bossId)");
                        $stmt->bindParam(':factoryId', $factoryId);
                        $stmt->bindParam(':bossId', $bossId);
                        $stmt->execute();

                        echo "<p  style='color: white;'>User registered successfully</p>";
                    } catch (PDOException $e) {
                        echo "Error: " . $e->getMessage();
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
                                echo '<script>window.location.href = "landing_page.php";</script>';
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
