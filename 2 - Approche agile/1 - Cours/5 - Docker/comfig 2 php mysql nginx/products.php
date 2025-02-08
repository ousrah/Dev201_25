<?php include ("./conn/conn.php") ?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management System</title>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <!-- Data Table -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.css" />
    
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

        .product-container {
            width: 90%;
            height: 90%;
            box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
            padding: 30px 40px;
            border-radius: 20px;
            background-color: rgba(255, 255, 255, 0.6);
        }

        .action-button {
            display: flex;
            justify-content: center;
        }
        
        .action-button > button {
            width: 25px;
            height: 25px;
            font-size: 17px;
            display: flex !important;
            justify-content: center;
            align-items: center;
            margin: 0px 2px;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand ml-3" href="">Product Management System</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="http://localhost/product-management/home.php">Home</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="http://localhost/product-management/products.php">Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="http://localhost/product-management/supplier.php">Supplier</a>
                </li>
            </ul>
        </div>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="http://localhost/product-management/index.php">Log Out</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="main">
        <div class="product-container">
            <div class="row">
            <h4 class=" col-10">List of Products</h4>
                <div class="button ml-3">
                    <button type="button" class="btn btn-success" onclick="printProducts()">Print</button>
                    <button type="button" class="btn btn-dark" data-toggle="modal" data-target="#addProductModal">Add Product</button>
                </div>
            </div>
            <hr>
            <div class="table-container table-responsive">
                <table class="table table-sm text-center" id="productTable">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">Product ID</th>
                            <th scope="col">Product Name</th>
                            <th scope="col">Supplier</th>
                            <th scope="col">Purchcase Price</th>
                            <th scope="col">Selling Price</th>
                            <th scope="col">Stocks</th>
                            <th scope="col">Date Updated</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>

                        <?php 

                            $stmt = $conn->prepare("SELECT * FROM tbl_product LEFT JOIN tbl_supplier ON  tbl_product.tbl_supplier_id = tbl_supplier.tbl_supplier_id");
                            $stmt->execute();
            
                            $result = $stmt->fetchAll();
            
                            foreach ($result as $row) {
                                $productID = $row["tbl_product_id"];
                                $productName = $row["product_name"];
                                $supplierID = $row["tbl_supplier_id"];
                                $productSupplier = $row["supplier_name"];
                                $purchase = $row["purchase"];
                                $selling = $row["selling"];
                                $stock = $row["stock"];
                                $dateUpdated = $row["date_updated"];
                            ?>
                            
                            <tr>
                                <th scope="row"><?= $productID ?></th>
                                <td id="productName-<?= $productID ?>"><?= $productName ?></td>
                                <td id="productSupplier-<?= $productID ?>"><?= $productSupplier ?></td>
                                <td id="purchase-<?= $productID ?>"><?= $purchase ?></td>
                                <td id="selling-<?= $productID ?>"><?= $selling ?></td>
                                <td id="stock-<?= $productID ?>"><?= $stock ?></td>
                                <td><?= $dateUpdated ?></td>
                                <td>
                                    <div class="action-button">
                                        <button class="btn btn-secondary" onclick="updateProduct(<?= $productID ?>)">&#128393;</button>
                                        <button class="btn btn-danger" onclick="deleteProduct(<?= $productID ?>)">X</button>
                                    </div>
                                </td>
                            </tr>
                            <?php
                        }
                        ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    
    <!-- Add Product Modal -->
    <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProduct" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProduct">Add Product</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="./endpoint/add-product.php" method="POST">
                        <div class="form-group">
                            <label for="productName">Product Name:</label>
                            <input type="text" class="form-control" id="productName" name="product_name">
                        </div>
                        <div class="form-group">
                            <label for="productSupplier">Supplier:</label>
                            <select class="form-control" name="tbl_supplier_id" id="productSupplier">
                                <option value="">-select-</option>
                                <?php 
                                    include ('./conn/conn.php');

                                    $stmt = $conn->prepare("SELECT * FROM tbl_supplier");
                                    $stmt->execute();

                                    $result = $stmt->fetchAll();

                                    foreach($result as $row) {
                                        $supplierID = $row['tbl_supplier_id'];
                                        $supplierName = $row['supplier_name'];
                                        ?>

                                        <option value="<?= $supplierID ?>"><?= $supplierName ?></option>

                                        <?php
                                    }
                                    
                                ?>
                            </select>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-4">
                                <label for="purchase">Purchase Price:</label>
                                <input type="number" class="form-control" id="purchase" name="purchase">
                            </div>
                            <div class="form-group col-4">
                                <label for="selling">Selling Price:</label>
                                <input type="number" class="form-control" id="selling" name="selling">
                            </div>
                            <div class="form-group col-4">
                                <label for="stock">Stocks:</label>
                                <input type="number" class="form-control" id="stock" name="stock">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-dark">Add</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Updated Product Modal -->
    <div class="modal fade" id="updateProductModal" tabindex="-1" aria-labelledby="updateProduct" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateProduct">Update Product</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="./endpoint/update-product.php" method="POST">
                        <input type="hidden" class="form-control" id="updateProductID" name="tbl_product_id">
                        <div class="form-group">
                            <label for="updateProductName">Product Name:</label>
                            <input type="text" class="form-control" id="updateProductName" name="product_name">
                        </div>
                        <div class="form-group">
                            <label for="updateProductSupplier">Supplier:</label>
                            <select class="form-control" name="tbl_supplier_id" id="updateProductSupplier">
                                <option value="">-select-</option>
                                <?php 
                                    include ('./conn/conn.php');

                                    $stmt = $conn->prepare("SELECT * FROM tbl_supplier");
                                    $stmt->execute();

                                    $result = $stmt->fetchAll();    

                                    foreach($result as $row) {
                                        $supplierID = $row['tbl_supplier_id'];
                                        $supplierName = $row['supplier_name'];
                                        ?>
                                        
                                        <option value="<?= $supplierID ?>"><?= $supplierName ?></option>

                                        <?php
                                    }
                                    
                                ?>
                            </select>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-4">
                                <label for="updatePurchase">Purchase Price:</label>
                                <input type="number" class="form-control" id="updatePurchase" name="purchase">
                            </div>
                            <div class="form-group col-4">
                                <label for="updateSelling">Selling Price:</label>
                                <input type="number" class="form-control" id="updateSelling" name="selling">
                            </div>
                            <div class="form-group col-4">
                                <label for="updateStock">Stocks:</label>
                                <input type="number" class="form-control" id="updateStock" name="stock">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-dark">Save changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>
    
    <!-- Data Table -->
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.js"></script>

    <script>
        $(document).ready( function () {
            $('#productTable').DataTable();
        });

        function updateProduct(id) {
            $("#updateProductModal").modal("show");

            let updateProductName = $("#productName-" + id).text();
            let updateProductSupplier = $("#productSupplier-" + id).text();
            let updatePurchase = $("#purchase-" + id).text();
            let updateSelling = $("#selling-" + id).text();
            let updateStock = $("#stock-" + id).text();

            $("#updateProductID").val(id);
            $("#updateProductName").val(updateProductName);
            $("#updateProductSupplier option").each(function() {
                let supplier = $(this).text();
                if (supplier === updateProductSupplier) {
                    $(this).prop("selected", true);
                    return false;
                }
            });
            $("#updatePurchase").val(updatePurchase);
            $("#updateSelling").val(updateSelling);
            $("#updateStock").val(updateStock);
        }
    </script>
</body>
</html>