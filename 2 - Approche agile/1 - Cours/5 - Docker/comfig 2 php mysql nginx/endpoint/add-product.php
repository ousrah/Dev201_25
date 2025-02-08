<?php
include("../conn/conn.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['product_name'], $_POST['product_supplier'], $_POST['purchase'], $_POST['selling'], $_POST['stock'])) {
        $productName = $_POST['product_name'];
        $productSupplier = $_POST['product_supplier'];
        $purchase = $_POST['purchase'];
        $selling = $_POST['selling'];
        $stock = $_POST['stock'];
        $dateUpdated = date("Y-m-d H:i:s");

        try {
            $stmt = $conn->prepare("INSERT INTO tbl_product (product_name, product_supplier, purchase, selling, stock, date_updated) VALUES (:product_name, :product_supplier, :purchase, :selling, :stock, :date_updated)");
            
            $stmt->bindParam(":product_name", $productName, PDO::PARAM_STR);
            $stmt->bindParam(":product_supplier", $productSupplier, PDO::PARAM_STR);
            $stmt->bindParam(":purchase", $purchase, PDO::PARAM_STR);
            $stmt->bindParam(":selling", $selling, PDO::PARAM_STR);
            $stmt->bindParam(":stock", $stock, PDO::PARAM_STR);
            $stmt->bindParam(":date_updated", $dateUpdated, PDO::PARAM_STR);

            $stmt->execute();

            header("Location: http://localhost/product-management/products.php");

            exit();
        } catch (PDOException $e) {
            echo "Error:" . $e->getMessage();
        }

    } else {
        echo "
            <script>
                alert('Please fill in all fields!');
                window.location.href = 'http://localhost/product-management/products.php';
            </script>
        ";
    }
}
?>
