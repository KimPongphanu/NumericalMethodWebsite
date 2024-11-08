-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 07, 2024 at 06:04 PM
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
-- Database: `numerical`
--

-- --------------------------------------------------------

--
-- Table structure for table `lesson`
--

CREATE TABLE `lesson` (
  `id` int(11) NOT NULL,
  `chapter` varchar(255) NOT NULL,
  `date` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lesson`
--

INSERT INTO `lesson` (`id`, `chapter`, `date`) VALUES
(1, 'Root Of Equation', NULL),
(2, 'Linear Algebra', NULL),
(3, 'InterPolation', NULL),
(4, 'Least Square Regression', NULL),
(5, 'Intergration', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `method`
--

CREATE TABLE `method` (
  `id` int(11) NOT NULL,
  `method` varchar(255) NOT NULL,
  `chapter` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `method`
--

INSERT INTO `method` (`id`, `method`, `chapter`) VALUES
(1, 'Bisection Method', 1),
(2, 'False Position', 1),
(3, 'One Point Itreation', 1),
(4, 'Secant Method', 1),
(5, 'Newton Rapson', 1),
(6, 'Cramer\'s Rule', 2),
(7, 'Gauss\'s Elimination Method', 2),
(8, 'Gauss Jordan Method', 2),
(9, 'Inverse Matrix Method', 2),
(10, 'LU Decomposition Method', 2),
(11, 'Cholesky Decomposition Method', 2),
(12, 'Jacobi Iteration Method', 2),
(13, 'Gauss-Seidel Iteration Method', 2),
(14, 'Conjugate Gradient Method', 2),
(15, 'Newton\'s Divided Differences', 3),
(16, 'Lagrange polynomials', 3),
(17, 'Spline interpolation', 3),
(18, 'LINEAR REGRESSION', 4),
(19, 'POLYNOMIAL REGRESSION', 4),
(20, 'MULTIPLE LINEAR REGRESSION', 4),
(21, 'Trapezoidal Rule', 5),
(22, 'Composite Trapezoidal Rule', 5),
(23, 'Simpson\'s Rule', 5),
(24, 'Composite Simpson\'s Rule', 5),
(25, 'Newton Cotes Integration Formulas', 5),
(26, 'Romberg Integration', 5),
(27, 'Gauss Quadrature', 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `lesson`
--
ALTER TABLE `lesson`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `method`
--
ALTER TABLE `method`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `lesson`
--
ALTER TABLE `lesson`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `method`
--
ALTER TABLE `method`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
