<?php
include 'db_connect.php';
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <!-- meta -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- css -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" href="css/index.css">

    <!-- js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <!-- title -->
    <title>Inventory management dashboard</title>
</head>

<body>

    <div class="container">

        <div class="signup-section">
            <header>Signup</header>
            <form action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]); ?>" method="POST" style="margin-top: 90px;">
                <input type="text" name="fullname" placeholder="Full name">
                <input type="email" name="email" placeholder="Email address">
                <input type="password" name="password" placeholder="Password">
                <div class="separator">
                    <div class="line"></div>
                </div>
                <button type="submit" class="btn" name="signup">Signup</button>
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

                if (empty($_POST['fullname']) || empty($_POST['email']) || empty($_POST['password'])) {
                    echo "<p style='color: #ffffff'>Please fill in all fields.<p>";
                } else {
                    $fullname = $_POST['fullname'];
                    $email = $_POST['email'];
                    $password = $_POST['password'];

                    $encryptedPassword = textToBrainfuck($password);

                    try {
                        $stmt = $conn->prepare("INSERT INTO boss (name, email, password) VALUES (:fullname, :email, :password)");
                        $stmt->bindParam(':fullname', $fullname);
                        $stmt->bindParam(':email', $email);
                        $stmt->bindParam(':password', $encryptedPassword);
                        $stmt->execute();

                        echo "User registered successfully";
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