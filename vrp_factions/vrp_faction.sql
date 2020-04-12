-- phpMyAdmin SQL Dump
-- version 4.4.15.10
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 06, 2019 at 04:37 PM
-- Server version: 10.2.22-MariaDB
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


--
-- Table structure for table `vrp_factions`
--

CREATE TABLE IF NOT EXISTS `vrp_factions` (
  `id` int(255) NOT NULL,
  `faction` text NOT NULL,
  `isFactionLeader` int(255) NOT NULL DEFAULT 0,
  `isFactionCoLeader` int(255) NOT NULL DEFAULT 0,
  `factionRank` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for table `vrp_factions`
--
ALTER TABLE `vrp_factions`
  ADD PRIMARY KEY (`id`);
  
  --
-- AUTO_INCREMENT for table `vrp_factions`
--
ALTER TABLE `vrp_factions`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;
  
  
  