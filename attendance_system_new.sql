-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 23, 2021 at 11:59 AM
-- Server version: 8.0.23
-- PHP Version: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `attendance system new`
--

-- --------------------------------------------------------

--
-- Table structure for table `classroom`
--

CREATE TABLE `classroom` (
  `classroom_id` varchar(20) NOT NULL,
  `classroom_address` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `classroom`
--

INSERT INTO `classroom` (`classroom_id`, `classroom_address`) VALUES
('1', 'CYM101'),
('2', 'LT8'),
('3', 'LG109'),
('4', 'LT4');

-- --------------------------------------------------------

--
-- Table structure for table `course`
--

CREATE TABLE `course` (
  `day_of_week` int NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `course_id` varchar(20) NOT NULL,
  `course_title` varchar(100) DEFAULT NULL,
  `course_materials` varchar(500) DEFAULT NULL,
  `links_of_zoom` varchar(500) DEFAULT NULL,
  `courseinfo` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `course`
--

INSERT INTO `course` (`day_of_week`, `start_time`, `end_time`, `course_id`, `course_title`, `course_materials`, `links_of_zoom`, `courseinfo`) VALUES
(4, '11:30:00', '13:30:00', 'COMP3250', 'Design and Analysis of Algorithm', 'https://drive.google.com/drive/folders/1Nl--ADfUScgU8j-GOxUh-dD3RJFqyHSN?usp=sharing', 'https://hku.zoom.us/j/92190115412', 'https://www.cs.hku.hk/index.php/programmes/course-offered?infile=2019/comp3250.html'),
(0, '09:30:00', '11:30:00', 'COMP3270', 'Artificial Intelligence', 'https://drive.google.com/drive/folders/1ME_63DjZLpNOpBbr60bD-1KY-RnFSuJa?usp=sharing', 'https://hku.zoom.us/j/92190115412', 'https://www.cs.hku.hk/index.php/programmes/course-offered?infile=2019/comp3270.html'),
(1, '09:30:00', '11:30:00', 'COMP3278', 'Introduction to database and management systems', 'https://drive.google.com/drive/folders/1bK5F71hAJIsMr7tx1ZY9FxXdv018dHhD?usp=sharing', 'https://hku.zoom.us/j/92190115412', 'https://www.cs.hku.hk/index.php/programmes/course-offered?infile=2019/comp3278.html'),
(4, '09:30:00', '11:30:00', 'ELEC2844', 'Probabilistic Systems', 'https://drive.google.com/drive/folders/1C63rPgewQr6tn_JboN6PBXXX3r3fFbtR?usp=sharing', 'https://hku.zoom.us/j/92190115412', 'https://www.eee.hku.hk/~elec2844/sp21/index.html'),
(0, '11:30:00', '13:30:00', 'ELEC3142', 'Electrical energy conversion', 'https://drive.google.com/drive/folders/1BxYAOR8ofoqutjrYwGU4AIyVg1HG-2Rv?usp=sharing', 'https://hku.zoom.us/j/92190115412', 'https://www.eee.hku.hk/elink/ug_courses20132014-4.html'),
(1, '13:30:00', '16:30:00', 'ELEC3241', 'Signals and Linear Systems', 'https://drive.google.com/drive/folders/1eN_Ytqn_Z0mxPv4hTyLw7OIUzLNgRqwq?usp=sharing', 'https://hku.zoom.us/j/92190115412', 'https://www.eee.hku.hk/elink/ug_courses20132014-4.html'),
(2, '06:30:00', '09:30:00', 'ELEC3249', 'Pattern Recognition', 'https://drive.google.com/drive/folders/1kiUipX9hO26XPUdgcR5enAhWSbfGeIbC?usp=sharing', 'https://hku.zoom.us/j/92190115412', 'https://www.eee.hku.hk/elink/ug_courses20182019.html'),
(3, '13:30:00', '16:30:00', 'ELEC3848', 'Integrated Design Project', 'https://drive.google.com/drive/folders/1ZrVkKbnpNbEtQ9rINnS8b7VzLvy6umD4?usp=sharing', 'https://hku.zoom.us/j/92190115412', 'https://www.eee.hku.hk/elink/ug_courses20132014-4.html');

-- --------------------------------------------------------

--
-- Table structure for table `instruct`
--

CREATE TABLE `instruct` (
  `course_id` varchar(20) NOT NULL,
  `instructor_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `instruct`
--

INSERT INTO `instruct` (`course_id`, `instructor_id`) VALUES
('ELEC2844', 3034778361),
('ELEC3142', 3034778361),
('ELEC3241', 3034778372),
('ELEC3848', 3034778372),
('COMP3250', 3034778384),
('COMP3270', 3034778384),
('COMP3278', 3034778393);

-- --------------------------------------------------------

--
-- Table structure for table `instructor`
--

CREATE TABLE `instructor` (
  `instructor_id` bigint NOT NULL,
  `instructor_name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `instructor`
--

INSERT INTO `instructor` (`instructor_id`, `instructor_name`) VALUES
(3034778361, 'Thomas Edison'),
(3034778372, 'Thomas Kwan'),
(3034778384, 'Pawan Gupta'),
(3034778393, 'Luo Ping');

-- --------------------------------------------------------

--
-- Table structure for table `located`
--

CREATE TABLE `located` (
  `classroom_id` varchar(20) DEFAULT NULL,
  `course_id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `located`
--

INSERT INTO `located` (`classroom_id`, `course_id`) VALUES
('1', 'COMP3250'),
('1', 'COMP3278'),
('2', 'ELEC3142'),
('2', 'ELEC3241'),
('3', 'ELEC3848'),
('4', 'ELEC3249'),
('4', 'ELEC2844');

-- --------------------------------------------------------

--
-- Table structure for table `participate`
--

CREATE TABLE `participate` (
  `username` varchar(20) DEFAULT NULL,
  `course_id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `participate`
--

INSERT INTO `participate` (`username`, `course_id`) VALUES
('olatunjih', 'COMP3278'),
('olatunjih', 'COMP3250'),
('olatunjih', 'ELEC3241'),
('olatunjih', 'ELEC3142'),
('olatunjih', 'ELEC3848'),
('shid', 'COMP3278'),
('shid', 'COMP3270'),
('shid', 'ELEC3249'),
('shid', 'ELEC2844');

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_name` varchar(50) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `faculty` varchar(20) DEFAULT NULL,
  `student_id` bigint DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `login_time` time DEFAULT NULL,
  `login_date` date DEFAULT NULL,
  `logout_time` time DEFAULT NULL,
  `login_duration` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_name`, `username`, `faculty`, `student_id`, `email`, `year`, `login_time`, `login_date`, `logout_time`, `login_duration`) VALUES
('Honour Olatunji', 'olatunjih', 'Engineering', 3035553484, 'hko368@connect.hku.hk', 3, '11:43:09', '2021-04-23', '11:45:32', '00:02:23'),
('Wendy Lee', 'shid', 'Science', 3035435890, 'u3543766@connect.hku.hk', 4, '11:46:16', '2021-04-23', '11:46:48', '00:00:32'),
('John Smith', 'smithj', 'Business & Economics', 3034567890, 'smithj@hku.hk', 3, NULL, '0000-00-00', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tutorial`
--

CREATE TABLE `tutorial` (
  `tutor_name` varchar(50) DEFAULT NULL,
  `tutorial_materials` varchar(500) DEFAULT NULL,
  `tutorial_id` int NOT NULL,
  `course_id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tutorial`
--

INSERT INTO `tutorial` (`tutor_name`, `tutorial_materials`, `tutorial_id`, `course_id`) VALUES
('Saad Shahid', 'https://drive.google.com/drive/folders/126mXylRYbxDzpi0LEVKhrzdT9ZsmV2BB?usp=sharing', 1, 'COMP3270'),
('Saad Shahid', 'https://drive.google.com/drive/folders/1Qo6702wVH9pqFsLNQhP9I5oYtZGVus-j?usp=sharing', 2, 'COMP3278'),
('Saad Shahid', 'https://drive.google.com/drive/folders/1Qo6702wVH9pqFsLNQhP9I5oYtZGVus-j?usp=sharing', 3, 'COMP3250'),
('Lim Le Chi', 'https://drive.google.com/drive/folders/1Qo6702wVH9pqFsLNQhP9I5oYtZGVus-j?usp=sharing', 4, 'ELEC3241'),
('Lim Le Chi', 'https://drive.google.com/drive/folders/1Qo6702wVH9pqFsLNQhP9I5oYtZGVus-j?usp=sharing', 5, 'ELEC3142'),
('Mwai Martin', 'https://drive.google.com/drive/folders/1Qo6702wVH9pqFsLNQhP9I5oYtZGVus-j?usp=sharing', 6, 'ELEC2844'),
('Luo Ping', 'https://drive.google.com/drive/folders/1Qo6702wVH9pqFsLNQhP9I5oYtZGVus-j?usp=sharing', 7, 'ELEC3249');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `classroom`
--
ALTER TABLE `classroom`
  ADD PRIMARY KEY (`classroom_id`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`course_id`);

--
-- Indexes for table `instruct`
--
ALTER TABLE `instruct`
  ADD PRIMARY KEY (`course_id`,`instructor_id`),
  ADD KEY `instructor_id` (`instructor_id`);

--
-- Indexes for table `instructor`
--
ALTER TABLE `instructor`
  ADD PRIMARY KEY (`instructor_id`);

--
-- Indexes for table `located`
--
ALTER TABLE `located`
  ADD KEY `course_id` (`course_id`),
  ADD KEY `classroom_id` (`classroom_id`);

--
-- Indexes for table `participate`
--
ALTER TABLE `participate`
  ADD KEY `course_id` (`course_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `tutorial`
--
ALTER TABLE `tutorial`
  ADD PRIMARY KEY (`tutorial_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `instruct`
--
ALTER TABLE `instruct`
  ADD CONSTRAINT `instruct_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  ADD CONSTRAINT `instruct_ibfk_2` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`);

--
-- Constraints for table `located`
--
ALTER TABLE `located`
  ADD CONSTRAINT `located_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  ADD CONSTRAINT `located_ibfk_2` FOREIGN KEY (`classroom_id`) REFERENCES `classroom` (`classroom_id`);

--
-- Constraints for table `participate`
--
ALTER TABLE `participate`
  ADD CONSTRAINT `participate_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  ADD CONSTRAINT `participate_ibfk_2` FOREIGN KEY (`username`) REFERENCES `student` (`username`);

--
-- Constraints for table `tutorial`
--
ALTER TABLE `tutorial`
  ADD CONSTRAINT `tutorial_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
