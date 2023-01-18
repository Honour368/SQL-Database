-- phpMyAdmin SQL Dump
-- version 4.6.6deb5ubuntu0.5
-- https://www.phpmyadmin.net/
--
-- Host: sophia
-- Generation Time: Apr 18, 2021 at 12:48 AM
-- Server version: 5.7.33-0ubuntu0.18.04.1
-- PHP Version: 7.2.24-0ubuntu0.18.04.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `h3543589`
--

-- --------------------------------------------------------

--
-- Table structure for table `Course`
--

CREATE TABLE `Course` (
  `day_of_week` varchar(20) NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  -- `duration` int(11) DEFAULT NULL,
  `course_id` varchar(20) NOT NULL,
  `course_title` varchar(100) DEFAULT NULL,
  `course_materials` VARCHAR(500) DEFAULT NULL,
  --`teacher's message` VARCHAR(500) DEFAULT NULL,
  `links_of_zoom` varchar(500) DEFAULT NULL,
  PRIMARY KEY(course_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Course`
--

INSERT INTO `Course` (`day_of_week`, `start_time`, `end_time`, `course_id`, `course_title`, `course_materials`, `links_of_zoom`) VALUES
('Friday', '12:30:00', '14:30:00', 'COMP3250', 'Design and Analysis of Algorithm', 'https://drive.google.com/drive/folders/1Nl--ADfUScgU8j-GOxUh-dD3RJFqyHSN?usp=sharing', "https://hku.zoom.us/j/92190115412"),
('Tuesday', '9:30:00', '11:30:00', 'COMP3278', 'Introduction to database and management systems', 'https://drive.google.com/drive/folders/1bK5F71hAJIsMr7tx1ZY9FxXdv018dHhD?usp=sharing', "https://hku.zoom.us/j/92190115412"),
('Monday', '11:30:00', '13:30:00', 'ELEC3142', 'Electrical energy conversion', 'https://drive.google.com/drive/folders/1BxYAOR8ofoqutjrYwGU4AIyVg1HG-2Rv?usp=sharing', "https://hku.zoom.us/j/92190115412"),
('Tuesday', '13:30:00', '16:30:00', 'ELEC3241', 'Signals and Linear Systems', 'https://drive.google.com/drive/folders/1eN_Ytqn_Z0mxPv4hTyLw7OIUzLNgRqwq?usp=sharing', "https://hku.zoom.us/j/92190115412"),
('Thursday', '13:30:00', '16:30:00', 'ELEC3848', 'Integrated Design Project', 'https://drive.google.com/drive/folders/1ZrVkKbnpNbEtQ9rINnS8b7VzLvy6umD4?usp=sharing', "https://hku.zoom.us/j/92190115412"),
('Monday', '9:30:00', '11:30:00', 'COMP3270', 'Artificial Intelligence', 'https://drive.google.com/drive/folders/1ME_63DjZLpNOpBbr60bD-1KY-RnFSuJa?usp=sharing', "https://hku.zoom.us/j/92190115412"),
('Wednesday', '6:30:00', '9:30:00', 'ELEC3249', 'Pattern Recognition', 'https://drive.google.com/drive/folders/1kiUipX9hO26XPUdgcR5enAhWSbfGeIbC?usp=sharing', "https://hku.zoom.us/j/92190115412"),
('Friday', '9:30:00', '11:30:00', 'ELEC2844', 'Probabilistic Systems', 'https://drive.google.com/drive/folders/1C63rPgewQr6tn_JboN6PBXXX3r3fFbtR?usp=sharing', "https://hku.zoom.us/j/92190115412"),

--('Friday', '12:30:00', '14:30:00', 'COMP3250', 'Artificial Intelligence', 'https://drive.google.com/drive/folders/18JYolTZtSlc9q4kwquKTPXmmB334scJF?usp=sharing'),
--('Tuesday', '12:30', '13:30', 'COMP3250', 'Artificial Intelligence', 'NA'),
--('Friday', '12:30', '14:30', 'COMP3250', 'Artificial Intelligence', 'NA'),
--('Tuesday', '12:30', '13:30', 'COMP3250', 'Artificial Intelligence', 'NA'),
--('Friday', '09:30', '11:30', 'COMP3278', 'COMP3278', 'NA'),
--('Tuesday', '09:30', '10:30', 'COMP3278', 'COMP3278', 'NA');

-- --------------------------------------------------------

--
-- Table structure for table `Exam`
--

-- CREATE TABLE `Exam` (
--   `exam_location` varchar(50) DEFAULT NULL,
--   `exam_time` varchar(10) DEFAULT NULL,
--   `exam_zoom_id` int(11) DEFAULT NULL,
--   `course_id` varchar(10) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Exam`
--

CREATE TABLE Classroom
(
  `classroom_id` VARCHAR(20) NOT NULL,
  `classroom_address` VARCHAR(50) NOT NULL,
  PRIMARY KEY(classroom_id)
)  ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

INSERT INTO `Classroom` (`classroom_address`, `classroom_id`) VALUES
('CYM101', '1'),
('LT8', '2'),
('LG109', '3'),
('LT4', '4');

--
-- Table structure for table `Instruct`
--

CREATE TABLE `Instruct` (
  `course_id` varchar(20) NOT NULL,
  `instructor_id` bigint NOT NULL,
  PRIMARY KEY(course_id, instructor_id),
  FOREIGN KEY(course_id) REFERENCES Course(course_id),
  FOREIGN KEY(instructor_id) REFERENCES Instructor(instructor_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Instruct` (`course_id`, `instructor_id`) VALUES 
('COMP3250', 3034778384),
('COMP3278', 3034778393),
('COMP3270', 3034778384),
('ELEC3142', 3034778361),
('ELEC3241', 3034778372),
('ELEC3848', 3034778372),
('ELEC2844', 3034778361);

-- --------------------------------------------------------

--
-- Table structure for table `Instructor`
--

CREATE TABLE `Instructor` (
  `instructor_id` bigint(11) NOT NULL,
  `instructor_name` VARCHAR(50),
  PRIMARY KEY(instructor_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Instructor` (`instructor_id`, `instructor_name`) VALUES 
('3034778393', 'Luo Ping'),
('3034778384', 'Pawan Gupta'),
('3034778372', 'Thomas Kwan'),
('3034778361', 'Thomas Edison');
-- --------------------------------------------------------

--
-- Table structure for table `Lecture`
--

-- CREATE TABLE `Lecture` (
--   `lecturer` varchar(50) DEFAULT NULL,
--   `course_materials` varchar(200) DEFAULT NULL,
--   `course_information` varchar(500) DEFAULT NULL,
--   `course_id_subclass` varchar(20) DEFAULT NULL,
--   `day_of_week` varchar(20) DEFAULT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Lecture`
--

-- INSERT INTO `Lecture` (`lecturer`, `course_materials`, `course_information`, `course_id_subclass`, `day_of_week`) VALUES
-- ('Ping Luo', 'https://app.luminpdf.com/viewer/607b009d79280c001234ca69', 'https://www.cs.hku.hk/index.php/programmes/course-offered?infile=2020/comp3278.html', 'COMP3278_A', 'Friday'),
-- ('Zhi Yi Huang', 'https://app.luminpdf.com/viewer/607b0f2e79280c001234cbc2', 'https://www.cs.hku.hk/index.php/programmes/course-offered?infile=2020/comp3250.html', 'COMP3250_A', 'Tuesday');

-- --------------------------------------------------------

--
-- Table structure for table `Location`
--

CREATE TABLE `Located` (
  `classroom_id` varchar(20) DEFAULT NULL,
  `course_id` varchar(20) DEFAULT NULL,
  FOREIGN KEY(course_id) REFERENCES Course(course_id),
  FOREIGN KEY(classroom_id) REFERENCES Classroom(classroom_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Location`
--

INSERT INTO `Located` (`classroom_id`, `course_id`) VALUES
('1', 'COMP3250'),
('1', 'COMP3278'),
('2', 'ELEC3142'),
('2', 'ELEC3241'),
('3', 'ELEC3848'),
('4', 'ELEC3249'),
('4', 'ELEC2844');

-- --------------------------------------------------------

--
-- Table structure for table `Participate`
--

CREATE TABLE `Participate` (
  `username` varchar(20) DEFAULT NULL,
  `course_id` varchar(20) DEFAULT NULL,
  FOREIGN KEY(course_id) REFERENCES Course(course_id),
  FOREIGN KEY(username) REFERENCES Student(username)
 -- `day_of_week` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Participate`
--

INSERT INTO `Participate` (`username`, `course_id`) VALUES
('olatunjih', 'COMP3278'), ('olatunjih', 'COMP3250'), ('olatunjih', 'ELEC3241'), ('olatunjih', 'ELEC3142'), ('olatunjih', 'ELEC3848'),
('shid', 'COMP3278'), ('shid', 'COMP3270'), ('shid', 'ELEC2844'), ('shid', 'ELEC3249'), ('shid', 'COMP3250');

-- --------------------------------------------------------

--
-- Table structure for table `Sit_for`
--

-- CREATE TABLE `Sit_for` (
--   `username` varchar(20) DEFAULT NULL,
--   `course_id` varchar(20) DEFAULT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Student`
--

CREATE TABLE `Student` (
  `student_name` varchar(50) DEFAULT NULL,
  `username` varchar(20) NOT NULL,
  `faculty` varchar(20) DEFAULT NULL,
  `student_id` bigint(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `login_time` DATETIME DEFAULT NULL,
  `logout_time` DATETIME DEFAULT NULL,
  `login_duration` INT DEFAULT NULL,
  PRIMARY KEY(username)
  -- `student_zoom_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Student`
--

INSERT INTO `Student` (`student_name`, `username`, `faculty`, `student_id`, `email`, `year`) VALUES
('Honour Olatunji', 'olatunjih', 'Engineering', 3035553484, 'hk0368@hku.hk', 3),
('Daniel Xing-Han Shi', 'shid', 'Science', 3035435890, 'u3543589@hku.hk', 4),
('John Smith', 'smithj', 'Business & Economics', 3034567890, 'smithj@hku.hk', 3);

-- --------------------------------------------------------

--
-- Table structure for table `Tutorial`
--

CREATE TABLE `Tutorial` (
  `tutor_name` varchar(50) DEFAULT NULL,;
  `tutorial_materials` varchar(500) DEFAULT NULL,
  `tutorial_id` int(11) NOT NULL,
  `course_id` VARCHAR(20),
  PRIMARY KEY(tutorial_id),
  FOREIGN KEY(course_id) REFERENCES Course(course_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Tutorial` (`tutor_name`, `tutorial_materials`, `tutorial_id`, `course_id`) VALUES 
('Saad Shahid', 'https://drive.google.com/drive/folders/126mXylRYbxDzpi0LEVKhrzdT9ZsmV2BB?usp=sharing', '1', 'COMP3270'),
('Saad Shahid', 'https://drive.google.com/drive/folders/1Qo6702wVH9pqFsLNQhP9I5oYtZGVus-j?usp=sharing', '2', 'COMP3278'),
('Saad Shahid', 'https://drive.google.com/drive/folders/1Qo6702wVH9pqFsLNQhP9I5oYtZGVus-j?usp=sharing', '3', 'COMP3250'),
('Lim Le Chi', 'https://drive.google.com/drive/folders/1Qo6702wVH9pqFsLNQhP9I5oYtZGVus-j?usp=sharing', '4', 'ELEC3241'),
('Lim Le Chi', 'https://drive.google.com/drive/folders/1Qo6702wVH9pqFsLNQhP9I5oYtZGVus-j?usp=sharing', '5', 'ELEC3142'),
('Mwai Martin', 'https://drive.google.com/drive/folders/1Qo6702wVH9pqFsLNQhP9I5oYtZGVus-j?usp=sharing', '6', 'ELEC2844'),
('Luo Ping', 'https://drive.google.com/drive/folders/1Qo6702wVH9pqFsLNQhP9I5oYtZGVus-j?usp=sharing', '7', 'ELEC3249');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Course`
--
-- ALTER TABLE `Course`
--   ADD PRIMARY KEY (`course_id_subclass`,`day_of_week`);

--
-- Indexes for table `Exam`
--
-- ALTER TABLE `Exam`
--   ADD PRIMARY KEY (`course_id`);

--
-- Indexes for table `Instructor`
--
-- ALTER TABLE `Instructor`
--   ADD PRIMARY KEY (`instructor_id`);

--
-- Indexes for table `Student`
--
-- ALTER TABLE `Student`
--   ADD PRIMARY KEY (`username`);

--
-- Indexes for table `Tutorial`
--
-- ALTER TABLE `Tutorial`
--   ADD PRIMARY KEY (`tutorial_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
