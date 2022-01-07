-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 29, 2021 at 08:11 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.3.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_olshop`
--

-- --------------------------------------------------------

--
-- Table structure for table `cabang`
--

CREATE TABLE `cabang` (
  `id` int(11) NOT NULL,
  `userid` varchar(50) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `kota` varchar(50) NOT NULL,
  `provinsi` varchar(50) NOT NULL,
  `kodepos` varchar(50) NOT NULL,
  `telp` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cabang`
--

INSERT INTO `cabang` (`id`, `userid`, `nama`, `alamat`, `kota`, `provinsi`, `kodepos`, `telp`, `email`) VALUES
(1, 'malang', 'Malang', 'Jl. Singosari No. 4', 'Malang', 'Jawa Timur', '', '08912345', 'malang@gmail.com'),
(2, 'probolinggo', 'Probolinggo', 'Jl. Hos Cokroaminoto No. 7', 'Probolinggo', 'Jawa Timur', '', '08956789', 'prolink@gmail.com'),
(3, 'jember', 'Jember', 'Jl. Pemuda Harapan', 'Jember', 'Jawa Timur', '', '08954321', 'jember@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `conter`
--

CREATE TABLE `conter` (
  `jual` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `conter`
--

INSERT INTO `conter` (`jual`) VALUES
(25);

-- --------------------------------------------------------

--
-- Table structure for table `favorite`
--

CREATE TABLE `favorite` (
  `id` int(11) NOT NULL,
  `userid` varchar(50) NOT NULL,
  `idproduk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `favorite`
--

INSERT INTO `favorite` (`id`, `userid`, `idproduk`) VALUES
(8, 'user', 2);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id`, `nama`) VALUES
(1, 'Soffa'),
(2, 'Chair'),
(3, 'Table'),
(4, 'Cupboard');

-- --------------------------------------------------------

--
-- Table structure for table `notifikasi`
--

CREATE TABLE `notifikasi` (
  `Id` int(11) NOT NULL,
  `tanggal` datetime NOT NULL,
  `userid` varchar(50) NOT NULL,
  `useridto` varchar(50) NOT NULL,
  `judul` varchar(50) NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `flag` varchar(50) NOT NULL,
  `st` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id` int(11) NOT NULL,
  `userid` varchar(50) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `alamat` varchar(50) NOT NULL,
  `kota` varchar(50) NOT NULL,
  `provinsi` varchar(50) NOT NULL,
  `kodepos` varchar(50) NOT NULL,
  `telp` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id`, `userid`, `nama`, `alamat`, `kota`, `provinsi`, `kodepos`, `telp`, `email`) VALUES
(1, 'user', 'wawan', 'Jl. Maju Mapan', 'Malang', 'Jawa Timur', '0000', '12345', 'user@gmail.com'),
(5, 'gusti', 'gusti', 'Jl.Kedung Menjangan', 'cirebon', '', '', '081949329862', 'gusti@gmail.com'),
(6, 'qwerty', 'qwerty', 'jl.kedungmenjangan', '', '', '', '081949329862', 'qwerty@gmail.com'),
(7, 'gusti', 'gusti', 'jl kedung menjangan', 'cirebon', '', '', '081949329862', 'gusti@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `id` int(11) NOT NULL,
  `nota` varchar(100) NOT NULL,
  `tanggal` datetime NOT NULL,
  `idproduk` int(11) NOT NULL,
  `judul` varchar(50) NOT NULL,
  `harga` double NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `userid` varchar(50) NOT NULL,
  `idcabang` int(11) NOT NULL,
  `flag` varchar(50) NOT NULL,
  `st` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penjualan`
--

INSERT INTO `penjualan` (`id`, `nota`, `tanggal`, `idproduk`, `judul`, `harga`, `thumbnail`, `jumlah`, `userid`, `idcabang`, `flag`, `st`) VALUES
(1, '20211222/0017J', '2021-12-22 07:36:54', 2, 'Meja Makan Oval 6 kursi Minimalis', 4500000, 'dist/images/meja-makan2.jpg', 1, 'user', 1, '', '1'),
(2, '20211222/0017J', '2021-12-22 07:36:54', 3, 'Modern Computer Desk Office Table', 5000000, 'dist/images/meja-kerja1.jpg', 1, 'user', 2, '', '1'),
(3, '20211222/0018J', '2021-12-22 09:09:55', 1, 'Heim Studio TEMMA Meja Makan 160', 2899000, 'dist/images/meja-makan1.jpg', 2, 'user', 2, '', '2'),
(4, '20211229/0019J', '2021-12-29 07:22:46', 1, 'Heim Studio TEMMA Meja Makan 160', 2899000, 'dist/images/meja-makan1.jpg', 1, 'gusti', 1, '', '1'),
(5, '20211229/0020J', '2021-12-29 07:25:52', 1, 'Heim Studio TEMMA Meja Makan 160', 2899000, 'dist/images/meja-makan1.jpg', 1, 'gusti', 2, '', '1'),
(6, '20211229/0021J', '2021-12-29 07:30:08', 1, 'Heim Studio TEMMA Meja Makan 160', 2899000, 'dist/images/meja-makan1.jpg', 1, 'qwerty', 1, '', '1'),
(7, '20211229/0022J', '2021-12-29 07:54:41', 1, 'Heim Studio TEMMA Meja Makan 160', 2899000, 'dist/images/meja-makan1.jpg', 1, 'qwerty', 1, '', '1'),
(8, '20211229/0023J', '2021-12-29 08:00:04', 1, 'Heim Studio TEMMA Meja Makan 160', 2899000, 'dist/images/meja-makan1.jpg', 1, 'qwerty', 2, '', '1'),
(9, '20211229/0023J', '2021-12-29 08:00:04', 2, 'Meja Makan Oval 6 kursi Minimalis', 4500000, 'dist/images/meja-makan2.jpg', 1, 'qwerty', 1, '', '1'),
(10, '20211229/0024J', '2021-12-29 08:07:59', 2, 'Meja Makan Oval 6 kursi Minimalis', 4500000, 'dist/images/meja-makan2.jpg', 1, 'gusti', 1, '', '1');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id` int(11) NOT NULL,
  `idkategori` int(11) NOT NULL,
  `idsubkategori` int(11) NOT NULL,
  `kategori` varchar(50) NOT NULL,
  `subkategori` varchar(50) NOT NULL,
  `judul` varchar(100) NOT NULL,
  `deskripsi` text NOT NULL,
  `harga` double NOT NULL,
  `thumbnail` varchar(255) NOT NULL,
  `st` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id`, `idkategori`, `idsubkategori`, `kategori`, `subkategori`, `judul`, `deskripsi`, `harga`, `thumbnail`, `st`) VALUES
(1, 3, 5, 'Table', 'Dining Table', 'Heim Studio TEMMA Meja Makan 160', 'NONE', 2899000, 'dist/images/meja-makan1.jpg', '1'),
(2, 3, 5, 'Table', 'Dining Table', 'Meja Makan Oval 6 kursi Minimalis', 'NONE', 4500000, 'dist/images/meja-makan2.jpg', '1'),
(3, 3, 6, 'Table', 'Working Table', 'Modern Computer Desk Office Table', 'NONE', 5000000, 'dist/images/meja-kerja1.jpg', '1'),
(4, 3, 6, 'Table', 'Working Table', 'Computer Study Desk Working Table', 'NONE', 3000000, 'dist/images/meja-kerja2.jpg', '1'),
(6, 1, 1, 'Soffa', 'Sectional Soffa', 'Merax Sectional Sofa with Chaise and Ottoman 3-Piece Sofa', 'NONE', 10000000, 'dist/images/sofa1.jpg', '1'),
(7, 1, 1, 'Soffa', 'Sectional Soffa', 'Cooper Sectional Sofa', 'NONE', 12000000, 'dist/images/sofa2.jpg', '1'),
(8, 1, 2, 'Soffa', 'Bed Soffa', 'Heim Studio Kumo Sofa Bed Biru', 'NONE', 5600000, 'dist/images/sofa3.jpg', '1'),
(9, 1, 2, 'Soffa', 'Bed Soffa', 'Factory Cheap Price Sofa Bed', 'NONE', 5000000, 'dist/images/sofa4.jpg', '1');

-- --------------------------------------------------------

--
-- Table structure for table `signin`
--

CREATE TABLE `signin` (
  `id` int(11) NOT NULL,
  `userid` varchar(50) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `level` varchar(1) NOT NULL,
  `email` varchar(50) NOT NULL,
  `foto` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `signin`
--

INSERT INTO `signin` (`id`, `userid`, `pass`, `nama`, `level`, `email`, `foto`, `token`) VALUES
(1, 'user', '1', 'wawan', '3', 'user@gmail.com', 'dist/images/zoro.jpg', ''),
(5, 'gusti', '12345678', 'gusti', '3', 'gusti@gmail.com', '', ''),
(6, 'qwerty', '12345678', 'qwerty', '3', 'qwerty@gmail.com', '', ''),
(7, 'gusti', '12345678', 'gusti', '3', 'gusti@gmail.com', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `stokcabang`
--

CREATE TABLE `stokcabang` (
  `id` int(11) NOT NULL,
  `idcabang` int(11) NOT NULL,
  `idproduk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stokcabang`
--

INSERT INTO `stokcabang` (`id`, `idcabang`, `idproduk`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 4),
(4, 2, 1),
(5, 2, 3),
(6, 2, 6),
(7, 3, 3),
(8, 3, 6),
(9, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `subkategori`
--

CREATE TABLE `subkategori` (
  `id` int(11) NOT NULL,
  `idkategori` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subkategori`
--

INSERT INTO `subkategori` (`id`, `idkategori`, `nama`) VALUES
(1, 1, 'Sectional Soffa'),
(2, 1, 'Bed Soffa'),
(3, 2, 'Side Chair'),
(4, 2, 'Dining Chair'),
(5, 3, 'Dining Table'),
(6, 3, 'Working Table'),
(7, 4, 'Wardrobe'),
(8, 4, 'Document Cabinet');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cabang`
--
ALTER TABLE `cabang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `signin`
--
ALTER TABLE `signin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stokcabang`
--
ALTER TABLE `stokcabang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subkategori`
--
ALTER TABLE `subkategori`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cabang`
--
ALTER TABLE `cabang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `favorite`
--
ALTER TABLE `favorite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `notifikasi`
--
ALTER TABLE `notifikasi`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `penjualan`
--
ALTER TABLE `penjualan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `signin`
--
ALTER TABLE `signin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `stokcabang`
--
ALTER TABLE `stokcabang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `subkategori`
--
ALTER TABLE `subkategori`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
