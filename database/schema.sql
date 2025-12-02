-- Active: 1764526925547@@127.0.0.1@3306@mysql
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: dishcovery
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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `id` int NOT NULL AUTO_INCREMENT,
  `country_name` varchar(63) DEFAULT NULL,
  `main_language_id` int DEFAULT NULL,
  `population` bigint DEFAULT NULL,
  `capital` varchar(63) DEFAULT NULL,
  `region_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `main_language_id` (`main_language_id`),
  KEY `region_id` (`region_id`),
  CONSTRAINT `country_ibfk_1` FOREIGN KEY (`main_language_id`) REFERENCES `language` (`id`),
  CONSTRAINT `country_ibfk_2` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'China',1,1413142846,NULL,1),(2,'India',2,1399179585,NULL,2),(3,'United States',3,339665118,NULL,3),(4,'Indonesia',4,279476346,NULL,4),(5,'Pakistan',5,247653551,NULL,5),(6,'Nigeria',6,230842743,NULL,6),(7,'Brazil',7,218689757,NULL,7),(8,'Bangladesh',8,167184465,NULL,8),(9,'Russia',9,141698923,NULL,9),(10,'Mexico',10,129875529,NULL,10),(11,'Japan',11,123719238,NULL,11),(12,'Ethiopia',12,116462712,NULL,12),(13,'Philippines',13,116434200,NULL,13),(14,'Democratic Republic of the Congo',14,111859928,NULL,14),(15,'Egypt',15,109546720,NULL,15),(16,'Vietnam',16,104799174,NULL,16),(17,'Iran',17,87590873,NULL,17),(18,'Germany',18,84220184,NULL,18),(19,'Turkey',19,83593483,NULL,19),(20,'Thailand',20,69794997,NULL,20),(21,'France',21,68521974,NULL,21),(22,'United Kingdom',22,68138484,NULL,22),(23,'Tanzania',23,65642682,NULL,23),(24,'Italy',24,61021855,NULL,24),(25,'South Africa',25,58048332,NULL,25),(26,'Myanmar',26,57970293,NULL,26),(27,'Kenya',27,57052004,NULL,27),(28,'South Korea',28,51966948,NULL,28),(29,'Colombia',29,49336454,NULL,29),(30,'Sudan',30,49197555,NULL,30),(31,'Uganda',31,47729952,NULL,31),(32,'Spain',32,47222613,NULL,32),(33,'Argentina',33,46621847,NULL,33),(34,'Algeria',34,44758398,NULL,34),(35,'Ukraine',35,43306477,NULL,35),(36,'Iraq',36,41266109,NULL,36),(37,'Afghanistan',37,39232003,NULL,37),(38,'Canada',38,38516736,NULL,38),(39,'Poland',39,37991766,NULL,39),(40,'Morocco',40,37067420,NULL,40),(41,'Angola',41,35981281,NULL,41),(42,'Saudi Arabia',42,35939806,NULL,42),(43,'Malaysia',43,34219975,NULL,43),(44,'Ghana',44,33846114,NULL,44),(45,'Mozambique',45,32513805,NULL,45),(46,'Peru',46,32440172,NULL,46),(47,'Yemen',47,31565602,NULL,47),(48,'Uzbekistan',48,31360836,NULL,48),(49,'Nepal',49,30899443,NULL,49),(50,'Venezuela',50,30518260,NULL,50),(51,'Cameroon',51,30135732,NULL,51),(52,'Ivory Coast',52,29344847,NULL,52),(53,'Madagascar',53,28812195,NULL,53),(54,'Australia',54,26461166,NULL,54),(55,'North Korea',55,26072217,NULL,55),(56,'Niger',56,25396840,NULL,56),(57,'Taiwan',57,23588613,NULL,57),(58,'Sri Lanka',58,23326272,NULL,58),(59,'Syria',59,22933531,NULL,59),(60,'Burkina Faso',60,22489126,NULL,60),(61,'Mali',61,21359722,NULL,61),(62,'Malawi',62,21279597,NULL,62),(63,'Zambia',63,20216029,NULL,63),(64,'Kazakhstan',64,19543464,NULL,64),(65,'Chile',65,18549457,NULL,65),(66,'Chad',66,18523165,NULL,66),(67,'Senegal',67,18384660,NULL,67),(68,'Romania',68,18326327,NULL,68),(69,'Guatemala',69,17980803,NULL,69),(70,'Ecuador',70,17483326,NULL,70),(71,'Netherlands',71,17463930,NULL,71),(72,'Cambodia',72,16891245,NULL,72),(73,'Zimbabwe',73,15418674,NULL,73),(74,'Benin',74,14219908,NULL,74),(75,'Guinea',75,13607249,NULL,75),(76,'Rwanda',76,13400541,NULL,76),(77,'Burundi',77,13162952,NULL,77),(78,'Somalia',78,12693796,NULL,78),(79,'Bolivia',79,12186079,NULL,79),(80,'South Sudan',80,12118379,NULL,80),(81,'Tunisia',81,11976182,NULL,81),(82,'Belgium',82,11913633,NULL,82),(83,'Haiti',83,11470261,NULL,83),(84,'Jordan',84,11086716,NULL,84),(85,'Cuba',85,10985974,NULL,85),(86,'Dominican Republic',86,10790744,NULL,86),(87,'Czech Republic',87,10706242,NULL,87),(88,'Sweden',88,10536338,NULL,88),(89,'Greece',89,10497595,NULL,89),(90,'Azerbaijan',90,10420515,NULL,90),(91,'Portugal',91,10223150,NULL,91),(92,'United Arab Emirates',92,9973449,NULL,92),(93,'Papua New Guinea',93,9819350,NULL,93),(94,'Hungary',94,9670009,NULL,94),(95,'Honduras',95,9571352,NULL,95),(96,'Belarus',96,9383853,NULL,96),(97,'Tajikistan',97,9245937,NULL,97),(98,'Israel',98,9043387,NULL,98),(99,'Austria',99,8940860,NULL,99),(100,'Sierra Leone',100,8908040,NULL,100),(101,'Togo',101,8703961,NULL,101),(102,'Switzerland',102,8563760,NULL,102),(103,'Laos',103,7852377,NULL,103),(104,'Paraguay',104,7439863,NULL,104),(105,'Hong Kong',105,7288167,NULL,105),(106,'Libya',106,7252573,NULL,106),(107,'Bulgaria',107,6827736,NULL,107),(108,'Serbia',108,6693375,NULL,108),(109,'El Salvador',109,6602370,NULL,109),(110,'Nicaragua',110,6359689,NULL,110),(111,'Eritrea',111,6274796,NULL,111),(112,'Kyrgyzstan',112,6122781,NULL,112),(113,'Singapore',113,5975383,NULL,113),(114,'Denmark',114,5946984,NULL,114),(115,'Turkmenistan',115,5690818,NULL,115),(116,'Republic of the Congo',116,5677493,NULL,116),(117,'Finland',117,5614571,NULL,117),(118,'Norway',118,5597924,NULL,118),(119,'Central African Republic',119,5552228,NULL,119),(120,'Liberia',120,5506280,NULL,120),(121,'Slovakia',121,5425319,NULL,121),(122,'Lebanon',122,5331203,NULL,122),(123,'Ireland',123,5323991,NULL,123),(124,'Costa Rica',124,5256612,NULL,124),(125,'New Zealand',125,5109702,NULL,125),(126,'Georgia',126,4927228,NULL,126),(127,'Panama',127,4404108,NULL,127),(128,'Mauritania',128,4244878,NULL,128),(129,'Croatia',129,4169239,NULL,129),(130,'Oman',130,3833465,NULL,130),(131,'Bosnia and Herzegovina',131,3807764,NULL,131),(132,'Uruguay',132,3416264,NULL,132),(133,'Mongolia',133,3255468,NULL,133),(134,'Moldova',134,3250532,NULL,134),(135,'Kuwait',135,3103580,NULL,135),(136,'Albania',136,3101621,NULL,136),(137,'Puerto Rico',137,3057311,NULL,137),(138,'Armenia',138,2989091,NULL,138),(139,'West Bank',139,2949246,NULL,139),(140,'Jamaica',140,2820982,NULL,140),(141,'Namibia',141,2777232,NULL,141),(142,'Lithuania',142,2655755,NULL,142),(143,'Qatar',143,2532104,NULL,143),(144,'The Gambia',144,2468569,NULL,144),(145,'Botswana',145,2417596,NULL,145),(146,'Gabon',146,2397368,NULL,146),(147,'Lesotho',147,2210646,NULL,147),(148,'North Macedonia',148,2133410,NULL,148),(149,'Slovenia',149,2099790,NULL,149),(150,'Guinea-Bissau',150,2078820,NULL,150),(151,'Kosovo',151,1964327,NULL,151),(152,'Latvia',152,1821750,NULL,152),(153,'Equatorial Guinea',153,1737695,NULL,153),(154,'Bahrain',154,1553886,NULL,154),(155,'Timor-Leste',155,1476042,NULL,155),(156,'Trinidad and Tobago',156,1407460,NULL,156),(157,'Mauritius',157,1309448,NULL,157),(158,'Cyprus',158,1308120,NULL,158),(159,'Estonia',159,1202762,NULL,159),(160,'Eswatini',160,1130043,NULL,160),(161,'Djibouti',161,976143,NULL,161),(162,'Fiji',162,947760,NULL,162),(163,'Comoros',163,888378,NULL,163),(164,'Bhutan',164,876181,NULL,164),(165,'Guyana',165,791739,NULL,165),(166,'Solomon Islands',166,714766,NULL,166),(167,'Luxembourg',167,660924,NULL,167),(168,'Macau',168,639971,NULL,168),(169,'Suriname',169,639759,NULL,169),(170,'Cape Verde',170,603901,NULL,170),(171,'Montenegro',171,602445,NULL,171),(172,'Western Sahara',172,565581,NULL,172),(173,'Maldives',173,521021,NULL,173),(174,'Brunei',174,484991,NULL,174),(175,'Malta',175,467138,NULL,175),(176,'Belize',176,419137,NULL,176),(177,'Guadeloupe',177,378561,NULL,177),(178,'Iceland',178,360872,NULL,178),(179,'The Bahamas',179,358508,NULL,179),(180,'Vanuatu',180,313046,NULL,180),(181,'Barbados',181,303431,NULL,181),(182,'French Polynesia',182,301488,NULL,182),(183,'New Caledonia',183,300682,NULL,183),(184,'SÃ£o TomÃ© and PrÃ­ncipe',184,220372,NULL,184),(185,'Samoa',185,207501,NULL,185),(186,'Guam',186,169330,NULL,186),(187,'Saint Lucia',187,167591,NULL,187),(188,'CuraÃ§ao',188,152849,NULL,188),(189,'Aruba',189,123702,NULL,189),(190,'Kiribati',190,115372,NULL,190),(191,'Grenada',191,114299,NULL,191),(192,'Tonga',192,105221,NULL,192),(193,'United States Virgin Islands',193,104917,NULL,193),(194,'Jersey',194,102785,NULL,194),(195,'Antigua and Barbuda',195,101489,NULL,195),(196,'Saint Vincent and the Grenadines',196,100804,NULL,196),(197,'Federated States of Micronesia',197,100319,NULL,197),(198,'Seychelles',198,97617,NULL,198),(199,'Isle of Man',199,91840,NULL,199),(200,'Andorra',200,85468,NULL,200),(201,'Marshall Islands',201,80966,NULL,201),(202,'Dominica',202,74656,NULL,202),(203,'Bermuda',203,72576,NULL,203),(204,'Guernsey',204,67642,NULL,204),(205,'Cayman Islands',205,65483,NULL,205),(206,'Turks and Caicos Islands',206,59367,NULL,206),(207,'Greenland',207,57777,NULL,207),(208,'Saint Kitts and Nevis',208,54817,NULL,208),(209,'Faroe Islands',209,52600,NULL,209),(210,'Northern Mariana Islands',210,51295,NULL,210),(211,'Sint Maarten',211,45677,NULL,211),(212,'American Samoa',212,44620,NULL,212),(213,'Liechtenstein',213,39993,NULL,213),(214,'British Virgin Islands',214,39369,NULL,214),(215,'San Marino',215,34892,NULL,215),(216,'Saint-Martin',216,32897,NULL,216),(217,'Monaco',217,31597,NULL,217),(218,'Caribbean Netherlands',218,30397,NULL,218),(219,'Gibraltar',219,29629,NULL,219),(220,'Palau',220,21779,NULL,220),(221,'Anguilla',221,19079,NULL,221),(222,'Wallis and Futuna',222,15929,NULL,222),(223,'Tuvalu',223,11639,NULL,223),(224,'Nauru',224,9852,NULL,224),(225,'Cook Islands',225,7939,NULL,225),(226,'Saint Helena, Ascension and Tristan da Cunha',226,7935,NULL,226),(227,'Saint BarthÃ©lemy',227,7093,NULL,227),(228,'Montserrat',228,5440,NULL,228),(229,'Saint Pierre and Miquelon',229,5195,NULL,229),(230,'Falkland Islands',230,3662,NULL,230),(231,'Svalbard and Jan Mayen',231,2926,NULL,231),(232,'Christmas Island',232,2205,NULL,232),(233,'Niue',233,2000,NULL,233),(234,'Norfolk Island',234,1748,NULL,234),(235,'Tokelau',235,1647,NULL,235),(236,'Vatican City',236,1000,NULL,236),(237,'Cocos (Keeling) Islands',237,596,NULL,237),(238,'United States Minor Outlying Islands',238,300,NULL,238),(239,'Pitcairn Islands',239,50,NULL,239);
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dish`
--

