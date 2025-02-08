<?php 
include ("./conn/conn.php");
//echo("ok");
// Total Stocks
$totalStocksStmt = $conn->prepare("SELECT SUM(stock) as totalStocks FROM tbl_product");
$totalStocksStmt->execute();
$totalStocksResult = $totalStocksStmt->fetch(PDO::FETCH_ASSOC);
$totalStocks = $totalStocksResult["totalStocks"];

// Total Suppliers
$totalSuppliersStmt = $conn->prepare("SELECT COUNT(*) as totalSuppliers FROM tbl_supplier");
$totalSuppliersStmt->execute();
$totalSuppliersResult = $totalSuppliersStmt->fetch(PDO::FETCH_ASSOC);
$totalSuppliers = $totalSuppliersResult["totalSuppliers"];

// Total Products
$totalProductsStmt = $conn->prepare("SELECT COUNT(*) as totalProducts FROM tbl_product");
$totalProductsStmt->execute();
$totalProductsResult = $totalProductsStmt->fetch(PDO::FETCH_ASSOC);
$totalProducts = $totalProductsResult["totalProducts"];

// Top Supplier
$topSupplierStmt = $conn->prepare("SELECT tbl_supplier.supplier_name, COUNT(tbl_product.tbl_supplier_id) as productCount 
                                    FROM tbl_supplier 
                                    INNER JOIN tbl_product ON tbl_supplier.tbl_supplier_id = tbl_product.tbl_supplier_id 
                                    GROUP BY tbl_supplier.supplier_name 
                                    ORDER BY productCount DESC 
                                    LIMIT 1");
$topSupplierStmt->execute();
$topSupplierResult = $topSupplierStmt->fetch(PDO::FETCH_ASSOC);
$topSupplierName = $topSupplierResult["supplier_name"];

// Retrieve total stocks for each product
$stocksPerProductStmt = $conn->prepare("SELECT product_name, stock FROM tbl_product");
$stocksPerProductStmt->execute();
$stocksPerProductData = $stocksPerProductStmt->fetchAll(PDO::FETCH_ASSOC);

// Retrieve total products from each supplier
$totalProductsPerSupplierStmt = $conn->prepare("SELECT tbl_supplier.supplier_name, COUNT(tbl_product.tbl_supplier_id) as totalProducts 
                                                FROM tbl_supplier 
                                                LEFT JOIN tbl_product ON tbl_supplier.tbl_supplier_id = tbl_product.tbl_supplier_id 
                                                GROUP BY tbl_supplier.supplier_name");
$totalProductsPerSupplierStmt->execute();
$totalProductsPerSupplierData = $totalProductsPerSupplierStmt->fetchAll(PDO::FETCH_ASSOC);


?>


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
            flex-direction: column;
            align-items: center;
            width: 100vw;
            height: 91.8vh;
        }

        .cards {
            display: flex;
            margin: 50px;
            justify-content: space-around;
            width: 90%;
        }

        .card {
            padding: 30px;
            box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
            border-radius: 20px;
            background-color: rgba(255, 255, 255, 0.6);
            width: 300px;
        }

        .card > p {
            font-size: 30px;
            color: rgb(100, 100, 100);
        }

        .graphs {
            display: flex;
            justify-content: space-around;
            width: 90%; 
        }
        .graph-container {
            width: 49%;
            box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
            padding: 30px 40px;
            border-radius: 20px;
            background-color: rgba(255, 255, 255, 0.6);
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
                <li class="nav-item active">
                    <a class="nav-link" href="home.php">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="products.php">Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="supplier.php">Supplier</a>
                </li>
            </ul>
        </div>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.php">Log Out</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="main">
        <div class="cards">
            <div class="card">
                <h3>Total Stocks:</h3>
                <p><?= $totalStocks ?></p>
            </div>
            <div class="card">
                <h3>Total Suppliers:</h3>
                <p><?= $totalSuppliers ?></p>
            </div>
            <div class="card">
                <h3>Total Products:</h3>
                <p><?= $totalProducts ?></p>
            </div>
            <div class="card">
                <h3>Top Supplier:</h3>
                <p><?= $topSupplierName ?></p>
            </div>
        </div>
        
        <div class="graphs row">
            <div class="graph-container">
                <canvas id="stocksChart"></canvas>
            </div>
            <div class="graph-container">
                <canvas id="supplierChart"></canvas>
            </div>
        </div>
    </div>
    

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>
    
    <!-- Chart JS -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
        // Get the canvas elements
        const stocksChart = document.getElementById('stocksChart').getContext('2d');
        const supplierChart = document.getElementById('supplierChart').getContext('2d');

        // Stocks per Product data
        const stocksPerProductLabels = [];
        const stocksPerProductValues = [];
        <?php foreach ($stocksPerProductData as $data): ?>
            stocksPerProductLabels.push('<?= $data['product_name'] ?>');
            stocksPerProductValues.push(<?= $data['stock'] ?>);
        <?php endforeach; ?>

        // Total Products per Supplier data
        const supplierLabels = [];
        const supplierProducts = [];
        <?php foreach ($totalProductsPerSupplierData as $data): ?>
            supplierLabels.push('<?= $data['supplier_name'] ?>');
            supplierProducts.push(<?= $data['totalProducts'] ?>);
        <?php endforeach; ?>

        // Configure the options for the charts
        const chartOptions = {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        };

        // Create the Stocks per Product chart
        new Chart(stocksChart, {
            type: 'line',
            data: {
                labels: stocksPerProductLabels,
                datasets: [{
                    label: 'Stocks per Product',
                    data: stocksPerProductValues,
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    borderWidth: 1
                }]
            },
            options: chartOptions
        });

        // Create the Total Products per Supplier chart
        new Chart(supplierChart, {
            type: 'bar',
            data: {
                labels: supplierLabels,
                datasets: [{
                    label: 'Total Products per Supplier',
                    data: supplierProducts,
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: chartOptions
        });
    </script>



</body>
</html>