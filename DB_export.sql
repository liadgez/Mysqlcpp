-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: books_store
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table ` staff_monthly_hours`
--

DROP TABLE IF EXISTS ` staff_monthly_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE ` staff_monthly_hours` (
  `staff_id` int NOT NULL,
  `year_month` date DEFAULT NULL,
  `hours` int DEFAULT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table ` staff_monthly_hours`
--

LOCK TABLES ` staff_monthly_hours` WRITE;
/*!40000 ALTER TABLE ` staff_monthly_hours` DISABLE KEYS */;
INSERT INTO ` staff_monthly_hours` VALUES (1,'2020-01-01',40),(2,'2020-01-01',100),(3,'2020-01-01',50);
/*!40000 ALTER TABLE ` staff_monthly_hours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `author_id` int NOT NULL,
  `author_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'Lola'),(2,'Yossi'),(3,'Liran'),(4,'Liad'),(5,'Naomi'),(6,'Daniella'),(7,'Karin'),(8,'Or'),(9,'Dor'),(10,'Moshiko');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authors_books`
--

DROP TABLE IF EXISTS `authors_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors_books` (
  `author_id` int NOT NULL,
  `book_id` varchar(45) NOT NULL,
  PRIMARY KEY (`author_id`,`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors_books`
--

LOCK TABLES `authors_books` WRITE;
/*!40000 ALTER TABLE `authors_books` DISABLE KEYS */;
INSERT INTO `authors_books` VALUES (1,'1'),(1,'2'),(1,'3'),(2,'4'),(3,'5'),(4,'6'),(5,'7'),(6,'8'),(7,'9'),(8,'10'),(9,'11');
/*!40000 ALTER TABLE `authors_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_inventory`
--

DROP TABLE IF EXISTS `book_inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_inventory` (
  `inventory_id` int NOT NULL,
  `inventory_type_id` int DEFAULT NULL,
  `book_version_id` int DEFAULT NULL,
  `added_date` date DEFAULT NULL,
  `book_status_id` int DEFAULT NULL,
  PRIMARY KEY (`inventory_id`),
  KEY `book_id_idx` (`book_version_id`),
  CONSTRAINT `book_id` FOREIGN KEY (`book_version_id`) REFERENCES `books` (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_inventory`
--

LOCK TABLES `book_inventory` WRITE;
/*!40000 ALTER TABLE `book_inventory` DISABLE KEYS */;
INSERT INTO `book_inventory` VALUES (1,1,3,'2020-01-01',1),(2,1,6,'2020-08-01',1),(3,1,4,'2020-07-01',1),(4,1,7,'2020-06-01',1),(5,2,3,'2020-06-01',2),(6,2,3,'2020-08-01',2),(7,1,3,'2020-08-01',3),(8,2,2,'2020-08-01',4),(9,2,5,'2020-08-01',5),(10,2,6,'2020-08-01',5),(11,1,1,'2020-08-01',1),(12,1,1,'2020-08-01',1);
/*!40000 ALTER TABLE `book_inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_statuses`
--

DROP TABLE IF EXISTS `book_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_statuses` (
  `book_status_id` int NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`book_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_statuses`
--

LOCK TABLES `book_statuses` WRITE;
/*!40000 ALTER TABLE `book_statuses` DISABLE KEYS */;
INSERT INTO `book_statuses` VALUES (1,'new'),(2,'as new'),(3,'good'),(4,'ok'),(5,'bad');
/*!40000 ALTER TABLE `book_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_version`
--

DROP TABLE IF EXISTS `book_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_version` (
  `book_version_id` int NOT NULL,
  `translator_id` int NOT NULL,
  `language_id` varchar(45) DEFAULT NULL,
  `book_id` varchar(45) DEFAULT NULL,
  `publisher_id` varchar(45) DEFAULT NULL,
  `publish_year` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`book_version_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_version`
--

LOCK TABLES `book_version` WRITE;
/*!40000 ALTER TABLE `book_version` DISABLE KEYS */;
INSERT INTO `book_version` VALUES (1,1,'1','1','1','2000'),(2,2,'2','2','1','2000'),(3,1,'1','3','1','2002'),(4,3,'2','4','2','2003'),(5,2,'1','5','2','2001'),(6,4,'2','6','1','2019'),(7,2,'1','7','3','2020'),(8,1,'1','8','2','2019'),(9,3,'3','9','1','2018'),(10,4,'4','10','2','2018'),(11,2,'2','2','2','2017');
/*!40000 ALTER TABLE `book_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `book_id` int NOT NULL,
  `book_name` varchar(45) DEFAULT NULL,
  `pages` int DEFAULT NULL,
  `wheight` int DEFAULT NULL,
  `buy_value` int DEFAULT NULL,
  `sell_value` int DEFAULT NULL,
  PRIMARY KEY (`book_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (1,'Lizard',700,3,1,7),(2,'gever1',66,5,1,8),(3,'gever2',775,5,1,11),(4,'wind breaker',67,6,1,11),(5,'losi loslos',56,7,2,10),(6,'oslo agreement yes',666,7,3,5),(7,'good buy',45,8,3,7),(8,'god of war',665,9,2,9),(9,'lorem is yes',265,4,3,8),(10,'hello sir',223,2,6,8);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `client_id` int NOT NULL,
  `f_name` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Yossi','846464','2020-02-01'),(2,'Natan','68634563','2020-08-01'),(3,'Lola','46876','2020-08-01'),(4,'Marble','483647586','2020-08-01'),(5,'Julian','746834768','2020-08-01'),(6,'Matan','36884584678','2020-08-01'),(7,'Guy','6847368','2020-08-01'),(8,'Yoni','7864768','2020-08-01'),(9,'Dor','7468856','2020-08-01'),(10,'Daniella','74684768','2020-08-01'),(9999,'store',NULL,'2020-08-01');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_type`
--

DROP TABLE IF EXISTS `inventory_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_type` (
  `inventory_type_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`inventory_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_type`
--

LOCK TABLES `inventory_type` WRITE;
/*!40000 ALTER TABLE `inventory_type` DISABLE KEYS */;
INSERT INTO `inventory_type` VALUES (1,'Store'),(2,'Storage');
/*!40000 ALTER TABLE `inventory_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `id` int NOT NULL,
  `language_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'Hebrew'),(2,'English'),(3,'Spanish'),(4,'Russian'),(5,'Chinese'),(6,'Hindi'),(7,'Arabic');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` int NOT NULL,
  `client_id` int DEFAULT NULL,
  `staff_id` int DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `inventory_id` int DEFAULT NULL,
  `shipping_id` int DEFAULT NULL,
  `payment_method_id` int DEFAULT NULL,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,1,'2020-01-05',1,1,1),(2,1,1,'2020-01-05',2,2,1),(3,1,1,'2020-01-05',3,2,1),(4,4,1,'2020-01-05',4,2,2),(5,5,2,'2020-01-05',5,3,3),(6,6,2,'2020-01-05',6,4,2),(7,7,2,'2020-01-05',7,5,1),(8,3,2,'2020-01-05',8,6,3),(9,3,2,'2011-02-05',9,7,2),(10,5,2,'2020-02-05',9,7,2),(11,5,2,'2020-03-05',9,7,2);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_method`
--

DROP TABLE IF EXISTS `payment_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_method` (
  `payment_method_id` int NOT NULL,
  `payment_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_method`
--

LOCK TABLES `payment_method` WRITE;
/*!40000 ALTER TABLE `payment_method` DISABLE KEYS */;
INSERT INTO `payment_method` VALUES (1,'credit card'),(2,'bit'),(3,'bank tansfer');
/*!40000 ALTER TABLE `payment_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publishers`
--

DROP TABLE IF EXISTS `publishers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publishers` (
  `publisher_id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`publisher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishers`
--

LOCK TABLES `publishers` WRITE;
/*!40000 ALTER TABLE `publishers` DISABLE KEYS */;
INSERT INTO `publishers` VALUES (1,'yosi'),(2,'namir'),(3,'yeshoa'),(4,'liad'),(5,'liran'),(6,'guy'),(7,'dor'),(8,'yoni'),(9,'matan'),(10,'shmuel');
/*!40000 ALTER TABLE `publishers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_books`
--

DROP TABLE IF EXISTS `shipping_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_books` (
  `shipping_id` int NOT NULL,
  `shipping_type_id` int DEFAULT NULL,
  `shipping_status_id` int DEFAULT NULL,
  `shipping_address` varchar(100) DEFAULT NULL,
  `shipping_date` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`shipping_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_books`
--

LOCK TABLES `shipping_books` WRITE;
/*!40000 ALTER TABLE `shipping_books` DISABLE KEYS */;
INSERT INTO `shipping_books` VALUES (1,1,1,'המעפיל 33, עפולה','2020-08-01'),(2,1,3,'המעפיל 2ֿ3, עפולה','2020-08-01'),(3,2,2,'המעפיל 13, עפולה','2020-08-01'),(4,5,3,'המעפיל 34, עפולה','2020-08-01'),(5,4,3,'המעפיל 53, עפולה','2020-08-01'),(6,9999,9999,'חנות','2020-08-01');
/*!40000 ALTER TABLE `shipping_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_method`
--

DROP TABLE IF EXISTS `shipping_method`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_method` (
  `shipping_method_id` int NOT NULL,
  `method` varchar(45) DEFAULT NULL,
  `cost_per_gram` int DEFAULT NULL,
  PRIMARY KEY (`shipping_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_method`
--

LOCK TABLES `shipping_method` WRITE;
/*!40000 ALTER TABLE `shipping_method` DISABLE KEYS */;
INSERT INTO `shipping_method` VALUES (1,'דואר ישראל רשום',1),(2,'דואר ישראל שליחים',2),(3,'דואר ישראל שליחים מהיר',5),(4,'xpress - נקודת איסוף',2),(5,'xpress - שליח עד הבית',6),(9999,'הזמנת מלאי לחנות',1);
/*!40000 ALTER TABLE `shipping_method` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipping_status`
--

DROP TABLE IF EXISTS `shipping_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shipping_status` (
  `status_id` int NOT NULL,
  `status_type` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipping_status`
--

LOCK TABLES `shipping_status` WRITE;
/*!40000 ALTER TABLE `shipping_status` DISABLE KEYS */;
INSERT INTO `shipping_status` VALUES (1,'בהכנה למשלוח'),(2,'נשלח'),(3,'הגיע ומחכה לאיסוף'),(4,'נמסר');
/*!40000 ALTER TABLE `shipping_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `join_date` date DEFAULT NULL,
  `current_work` tinyint(1) DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
INSERT INTO `staff` VALUES (1,'Yosi','456845','2019-01-01',1,NULL),(2,'Nala','45678','2019-02-01',1,NULL),(3,'Julian','45678','2019-03-01',1,NULL),(4,'Muha','4563786','2019-04-01',0,'2019-12-30'),(5,'Ola','7368468','2019-01-01',0,'2019-12-30'),(6,'Lola','74684768','2019-01-01',0,'2019-12-30'),(7,'August','7468786','2019-01-01',0,'2019-12-30'),(8,'Sebastian','74684768','2019-05-01',0,'2019-12-30'),(9,'Liad','74867468','2019-06-01',0,'2019-12-30'),(10,'Liran','78688','2019-08-01',0,'2019-12-30');
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_buy`
--

DROP TABLE IF EXISTS `store_buy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_buy` (
  `id_store_buy` int NOT NULL,
  `staff_id` int DEFAULT NULL,
  `book_version_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_store_buy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_buy`
--

LOCK TABLES `store_buy` WRITE;
/*!40000 ALTER TABLE `store_buy` DISABLE KEYS */;
INSERT INTO `store_buy` VALUES (1,1,'8'),(2,1,'9'),(3,1,'10');
/*!40000 ALTER TABLE `store_buy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `store_payment`
--

DROP TABLE IF EXISTS `store_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_payment` (
  `store_payment_id` int NOT NULL,
  `year_month` date DEFAULT NULL,
  `arnona` int DEFAULT NULL,
  `water` int DEFAULT NULL,
  `electricity` int DEFAULT NULL,
  `phone_cost` int DEFAULT NULL,
  `telephone_cost` int DEFAULT NULL,
  `others` int DEFAULT NULL,
  PRIMARY KEY (`store_payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_payment`
--

LOCK TABLES `store_payment` WRITE;
/*!40000 ALTER TABLE `store_payment` DISABLE KEYS */;
INSERT INTO `store_payment` VALUES (1,'2020-01-01',3000,100,100,50,50,2000);
/*!40000 ALTER TABLE `store_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translators`
--

DROP TABLE IF EXISTS `translators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `translators` (
  `id` int NOT NULL,
  `f_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translators`
--

LOCK TABLES `translators` WRITE;
/*!40000 ALTER TABLE `translators` DISABLE KEYS */;
INSERT INTO `translators` VALUES (1,'Julian'),(2,'Juns'),(3,'Kord'),(4,'Kornelius'),(5,'Ondrea'),(6,'Ola'),(7,'Lola'),(8,'Muhamad'),(9,'Jin'),(10,'Yan');
/*!40000 ALTER TABLE `translators` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-08-09  1:16:05
