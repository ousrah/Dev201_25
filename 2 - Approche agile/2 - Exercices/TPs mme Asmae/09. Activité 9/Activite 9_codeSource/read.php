<?php

require 'database.php';

$id = null;
if (!empty($_GET['id'])) {
    $id = $_REQUEST['id'];
}

if (null == $id) {
    header("Location: index.php");
} else {
    $pdo = Database::connect();
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $sql = "......";
    $q = $pdo->prepare($sql);
    $q->execute(array($id));
    $data = $q->fetch(PDO::FETCH_ASSOC);
    Database::disconnect();
}
?>

<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <title>Reade data</title>
</head>

<body>
    <!--<h1>Hello, world!</h1>-->
    <!--<button type="button" class="btn btn-primary">Primary</button>-->
    <div class="container" style="margin-top: 50px">
        <div class="span10 offset-1">
            <div class="row">
                <h1>Reade a Customer</h1>
            </div>

            <div class="form-horizontal" style="margin-top: 40px">
                <br><br>
                <div class="control-group">
                    <label class="control-label" style="font-size: 25px; margin-left: 100px"> Name </label>
                    <label class="checkbox" style="margin-left: 200px;">
                        <?php echo $data['name']; ?>
                    </label>
                </div>

                <div class="control-group">
                    <label class="control-label" style="font-size: 25px; margin-left: 100px"> Email Address </label>
                    <label class="checkbox" style="margin-left: 100px;">
                        <?php echo $data['email']; ?>
                    </label>
                </div>

                <div class="control-group">
                    <label class="control-label" style="font-size: 25px; margin-left: 100px"> Mobile Number </label>
                    <label class="checkbox" style="margin-left: 100px;">
                        <?php echo $data['mobile']; ?>
                    </label>
                </div>

                <div class="form-action" style="margin-left: 100px; margin-top: 40px">
                    <a class="btn btn-dark" href="index.php">Back</a>
                </div>
            </div>
        </div>
        <br>

    </div> <!-- /container -->

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
</body>

</html>