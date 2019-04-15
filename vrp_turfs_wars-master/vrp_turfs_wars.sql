-- phpMyAdmin SQL Dump
-- version 4.4.15.10
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 15, 2019 at 05:24 PM
-- Server version: 10.2.22-MariaDB
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Table structure for table `vrp_turfs_wars`
--

CREATE TABLE IF NOT EXISTS `vrp_turfs_wars` (
  `id` int(255) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `radius` float NOT NULL,
  `blipColor` int(255) NOT NULL,
  `faction` text NOT NULL,
  `locatie` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vrp_turfs_wars`
--

INSERT INTO `vrp_turfs_wars` (`id`, `x`, `y`, `z`, `radius`, `blipColor`, `faction`, `locatie`) VALUES
(1, -1035.77, -1136.99, 2.05392, 70, 1, 'None', 'Los Santos'),
(2, -1239.04, 488.837, 93.4268, 70, 2, 'None', 'Las Aventuras'),
(3, 104.085, -1935.77, 20.8037, 70, 3, 'None', 'San Francisco'),
(4, 754.544, 1306.67, 360.068, 70, 5, 'None', 'California'),
(5, 1365.38, -577.602, 74.3803, 70, 27, 'None', 'Grove Street');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `vrp_turfs`
--
ALTER TABLE `vrp_turfs_wars`
  ADD PRIMARY KEY (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
