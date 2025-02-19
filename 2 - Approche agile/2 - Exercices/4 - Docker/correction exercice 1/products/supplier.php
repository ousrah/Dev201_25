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
                <li class="nav-item">
                    <a class="nav-link" href="http://localhost/product-management/products.php">Products</a>
                </li>
                <li class="nav-item active">
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
            <h4 class="col-10 mr-4">List of Suppliers</h4>
                <div class="button ml-5">
                    <button type="button" class="btn btn-dark" data-toggle="modal" data-target="#addSupplierModal">Add Supplier</button>
                </div>
            </div>
            <hr>
            <div class="table-container table-responsive">
                <table class="table table-sm text-center" id="supplierTable">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">Supplier ID</th>
                            <th scope="col">Supplier Name</th>
                            <th scope="col">Contact</th>
                            <th scope="col">Action</th>
                        </tr>
                    </thead>
                    <tbody>

                        <?php 
                            $stmt = $conn->prepare("SELECT * FROM tbl_supplier");
                            $stmt->execute();
            
                            $result = $stmt->fetchAll();
            
                            foreach ($result as $row) {
                                $supplierID = $row["tbl_supplier_id"];
                                $supplierName = $row["supplier_name"];
                                $supplierContact = $row["supplier_contact"];
                                ?>

                                <tr>
                                    <th scope="row"><?= $supplierID ?></th>
                                    <td id="supplierName-<?= $supplierID ?>"><?= $supplierName ?></td>
                                    <td id="supplierContact-<?= $supplierID ?>"><?= $supplierContact ?></td>
                                    <td>
                                        <div class="action-button">
                                            <button class="btn btn-secondary" onclick="updateSupplier(<?= $supplierID ?>)">&#128393;</button>
                                            <button class="btn btn-danger" onclick="deleteSupplier(<?= $supplierID ?>)">X</button>
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
    <div class="modal fade" id="addSupplierModal" tabindex="-1" aria-labelledby="addSupplier" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addSupplier">Add Supplier</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="./endpoint/add-supplier.php" method="POST">
                        <div class="form-group">
                            <label for="supplierName">Supplier Name:</label>
                            <input type="text" class="form-control" id="supplierName" name="supplier_name">
                        </div>
                        <div class="form-group">
                            <label for="supplierContact">Supplier Contact:</label>
                            <input type="text" class="form-control" id="supplierContact" name="supplier_contact">
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

    <!-- Update Product Modal -->
    <div class="modal fade" id="updateSupplierModal" tabindex="-1" aria-labelledby="updateSupplier" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateSupplier">Update Supplier</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form action="./endpoint/update-supplier.php" method="POST">
                        <input type="hidden" id="updateSupplierID" name="tbl_supplier_id">
                        <div class="form-group">
                            <label for="supplierName">Supplier Name:</label>
                            <input type="text" class="form-control" id="updateSupplierName" name="supplier_name">
                        </div>
                        <div class="form-group">
                            <label for="supplierContact">Supplier Contact:</label>
                            <input type="text" class="form-control" id="updateSupplierContact" name="supplier_contact">
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
            $('#supplierTable').DataTable();
        });
        
        function updateSupplier(id) {
            $("#updateSupplierModal").modal("show");

            let updateSupplierName = $("#supplierName-" + id).text();
            let updateSupplierContact = $("#supplierContact-" + id).text();

            $("#updateSupplierID").val(id);
            $("#updateSupplierName").val(updateSupplierName);
            $("#updateSupplierContact").val(updateSupplierContact);
        }
    </script>
</body>
</html>