DROP TABLE IF EXISTS `dish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dish` (
  `id` int NOT NULL AUTO_INCREMENT,
  `country_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text,
  `image_url` varchar(511) DEFAULT NULL,
  `is_national_dish` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `dish_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dish`
--

LOCK TABLES `dish` WRITE;
/*!40000 ALTER TABLE `dish` DISABLE KEYS */;
/*!40000 ALTER TABLE `dish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dish_category`
--

DROP TABLE IF EXISTS `dish_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dish_category` (
  `dish_id` int NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`dish_id`,`category_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `dish_category_ibfk_1` FOREIGN KEY (`dish_id`) REFERENCES `dish` (`id`),
  CONSTRAINT `dish_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dish_category`
--

LOCK TABLES `dish_category` WRITE;
/*!40000 ALTER TABLE `dish_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `dish_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dish_ingredient`
--

DROP TABLE IF EXISTS `dish_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dish_ingredient` (
  `dish_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  PRIMARY KEY (`dish_id`,`ingredient_id`),
  KEY `ingredient_id` (`ingredient_id`),
  CONSTRAINT `dish_ingredient_ibfk_1` FOREIGN KEY (`dish_id`) REFERENCES `dish` (`id`),
  CONSTRAINT `dish_ingredient_ibfk_2` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dish_ingredient`
--

LOCK TABLES `dish_ingredient` WRITE;
/*!40000 ALTER TABLE `dish_ingredient` DISABLE KEYS */;
/*!40000 ALTER TABLE `dish_ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient`
--

LOCK TABLES `ingredient` WRITE;
/*!40000 ALTER TABLE `ingredient` DISABLE KEYS */;
/*!40000 ALTER TABLE `ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `language` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=254 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES (1,'Chinese'),(2,'Hindi'),(3,'English'),(4,'Indonesian'),(5,'Urdu'),(6,'English'),(7,'Portuguese'),(8,'Bengali'),(9,'Russian'),(10,'Spanish'),(11,'Japanese'),(12,'Amharic'),(13,'Filipino'),(14,'French'),(15,'Arabic'),(16,'Vietnamese'),(17,'Persian'),(18,'German'),(19,'Turkish'),(20,'Thai'),(21,'French'),(22,'English'),(23,'Swahili'),(24,'Italian'),(25,'Zulu'),(26,'Burmese'),(27,'English'),(28,'Korean'),(29,'Spanish'),(30,'Arabic'),(31,'English'),(32,'Spanish'),(33,'Spanish'),(34,'Arabic'),(35,'Ukrainian'),(36,'Arabic'),(37,'Pashto'),(38,'English'),(39,'Polish'),(40,'Arabic'),(41,'Portuguese'),(42,'Arabic'),(43,'Malay'),(44,'English'),(45,'Portuguese'),(46,'Spanish'),(47,'Arabic'),(48,'Uzbek'),(49,'Nepali'),(50,'Spanish'),(51,'English'),(52,'French'),(53,'Malagasy'),(54,'English'),(55,'Korean'),(56,'French'),(57,'Chinese'),(58,'Sinhala'),(59,'Arabic'),(60,'French'),(61,'French'),(62,'English'),(63,'English'),(64,'Kazakh'),(65,'Spanish'),(66,'Arabic'),(67,'French'),(68,'Romanian'),(69,'Spanish'),(70,'Spanish'),(71,'Dutch'),(72,'Khmer'),(73,'English'),(74,'French'),(75,'French'),(76,'Kinyarwanda'),(77,'Kirundi'),(78,'Somali'),(79,'Spanish'),(80,'Arabic'),(81,'Arabic'),(82,'Dutch'),(83,'French'),(84,'Arabic'),(85,'Spanish'),(86,'Spanish'),(87,'Czech'),(88,'Swedish'),(89,'Greek'),(90,'Azerbaijani'),(91,'Portuguese'),(92,'Arabic'),(93,'English'),(94,'Hungarian'),(95,'Spanish'),(96,'Belarusian'),(97,'Tajik'),(98,'Hebrew'),(99,'German'),(100,'English'),(101,'French'),(102,'German'),(103,'Lao'),(104,'Spanish'),(105,'Chinese'),(106,'Arabic'),(107,'Bulgarian'),(108,'Serbian'),(109,'Spanish'),(110,'Spanish'),(111,'Tigrinya'),(112,'Kyrgyz'),(113,'English'),(114,'Danish'),(115,'Turkmen'),(116,'French'),(117,'Finnish'),(118,'Norwegian'),(119,'Sango'),(120,'English'),(121,'Slovak'),(122,'Arabic'),(123,'English'),(124,'Spanish'),(125,'English'),(126,'Georgian'),(127,'Spanish'),(128,'Arabic'),(129,'Croatian'),(130,'Arabic'),(131,'Bosnian'),(132,'Spanish'),(133,'Mongolian'),(134,'Romanian'),(135,'Arabic'),(136,'Albanian'),(137,'Spanish'),(138,'Armenian'),(139,''),(140,'English'),(141,'English'),(142,'Lithuanian'),(143,'Arabic'),(144,'English'),(145,'English'),(146,'French'),(147,'English'),(148,'Macedonian'),(149,'Slovenian'),(150,'Portuguese'),(151,'Serbian'),(152,'Latvian'),(153,'Spanish'),(154,'Arabic'),(155,'Portuguese'),(156,'English'),(157,'English'),(158,'Greek'),(159,'Estonian'),(160,'English'),(161,'Arabic'),(162,'English'),(163,'Arabic'),(164,'Dzongkha'),(165,'English'),(166,'English'),(167,'Luxembourgish'),(168,'Chinese'),(169,'Dutch'),(170,'Portuguese'),(171,'Montenegrin'),(172,'Arabic'),(173,'Divehi'),(174,'Malay'),(175,'Maltese'),(176,'English'),(177,'French'),(178,'Icelandic'),(179,'English'),(180,'Bislama'),(181,'English'),(182,'French'),(183,'French'),(184,'Portuguese'),(185,'Samoan'),(186,'English'),(187,'English'),(188,'English'),(189,'Dutch'),(190,'English'),(191,'English'),(192,'English'),(193,'English'),(194,'English'),(195,'English'),(196,'English'),(197,'English'),(198,'English'),(199,'Manx'),(200,'Catalan'),(201,'English'),(202,'English'),(203,'English'),(204,'English'),(205,'English'),(206,'English'),(207,'Greenlandic'),(208,'English'),(209,'Faroese'),(210,'English'),(211,'English'),(212,'English'),(213,'German'),(214,'English'),(215,'Italian'),(216,'French'),(217,'French'),(218,'English'),(219,'English'),(220,'English'),(221,'English'),(222,'French'),(223,'English'),(224,'Nauruan'),(225,'English'),(226,'English'),(227,'French'),(228,'English'),(229,'French'),(230,'English'),(231,'Norwegian'),(232,'English'),(233,'English'),(234,'English'),(235,'English'),(236,'Italian'),(237,'English'),(238,'English'),(239,'English'),(240,''),(241,'English'),(242,''),(243,'French'),(244,'French'),(245,''),(246,'French'),(247,'French'),(248,''),(249,'French'),(250,'English'),(251,''),(252,''),(253,'');
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `region` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=254 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES (1,'Asia'),(2,'Asia'),(3,'North America'),(4,'Asia'),(5,'Asia'),(6,'Africa'),(7,'South America'),(8,'Asia'),(9,'Europe'),(10,'North America'),(11,'Asia'),(12,'Africa'),(13,'Asia'),(14,'Africa'),(15,'Africa'),(16,'Asia'),(17,'Asia'),(18,'Europe'),(19,'Asia'),(20,'Asia'),(21,'Europe'),(22,'Europe'),(23,'Africa'),(24,'Europe'),(25,'Africa'),(26,'Asia'),(27,'Africa'),(28,'Asia'),(29,'South America'),(30,'Africa'),(31,'Africa'),(32,'Europe'),(33,'South America'),(34,'Africa'),(35,'Europe'),(36,'Asia'),(37,'Asia'),(38,'North America'),(39,'Europe'),(40,'Africa'),(41,'Africa'),(42,'Asia'),(43,'Asia'),(44,'Africa'),(45,'Africa'),(46,'South America'),(47,'Asia'),(48,'Asia'),(49,'Asia'),(50,'South America'),(51,'Africa'),(52,'Africa'),(53,'Africa'),(54,'Oceania'),(55,'Asia'),(56,'Africa'),(57,'Asia'),(58,'Asia'),(59,'Asia'),(60,'Africa'),(61,'Africa'),(62,'Africa'),(63,'Africa'),(64,'Asia'),(65,'South America'),(66,'Africa'),(67,'Africa'),(68,'Europe'),(69,'North America'),(70,'South America'),(71,'Europe'),(72,'Asia'),(73,'Africa'),(74,'Africa'),(75,'Africa'),(76,'Africa'),(77,'Africa'),(78,'Africa'),(79,'South America'),(80,'Africa'),(81,'Africa'),(82,'Europe'),(83,'North America'),(84,'Asia'),(85,'North America'),(86,'North America'),(87,'Europe'),(88,'Europe'),(89,'Europe'),(90,'Asia'),(91,'Europe'),(92,'Asia'),(93,'Oceania'),(94,'Europe'),(95,'North America'),(96,'Europe'),(97,'Asia'),(98,'Asia'),(99,'Europe'),(100,'Africa'),(101,'Africa'),(102,'Europe'),(103,'Asia'),(104,'South America'),(105,'Asia'),(106,'Africa'),(107,'Europe'),(108,'Europe'),(109,'North America'),(110,'North America'),(111,'Africa'),(112,'Asia'),(113,'Asia'),(114,'Europe'),(115,'Asia'),(116,'Africa'),(117,'Europe'),(118,'Europe'),(119,'Africa'),(120,'Africa'),(121,'Europe'),(122,'Asia'),(123,'Europe'),(124,'North America'),(125,'Oceania'),(126,'Asia'),(127,'North America'),(128,'Africa'),(129,'Europe'),(130,'Asia'),(131,'Europe'),(132,'South America'),(133,'Asia'),(134,'Europe'),(135,'Asia'),(136,'Europe'),(137,'North America'),(138,'Asia'),(139,'Asia'),(140,'North America'),(141,'Africa'),(142,'Europe'),(143,'Asia'),(144,'Africa'),(145,'Africa'),(146,'Africa'),(147,'Africa'),(148,'Europe'),(149,'Europe'),(150,'Africa'),(151,'Europe'),(152,'Europe'),(153,'Africa'),(154,'Asia'),(155,'Asia'),(156,'North America'),(157,'Seven seas (open ocean)'),(158,'Asia'),(159,'Europe'),(160,'Africa'),(161,'Africa'),(162,'Oceania'),(163,'Africa'),(164,'Asia'),(165,'South America'),(166,'Oceania'),(167,'Europe'),(168,'Asia'),(169,'South America'),(170,'Africa'),(171,'Europe'),(172,'Africa'),(173,'Seven seas (open ocean)'),(174,'Asia'),(175,'Europe'),(176,'North America'),(177,'North America'),(178,'Europe'),(179,'North America'),(180,'Oceania'),(181,'North America'),(182,'Oceania'),(183,'Oceania'),(184,'Africa'),(185,'Oceania'),(186,'Oceania'),(187,'North America'),(188,'North America'),(189,'North America'),(190,'Oceania'),(191,'North America'),(192,'Oceania'),(193,'North America'),(194,'Europe'),(195,'North America'),(196,'North America'),(197,'Oceania'),(198,'Seven seas (open ocean)'),(199,'Europe'),(200,'Europe'),(201,'Oceania'),(202,'North America'),(203,'North America'),(204,'Europe'),(205,'North America'),(206,'North America'),(207,'North America'),(208,'North America'),(209,'Europe'),(210,'Oceania'),(211,'North America'),(212,'Oceania'),(213,'Europe'),(214,'North America'),(215,'Europe'),(216,'North America'),(217,'Europe'),(218,'North America'),(219,'Europe'),(220,'Oceania'),(221,'North America'),(222,'Oceania'),(223,'Oceania'),(224,'Oceania'),(225,'Oceania'),(226,'Seven seas (open ocean)'),(227,'North America'),(228,'North America'),(229,'North America'),(230,'South America'),(231,'Europe'),(232,'Asia'),(233,'Oceania'),(234,'Oceania'),(235,'Insular Oceania'),(236,'Europe'),(237,'Oceania'),(238,'North America'),(239,'Oceania'),(240,''),(241,'Seven seas (open ocean)'),(242,''),(243,'South America'),(244,'Seven seas (open ocean)'),(245,'Asia'),(246,'North America'),(247,'Africa'),(248,''),(249,'Africa'),(250,'Seven seas (open ocean)'),(251,'Seven seas (open ocean)'),(252,'Antarctica'),(253,'Antarctica');
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-30  2:10:20

/* Start process to import dishes from csv */
-- Step 0: Set UTF-8 connection
SET NAMES utf8mb4;

-- Step 1: Drop temp table if exists
DROP TABLE IF EXISTS tmp_dishes;

-- Step 2: Create temp table
CREATE TABLE tmp_dishes (
    country_name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
    name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
    description TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
    is_national_dish TINYINT(1)
);


-- Step 3: Load CSV robustly
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/foodculture_dishes_rev2.csv'
INTO TABLE tmp_dishes
CHARACTER SET latin1  -- original CSV encoding, latin1/Windows-1252
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'  -- Line endings
IGNORE 1 ROWS
(@country_name, @iso3, @dish_name, @description, @national_dish,
 @beef, @veal, @fowl, @pork, @bacon, @ham, @sheep_lamb_mutton, @goat, @venison, @horse,
 @rabbit, @sausage, @edible_offal, @fish, @seal, @caviar, @clam, @prawn_shrimp, @conch, @mussel, @crab,
 @lobster, @octopus, @seaweed, @snail, @frog, @iguana, @bat, @rice, @tofu, @pasta_wheat, @rice_noodle, @couscous,
 @bulgur_wheat, @barley, @gravy, @salt, @pepper, @saltpeter, @sugar, @honey, @corn_syrup, @starch_corn,
 @stock_vegetable, @stock_beef_chicken, @stock_fish, @steak_sauce, @fish_sauce, @fish_paste, @shrimp_paste,
 @sofrito_sauce, @hot_sauce, @moambe_nyembwe_sauce, @chimichurri_sauce, @worcestershire_sauce, @tabasco_sauce,
 @sambal_oelek, @salsa_lizano, @adobo_sauce, @allspice, @sazon_goya, @five_spice_powder, @pomtajer, @netetou,
 @baharat, @mustaka_gumarabic, @garam_masala, @cassareep, @berbere_spice, @wasabi, @tumeric, @basil, @rosemary,
 @oregano, @marjoram, @parsley, @chives, @coriander_cilantro, @guasca, @fern, @screwpine_pandan_leave, @molokhia_leave,
 @ademe_leave, @cinnamon, @cumin_ajwain, @cardamom, @sesame, @egusi_seed, @nigella_seed, @fenugreek, @thyme,
 @mint_leave, @annatto_achiote, @saffron, @bezar, @nutmeg_mace, @caraway, @anise, @bay_leave, @vine_grape_leave,
 @sage, @dill, @bamboo_shoot, @clover_sprout, @brussels_sprout, @gnetum_africanum, @clove, @chili_hotpeppers,
 @curry, @harissa, @asafoetida, @masala, @ghee, @oil, @fat_lard_shortening_suet, @vinegar, @soy_sauce, @soybean_paste,
 @oyster_sauce, @ketchup, @mayonnaise, @mustard, @jam, @lemon_lime, @tomato, @carrot, @corn_maize, @millet, @potato,
 @sweet_potato, @cauliflower, @broccoli, @pea, @chickpea, @bean, @asparagus, @bean_sprout, @lentil, @greens, @zucchini,
 @eggplant, @sweet_paprika, @fennel, @cassava_yuca_manioc, @teff, @celery, @parsnip, @leek, @lettuce, @cucumber_pickles_gherkin,
 @scallion, @spinach, @bitter_melon, @bitterleaf, @cabbage_sauerkraut, @rutabaga, @okra, @starch_sago, @yams, @taro_dasheen_pulaka,
 @breadfruit, @beetroot, @turnip, @radish, @mushroom, @bell_pepper, @onion_shallot, @garlic, @lemongrass, @vanilla,
 @olives, @caper, @ginger, @lily_bud, @galangal, @pineapple, @banana_plantain, @banana_leaves, @mango, @apple, @orange,
 @apricot, @strawberry, @prune_plum, @pomegranate, @coconut, @avocado, @papaya, @ackee, @raisin, @date_tamarind,
 @pumpkin_squash, @pistachio, @peanut, @cashew, @macadamia_nut, @water_chestnut, @pine_nut, @almond, @egg, @milk,
 @butter_margarine, @yogurt, @cream, @cheese, @curd, @chocolate, @flour_wheat_corn, @dough_pastry, @yeast, @baking_soda_powder,
 @bread, @cookies, @cereal, @corn_tortilla, @wine, @beer, @hard_liquor)
SET
    country_name = CONVERT(@country_name USING utf8mb4),
    name = CONVERT(@dish_name USING utf8mb4),
    description = CONVERT(@description USING utf8mb4),
    is_national_dish = CASE
                          WHEN @national_dish IN ('TRUE','true','1') THEN 1
                          ELSE 0
                       END;

-- Step 4: Insert into main table using country_id
INSERT INTO dish (country_id, name, description, is_national_dish)
SELECT c.id, t.name, t.description, t.is_national_dish
FROM tmp_dishes t
JOIN country c ON c.country_name = t.country_name;

INSERT INTO category (category_name)
VALUES ('Main Course'), ('Appetizer'), ('Dessert'), ('Side Dish'), ('Soup'), ('Bread'), ('Beverage');


-- Step 5: Drop temp table
DROP TABLE tmp_dishes;