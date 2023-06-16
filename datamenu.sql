-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 19, 2023 at 05:11 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `datamenu`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `bikin_id_menu` (`jenis_mn` CHAR(2)) RETURNS CHAR(7) CHARSET utf8mb4 BEGIN
DECLARE jenis CHAR(2);
DECLARE urut CHAR(3);
DECLARE v_id CHAR(7);
SELECT jenis_mn INTO jenis;
SELECT RIGHT(COUNT(*)+1001,3) INTO urut FROM menu WHERE jenis_menu_id = jenis_mn;
SELECT concat("21",jenis,urut) INTO v_id;
RETURN v_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `jenis_menu`
--

CREATE TABLE `jenis_menu` (
  `id` char(2) NOT NULL,
  `nama_jenis_menu` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jenis_menu`
--

INSERT INTO `jenis_menu` (`id`, `nama_jenis_menu`) VALUES
('01', 'MAKANAN'),
('02', 'MINUMAN'),
('03', 'CEMILAN'),
('04', 'CUCI MULUT');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id_menu` char(7) NOT NULL,
  `nama_menu` varchar(45) NOT NULL,
  `harga_menu` int(11) NOT NULL,
  `stok` int(4) DEFAULT NULL,
  `jenis_menu_id` char(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id_menu`, `nama_menu`, `harga_menu`, `stok`, `jenis_menu_id`) VALUES
('1201009', 'Sate Ayam', 20000, 120, '01'),
('2101001', 'Nasi Goreng', 14000, 13, '01'),
('2101002', 'Nasi Bakar', 10000, 19, '01'),
('2101003', 'Nasi Remes', 11000, 12, '01'),
('2101004', 'Nasi Lengko', 7000, 21, '01'),
('2101005', 'Nasi Lemak', 13000, 41, '01'),
('2101006', 'Ayam Bakar', 17000, 4, '01'),
('2101007', 'Ayam Goreng', 18000, 12, '01'),
('2101008', 'Ayam Penyet', 14000, 41, '01'),
('2101010', 'Sate Kambing', 45000, 12, '01'),
('2101011', 'Ayam Banting', 17000, 53, '01'),
('2101013', 'Gorengan', 2000, 10, '01'),
('2102001', 'Air Putih', 1000, 23, '02'),
('2102002', 'Es Teh Manis', 4000, 4, '02'),
('2102003', 'Es Jeruk', 5000, 1, '02'),
('2102004', 'Es Mangga', 7000, 24, '01'),
('2102005', 'Es Alpukat', 8000, 14, '02'),
('2103001', 'Gorengan', 1500, 9, '03'),
('2103002', 'Nugget', 2000, 35, '03'),
('2103003', 'Pempek', 6000, 29, '03'),
('2103004', 'Sosis Bakar', 18000, 31, '03'),
('2104001', 'Puding', 5000, 12, '04'),
('2104002', 'Kentang Goreng', 13000, 24, '04'),
('2104003', 'Manisan', 11000, 32, '04');

--
-- Triggers `menu`
--
DELIMITER $$
CREATE TRIGGER `masuk_id_menu` BEFORE INSERT ON `menu` FOR EACH ROW BEGIN
DECLARE new_id CHAR(7);
SELECT bikin_id_menu(NEW.jenis_menu_id) into new_id;
SET NEW.id_menu = new_id;

END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `jenis_menu`
--
ALTER TABLE `jenis_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id_menu`),
  ADD KEY `menu_jenis_menu_fk` (`jenis_menu_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `menu_jenis_menu_fk` FOREIGN KEY (`jenis_menu_id`) REFERENCES `jenis_menu` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
