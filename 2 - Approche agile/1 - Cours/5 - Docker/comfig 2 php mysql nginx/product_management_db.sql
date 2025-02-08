-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 05, 2024 at 09:41 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `product_management_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_product`
--

CREATE TABLE `tbl_product` (
  `tbl_product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `tbl_supplier_id` int(11) NOT NULL,
  `purchase` int(11) NOT NULL,
  `selling` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `date_updated` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_product`
--

INSERT INTO `tbl_product` (`tbl_product_id`, `product_name`, `tbl_supplier_id`, `purchase`, `selling`, `stock`, `date_updated`) VALUES
(1, 'Product 1', 1, 100, 120, 50, '2024-02-05 08:21:37'),
(2, 'Product 2', 1, 150, 180, 60, '2024-02-05 08:22:26'),
(3, 'Product 3', 3, 80, 100, 30, '2024-02-05 08:21:37'),
(4, 'Product 4', 4, 200, 220, 70, '2024-02-05 08:21:37'),
(5, 'Product 5', 1, 90, 110, 40, '2024-02-05 08:22:29'),
(6, 'Product 6', 1, 120, 140, 55, '2024-02-05 08:21:37'),
(7, 'Product 7', 2, 130, 150, 65, '2024-02-05 08:21:37'),
(8, 'Product 8', 3, 70, 90, 35, '2024-02-05 08:21:37'),
(9, 'Product 9', 4, 180, 200, 75, '2024-02-05 08:21:37'),
(10, 'Product 10', 5, 110, 130, 45, '2024-02-05 08:21:37'),
(11, 'Product 11', 1, 130, 150, 60, '2024-02-05 08:21:37'),
(12, 'Product 12', 2, 160, 180, 70, '2024-02-05 08:21:37'),
(13, 'Product 13', 3, 90, 110, 40, '2024-02-05 08:21:37'),
(14, 'Product 14', 4, 220, 240, 80, '2024-02-05 08:21:37'),
(15, 'Product 15', 5, 120, 140, 50, '2024-02-05 08:21:37'),
(16, 'Product 16', 1, 140, 160, 65, '2024-02-05 08:21:37'),
(17, 'Product 17', 2, 170, 190, 75, '2024-02-05 08:21:37'),
(18, 'Product 18', 3, 100, 120, 45, '2024-02-05 08:21:37'),
(19, 'Product 19', 4, 240, 260, 85, '2024-02-05 08:21:37'),
(20, 'Product 20', 5, 130, 150, 55, '2024-02-05 08:21:37'),
(21, 'Product 21', 1, 150, 170, 70, '2024-02-05 08:21:37'),
(22, 'Product 22', 2, 180, 200, 80, '2024-02-05 08:21:37'),
(23, 'Product 23', 3, 110, 130, 50, '2024-02-05 08:21:37'),
(24, 'Product 24', 4, 260, 280, 90, '2024-02-05 08:21:37'),
(25, 'Product 25', 5, 140, 160, 60, '2024-02-05 08:21:37'),
(26, 'Product 26', 1, 160, 180, 75, '2024-02-05 08:21:37'),
(27, 'Product 27', 2, 190, 210, 85, '2024-02-05 08:21:37'),
(28, 'Product 28', 3, 120, 140, 55, '2024-02-05 08:21:37'),
(29, 'Product 29', 4, 280, 300, 95, '2024-02-05 08:21:37'),
(30, 'Product 30', 5, 150, 170, 65, '2024-02-05 08:21:37');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_supplier`
--

CREATE TABLE `tbl_supplier` (
  `tbl_supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `supplier_contact` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_supplier`
--

INSERT INTO `tbl_supplier` (`tbl_supplier_id`, `supplier_name`, `supplier_contact`) VALUES
(1, 'Supplier 1', 'Contact 1'),
(2, 'Supplier 2', 'Contact 2'),
(3, 'Supplier 3', 'Contact 3'),
(4, 'Supplier 4', 'Contact 4'),
(5, 'Supplier 5', 'Contact 5');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_product`
--
ALTER TABLE `tbl_product`
  ADD PRIMARY KEY (`tbl_product_id`);

--
-- Indexes for table `tbl_supplier`
--
ALTER TABLE `tbl_supplier`
  ADD PRIMARY KEY (`tbl_supplier_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_product`
--
ALTER TABLE `tbl_product`
  MODIFY `tbl_product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `tbl_supplier`
--
ALTER TABLE `tbl_supplier`
  MODIFY `tbl_supplier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
