<?php
//phpinfo();
// Check if form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Hardcoded admin credentials for demonstration purposes
    $adminUsername = "admin";
    $adminPassword = "admin";

    // Get user input
    $enteredUsername = $_POST["username"];
    $enteredPassword = $_POST["password"];

    // Check if entered credentials match the admin credentials
    if ($enteredUsername === $adminUsername && $enteredPassword === $adminPassword) {
        // Redirect to dashboard.php on successful login
        header("Location: home.php");
        exit();
    } else {
        // Display an error message if credentials are incorrect
        $errorMessage = "Invalid username or password.";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management System</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">


    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@500&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif !important;
        }

        body {
            background-image: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
        }

        .main {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100vw;
            height: 91.8vh;
        }

        .login-container {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
            padding: 50px;
            border-radius: 20px;
            background-color: rgba(255, 255, 255, 0.6);
            width: 500px;
        }

        form {
            width: 100%;
        }
    </style>
</head>
<body>

    <div class="main">
        <div class="login-container">
            <h2 class="text-center">Product Management System</h2>
            <?php if (isset($errorMessage)) : ?>
                <div class="alert alert-danger text-center" role="alert" style="width: 100%;">
                    <?php echo $errorMessage; ?>
                </div>
            <?php endif; ?>
            <form action="#" method="POST">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" class="form-control" id="username" name="username">
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" class="form-control" id="password" name="password">
                </div>
                <button type="submit" class="btn btn-dark form-control">Login</button>
            </form>
        </div>
    </div>
    

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>

    <!-- Script  -->
    <script src="./assets/script.js"></script>
</body>
</html>