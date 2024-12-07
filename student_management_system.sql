-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 07, 2024 at 03:59 PM
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
-- Database: `student_management_system`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateCourse` (IN `p_course_id` VARCHAR(10), IN `p_course_name` VARCHAR(100), IN `p_credits` INT)   BEGIN
    UPDATE Courses
    SET course_name = p_course_name, credits = p_credits
    WHERE course_id = p_course_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateGrade` (IN `p_student_id` VARCHAR(10), IN `p_course_id` VARCHAR(10), IN `p_grade` VARCHAR(5))   BEGIN
    UPDATE Grades
    SET grade = p_grade
    WHERE student_id = p_student_id AND course_id = p_course_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateStudent` (IN `p_student_id` VARCHAR(10), IN `p_name` VARCHAR(100), IN `p_email` VARCHAR(100))   BEGIN
    UPDATE Students
    SET name = p_name, email = p_email
    WHERE student_id = p_student_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `course_id` varchar(10) NOT NULL,
  `course_name` varchar(100) NOT NULL,
  `credits` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `courses`
--

INSERT INTO `courses` (`course_id`, `course_name`, `credits`) VALUES
('CSE101', 'Computer Funfamental', 3),
('CSE112', 'Physics 1', 3),
('CSE115', 'Mathematics 1', 3),
('MAT102', 'MATH2', 3);

-- --------------------------------------------------------

--
-- Stand-in structure for view `coursestudents`
-- (See below for the actual view)
--
CREATE TABLE `coursestudents` (
`course_id` varchar(10)
,`course_name` varchar(100)
,`student_id` varchar(10)
,`name` varchar(100)
,`grade` varchar(5)
);

-- --------------------------------------------------------

--
-- Table structure for table `grades`
--

CREATE TABLE `grades` (
  `grade_id` int(11) NOT NULL,
  `student_id` varchar(10) DEFAULT NULL,
  `course_id` varchar(10) DEFAULT NULL,
  `grade` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `grades`
--

INSERT INTO `grades` (`grade_id`, `student_id`, `course_id`, `grade`) VALUES
(1, '1088', 'CSE101', 'A+'),
(2, '1035', 'CSE101', 'A+'),
(3, '1088', 'CSE115', 'B'),
(4, '1086', 'CSE101', 'A+'),
(5, '1085', 'MAT102', 'C'),
(6, '1085', 'CSE101', 'C'),
(7, '1234', 'CSE101', 'A+');

-- --------------------------------------------------------

--
-- Stand-in structure for view `studentcoursegrades`
-- (See below for the actual view)
--
CREATE TABLE `studentcoursegrades` (
`student_id` varchar(10)
,`name` varchar(100)
,`email` varchar(100)
,`course_id` varchar(10)
,`course_name` varchar(100)
,`grade` varchar(5)
);

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `student_id` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`student_id`, `name`, `email`) VALUES
('0000', 'Faruk', 'faruk@diu.edu.bd'),
('1020', 'Osama', 'osama@diu.edu.bd'),
('1035', 'Mahdi', 'mahdi@diu.edu.bd'),
('1064', 'Shahariar', 'shahariar@diu.edu.bd'),
('1085', 'Bappy', 'bappy@diu.edu.bd'),
('1086', 'Naimul', 'naimul@diu.edu.bd'),
('1088', 'TUHIN', 'jalal@diu.edu.bd'),
('1234', 'Mehebob', 'mehebob@diu.edu.bd');

-- --------------------------------------------------------

--
-- Structure for view `coursestudents`
--
DROP TABLE IF EXISTS `coursestudents`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `coursestudents`  AS SELECT `c`.`course_id` AS `course_id`, `c`.`course_name` AS `course_name`, `s`.`student_id` AS `student_id`, `s`.`name` AS `name`, `g`.`grade` AS `grade` FROM ((`courses` `c` left join `grades` `g` on(`c`.`course_id` = `g`.`course_id`)) left join `students` `s` on(`g`.`student_id` = `s`.`student_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `studentcoursegrades`
--
DROP TABLE IF EXISTS `studentcoursegrades`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `studentcoursegrades`  AS SELECT `s`.`student_id` AS `student_id`, `s`.`name` AS `name`, `s`.`email` AS `email`, `c`.`course_id` AS `course_id`, `c`.`course_name` AS `course_name`, `g`.`grade` AS `grade` FROM ((`students` `s` left join `grades` `g` on(`s`.`student_id` = `g`.`student_id`)) left join `courses` `c` on(`g`.`course_id` = `c`.`course_id`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`course_id`);

--
-- Indexes for table `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`grade_id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `course_id` (`course_id`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `grades`
--
ALTER TABLE `grades`
  MODIFY `grade_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `grades`
--
ALTER TABLE `grades`
  ADD CONSTRAINT `grades_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`),
  ADD CONSTRAINT `grades_ibfk_2` FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
