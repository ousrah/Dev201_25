<?php
include("../conn/conn.php");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['supplier_name'], $_POST['supplier_contact'])) {
        $supplierName = $_POST['supplier_name'];
        $supplierContact = $_POST['supplier_contact'];

        try {
            $stmt = $conn->prepare("INSERT INTO tbl_supplier (supplier_name, supplier_contact) VALUES (:supplier_name, :supplier_contact)");
            
            $stmt->bindParam(":supplier_name", $supplierName, PDO::PARAM_STR);
            $stmt->bindParam(":supplier_contact", $supplierContact, PDO::PARAM_STR);

            $stmt->execute();

            header("Location: http://localhost/product-management/supplier.php");

            exit();
        } catch (PDOException $e) {
            echo "Error:" . $e->getMessage();
        }

    } else {
        echo "
            <script>
                alert('Please fill in all fields!');
                window.location.href = 'http://localhost/product-management/supplier.php';
            </script>
        ";
    }
}
?>
