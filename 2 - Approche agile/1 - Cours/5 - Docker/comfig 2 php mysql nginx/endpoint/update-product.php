<?php
include("../conn/conn.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['product_name'], $_POST['tbl_supplier_id'], $_POST['purchase'], $_POST['selling'], $_POST['stock'])) {
        $productID = $_POST['tbl_product_id'];
        $productName = $_POST['product_name'];
        $productSupplier = $_POST['tbl_supplier_id'];
        $purchase = $_POST['purchase'];
        $selling = $_POST['selling'];
        $stock = $_POST['stock'];
        $dateUpdated = date("Y-m-d H:i:s");

        try {
            $stmt = $conn->prepare("UPDATE tbl_product SET product_name = :product_name, tbl_supplier_id = :tbl_supplier_id, purchase = :purchase, selling = :selling, stock = :stock, date_updated = :date_updated WHERE tbl_product_id = :tbl_product_id");
            
            $stmt->bindParam(":tbl_product_id", $productID, PDO::PARAM_STR);
            $stmt->bindParam(":product_name", $productName, PDO::PARAM_STR);
            $stmt->bindParam(":tbl_supplier_id", $productSupplier, PDO::PARAM_STR);
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
