<?php
require 'vendor/autoload.php';

try {
    $mongoClient = new MongoDB\Client("mongodb://root:example@mongodb:27017/");
    $db = $mongoClient->commerce;
    $collection = $db->products;

    $products = $collection->find();

    echo "<h1>Liste des Produits</h1>";
    echo "<ul>";
    foreach ($products as $product) {
        echo "<li>{$product['name']} - {$product['price']}€</li>";
    }
    echo "</ul>";
} catch (Exception $e) {
    echo "Erreur de connexion à MongoDB: " . $e->getMessage();
}
