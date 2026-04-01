CREATE DATABASE  IF NOT EXISTS `job_tracker` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `job_tracker`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: job_tracker
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `applications` (
  `application_id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `application_date` date NOT NULL,
  `status` enum('Applied','Screening','Interview','Interview Completed','Offer','Rejected','Withdrawn') DEFAULT 'Applied',
  `resume_version` varchar(50) DEFAULT NULL,
  `interview_data` json DEFAULT NULL,
  `cover_letter_sent` tinyint(1) DEFAULT '0',
  `response_date` date DEFAULT NULL,
  `interview_date` datetime DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`application_id`),
  KEY `job_id` (`job_id`),
  KEY `idx_app_status` (`status`),
  CONSTRAINT `applications_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `applications`
--

LOCK TABLES `applications` WRITE;
/*!40000 ALTER TABLE `applications` DISABLE KEYS */;
INSERT INTO `applications` VALUES (1,1,'2025-01-16','Applied','v2.1',NULL,1,NULL,NULL,NULL,'2026-02-09 05:51:59'),(2,3,'2025-01-13','Interview Completed','v2.1',NULL,1,NULL,NULL,NULL,'2026-02-09 05:51:59'),(3,4,'2025-01-09','Interview Completed','v2.0',NULL,0,NULL,NULL,NULL,'2026-02-09 05:51:59'),(4,5,'2025-01-15','Applied','v2.1',NULL,1,NULL,NULL,NULL,'2026-02-09 05:51:59'),(5,7,'2025-01-12','Applied','v2.1',NULL,1,NULL,NULL,NULL,'2026-02-09 05:51:59');
/*!40000 ALTER TABLE `applications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `companies` (
  `company_id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) NOT NULL,
  `industry` varchar(50) DEFAULT NULL,
  `website` varchar(200) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`company_id`),
  KEY `idx_company_industry` (`industry`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` VALUES (1,'Tech Solutions Inc','Technology','www.techsolutions.com','Miami','Florida',NULL,'2026-02-09 05:46:15'),(2,'Data Analytics Corp','Data Science','www.dataanalytics.com','Austin','Texas',NULL,'2026-02-09 05:46:15'),(3,'Cloud Systems LLC','Cloud Computing','www.cloudsystems.com','Seattle','Washington',NULL,'2026-02-09 05:46:15'),(4,'Digital Innovations','Software','www.digitalinnovations.com','San Francisco','California','Applied to Senior Developer position on 2026-02-16','2026-02-09 05:46:15'),(5,'Smart Tech Group','AI/ML','www.smarttech.com','Boston','Massachusetts',NULL,'2026-02-09 05:46:15'),(12,'New Tech Corp','Technology',NULL,'Denver','Colorado',NULL,'2026-02-16 20:40:52');
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `contact_id` int NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `linkedin_url` varchar(200) DEFAULT NULL,
  `job_title` varchar(100) DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`contact_id`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `contacts_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,1,'Sarah','Johnson','sjohnson@techsolutions.com',NULL,NULL,'HR Manager',NULL,'2026-02-09 05:52:02'),(2,2,'Michael','Chen','mchen@dataanalytics.com',NULL,NULL,'Technical Recruiter',NULL,'2026-02-09 05:52:02'),(3,3,'Emily','Williams','ewilliams@cloudsystems.com',NULL,NULL,'Hiring Manager',NULL,'2026-02-09 05:52:02'),(4,4,'David','Brown',NULL,NULL,NULL,'Senior Developer',NULL,'2026-02-09 05:52:02'),(5,5,'Lisa','Garcia','lgarcia@smarttech.com',NULL,NULL,'Talent Acquisition',NULL,'2026-02-09 05:52:02'),(7,4,'Robert','Kim','rkim@digitalinnovations.com',NULL,NULL,'Engineering Manager',NULL,'2026-02-16 20:41:01');
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `job_id` int NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL,
  `job_title` varchar(100) NOT NULL,
  `job_type` enum('Full-time','Part-time','Contract','Internship') DEFAULT NULL,
  `job_description` text,
  `salary_min` decimal(10,2) DEFAULT NULL,
  `salary_max` decimal(10,2) DEFAULT NULL,
  `posting_url` varchar(500) DEFAULT NULL,
  `date_posted` date DEFAULT NULL,
  `requirements` json DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`job_id`),
  KEY `idx_job_title` (`job_title`),
  KEY `idx_salary` (`salary_min`),
  KEY `idx_company_type` (`company_id`,`job_type`),
  CONSTRAINT `jobs_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` VALUES (1,1,'Software Developer','Full-time',NULL,70000.00,90000.00,NULL,'2025-01-15','[\"Python\", \"SQL\", \"Flask\", \"HTML\", \"CSS\"]',1,'2026-02-09 05:51:54'),(2,1,'Database Administrator','Full-time',NULL,75000.00,95000.00,NULL,'2025-01-10','[\"SQL\", \"MySQL\", \"Database Tuning\", \"Backup\", \"Security\"]',1,'2026-02-09 05:51:54'),(3,2,'Cloud Engineer','Full-time',NULL,80000.00,100000.00,NULL,'2025-01-08','[\"AWS\", \"Azure\", \"Docker\", \"Kubernetes\", \"Linux\"]',1,'2026-02-09 05:51:54'),(4,3,'Data Analyst','Full-time',NULL,65000.00,85000.00,NULL,'2025-01-12','[\"SQL\", \"Tableau\", \"Excel\", \"PowerBI\", \"Python\"]',1,'2026-02-09 05:51:54'),(5,4,'Junior Developer','Full-time',NULL,55000.00,70000.00,NULL,'2025-01-14','[\"JavaScript\", \"React\", \"Node.js\", \"SQL\"]',1,'2026-02-09 05:51:54'),(6,4,'Senior Developer','Full-time',NULL,95000.00,120000.00,NULL,'2025-01-14','[\"Python\", \"Django\", \"PostgreSQL\", \"Docker\", \"AWS\"]',1,'2026-02-09 05:51:54'),(7,5,'ML Engineer','Full-time',NULL,90000.00,115000.00,NULL,'2025-01-11','[\"Python\", \"TensorFlow\", \"PyTorch\", \"Pandas\", \"Linear Algebra\"]',1,'2026-02-09 05:51:54'),(8,1,'QA Engineer','Full-time',NULL,60000.00,80000.00,NULL,'2025-01-05','[\"Selenium\", \"JMeter\", \"Unit Testing\", \"Python\", \"Manual Testing\"]',1,'2026-02-09 05:54:44'),(9,2,'Business Analyst','Full-time',NULL,65000.00,85000.00,NULL,'2025-01-06','[\"Requirements Gathering\", \"Agile\", \"SQL\", \"User Stories\"]',1,'2026-02-09 05:54:44'),(10,2,'Data Scientist','Full-time',NULL,85000.00,110000.00,NULL,'2025-01-07','[\"Python\", \"R\", \"Machine Learning\", \"Statistics\", \"SQL\"]',1,'2026-02-09 05:54:44'),(11,3,'DevOps Engineer','Full-time',NULL,80000.00,105000.00,NULL,'2025-01-08','[\"Docker\", \"Jenkins\", \"Terraform\", \"Kubernetes\", \"Linux\"]',1,'2026-02-09 05:54:44'),(12,3,'Security Analyst','Full-time',NULL,75000.00,95000.00,NULL,'2025-01-09','[\"Cybersecurity\", \"Firewalls\", \"Network Security\", \"Penetration Testing\"]',1,'2026-02-09 05:54:44'),(13,4,'UI/UX Designer','Full-time',NULL,60000.00,80000.00,NULL,'2025-01-10','[\"Figma\", \"Adobe XD\", \"Wireframing\", \"User Research\"]',1,'2026-02-09 05:54:44'),(14,5,'Product Manager','Full-time',NULL,90000.00,120000.00,NULL,'2025-01-11','[\"Roadmapping\", \"Jira\", \"Agile\", \"Market Research\", \"Strategy\"]',1,'2026-02-09 05:54:44'),(15,1,'Technical Writer','Contract',NULL,55000.00,75000.00,NULL,'2025-01-12','[\"Markdown\", \"DITA\", \"API Documentation\", \"Copywriting\"]',1,'2026-02-09 05:54:44'),(16,2,'Intern Data','Internship',NULL,30000.00,32000.00,NULL,'2025-01-13','[\"SQL\", \"Excel\", \"Python\", \"Problem Solving\"]',1,'2026-02-09 05:54:44'),(17,4,'Intern Development','Internship',NULL,40000.00,42000.00,NULL,'2025-01-14','[\"HTML\", \"CSS\", \"JavaScript\", \"Willingness to Learn\"]',1,'2026-02-09 05:54:44'),(18,12,'Software Architect','Full-time',NULL,120000.00,150000.00,NULL,NULL,'[\"Java\", \"Spring Boot\", \"Microservices\", \"System Design\"]',1,'2026-02-16 20:40:52');
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-21 17:29:43
