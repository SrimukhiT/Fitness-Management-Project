-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 23, 2025 at 05:21 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fitness`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`) VALUES
(0, 'admin', '123');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `Name` varchar(30) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Age` varchar(10) NOT NULL,
  `Height_cm` varchar(30) NOT NULL,
  `Weight_kg` varchar(10) NOT NULL,
  `Address` varchar(50) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `Mobile` varchar(10) NOT NULL,
  `Fitness_Goal` varchar(100) NOT NULL,
  `Status` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`Name`, `Password`, `Gender`, `Age`, `Height_cm`, `Weight_kg`, `Address`, `Email`, `Mobile`, `Fitness_Goal`, `Status`) VALUES
('anusha', '456', 'female', '20', '155', '43', 'nizamabad', 'anusha@gmail.com', '9123748563', 'increase weight', 1),
('hasini', '890', 'female', '20', '159', '46', 'hyderabad ', 'hasini@gmail.com', '9587436452', 'increase weight', 1),
('kavya', '789', 'female', '19', '152', '45', 'nirmal', 'kavya@gmail.com', '9635741156', 'increase weight', 1),
('sri', '123', 'female', '19', '155', '45', 'hyderabad', 'pqr@gmial.com', '9528746370', 'gain weight', 1),
('satwika', '000', 'female', '21', '158', '45', 'adilabad', 'satwika@gmail.com', '9874561475', 'increase weight', 1),
('srimukhi', '234', 'female', '20', '153', '43', 'nizamabad', 'srimukhi@gmail.com', '9123456780', 'reduce weight', 1),
('vineela', '345', 'female', '18', '159', '49', 'warangal', 'vineela@gmail.com', '9457812638', 'reduce weight', 0);

-- --------------------------------------------------------

--
-- Table structure for table `workout`
--

CREATE TABLE `workout` (
  `Date` varchar(30) NOT NULL,
  `Weight` varchar(20) NOT NULL,
  `BMI` double NOT NULL,
  `Status` int(10) NOT NULL,
  `Email` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `workout`
--

INSERT INTO `workout` (`Date`, `Weight`, `BMI`, `Status`, `Email`) VALUES
('2025-05-06', '60.0', 26.666666666666668, 1, 'sri@gmail.com'),
('2025-05-06', '60.0', 26.666666666666668, 1, 'sri@gmail.com'),
('2025-05-06', '60.0', 26.666666666666668, 1, 'sri@gmail.com'),
('2025-05-06', '40.0', 94.67455621301774, 1, 'abc@gmial.com'),
('2025-05-06', '39.0', 92.30769230769229, 1, 'abc@gmial.com'),
('2025-05-06', '56.0', 132.54437869822485, 1, 'abc@gmial.com'),
('2025-05-07', '58.0', 25.77777777777778, 1, 'sri@gmail.com'),
('2025-05-07', '44.0', 18.314255983350673, 1, 'pqr@gmial.com'),
('2025-05-08', '35.0', 82.84023668639053, 1, 'abc@gmial.com'),
('2025-05-08', '50.0', 19.77769866698311, 1, 'hasini@gmail.com'),
('2025-05-08', '45.0', 19.223375624759708, 1, 'kavya@gmail.com'),
('2025-05-08', '39.0', 17.333333333333332, 1, 'anusha@gmail.com'),
('2025-05-09', '59.0', 26.22222222222222, 1, 'sri@gmail.com'),
('2025-05-09', '42.5', 16.81104386693564, 1, 'hasini@gmail.com'),
('2025-05-28', '59.0', 26.22222222222222, 1, 'sri@gmail.com'),
('2025-05-28', '41.0', 18.22222222222222, 1, 'anusha@gmail.com'),
('2025-05-28', '44.0', 17.404374826945133, 1, 'hasini@gmail.com'),
('2025-05-28', '42.0', 17.941817249775728, 1, 'kavya@gmail.com'),
('2025-05-28', '44.0', 18.79618949976505, 1, 'srimukhi@gmail.com'),
('2025-05-28', '46.0', 19.14672216441207, 1, 'pqr@gmial.com'),
('2025-05-30', '49.0', 20.39542143600416, 1, 'pqr@gmial.com'),
('2025-05-31', '44.0', 18.79618949976505, 1, 'srimukhi@gmail.com'),
('2025-05-31', '47.0', 19.562955254942764, 1, 'pqr@gmial.com'),
('2025-05-31', '45.0', 18.730489073881373, 1, 'anusha@gmail.com'),
('2025-05-31', '150.0', 64.92382271468144, 1, 'kavya@gmail.com'),
('2025-06-25', '50.0', 21.35930624973301, 1, 'srimukhi@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD KEY `id` (`id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`Email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

