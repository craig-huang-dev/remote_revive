-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: remoterevive
-- ------------------------------------------------------
-- Server version	8.0.40

CREATE DATABASE IF NOT EXISTS remoterevive;
USE remoterevive;

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
-- Table structure for table `aisuggestions`
--

DROP TABLE IF EXISTS `aisuggestions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `aisuggestions` (
  `suggestionId` char(36) NOT NULL,
  `description` text,
  `suggestedAt` timestamp NULL DEFAULT NULL,
  `employeeId` char(36) DEFAULT NULL,
  PRIMARY KEY (`suggestionId`),
  KEY `employeeId` (`employeeId`),
  CONSTRAINT `aisuggestions_ibfk_1` FOREIGN KEY (`employeeId`) REFERENCES `employees` (`employeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aisuggestions`
--

LOCK TABLES `aisuggestions` WRITE;
/*!40000 ALTER TABLE `aisuggestions` DISABLE KEYS */;
/*!40000 ALTER TABLE `aisuggestions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employeepassword`
--

DROP TABLE IF EXISTS `employeepassword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employeepassword` (
  `employeeId` char(36) NOT NULL,
  `password` text NOT NULL,
  PRIMARY KEY (`employeeId`),
  CONSTRAINT `employeepassword_ibfk_1` FOREIGN KEY (`employeeId`) REFERENCES `employees` (`employeeId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employeepassword`
--

LOCK TABLES `employeepassword` WRITE;
/*!40000 ALTER TABLE `employeepassword` DISABLE KEYS */;
INSERT INTO `employeepassword` VALUES ('179ef295-ffe0-4b37-90e2-fe227d8b792c','$2b$10$B957DzE.SrWqFBwDq2bIuOlzqPfzabb0Mhz3UhQvUcVOrqpj/DNtq'),('2cf5ce4d-e017-4687-8e18-28fb4ac1f685','$2b$10$JsEs/nUkAYWnFft0NMuThehsh1LnWCfB6Mhhd7LRpkIS0.2ZHEXXS'),('3f5676fe-775e-4296-b6a3-7817820e0942','$2b$10$9h7Cek.WbAPiZ0hk0FfuOezx1Cja/N/e93IlNQHwpPvkIG15eG2xO'),('4334d84a-f348-4624-9494-6b156d825882','$2b$10$5RU1E3ZUL2QyhCL7Nw2Yiu6563GEsY3qaE1EH0ky.bC49veot4zx2'),('591abce1-ed16-4881-8843-2121ed304b48','$2b$10$6ywzeZpy6XdDr2FrYkxjsOCsQROZe7vsgy4hHuk/cnHt.psDSrqI6'),('64a642d5-d7a0-4bee-bf3b-6e5e58e2aa64','$2b$10$CT.jrg.DRC4eQPdi30yHSuD5pTcZBpkLbrq7I5hhNYc/IOsnCwxje'),('6c3a2b5c-4c83-4b07-a3d4-42bc4b0bc3b2','$2b$10$jfeOKGK3KWoOSFQQdYbsYuS.CE8oanZLwZXFv2AEvciwUOoAj915O'),('7ac9dec3-74dd-4b14-a9a4-89c6df59b5f2','$2b$10$WUP2VSGoMyxLMHi/pJUtRujUqul4i0WlzkRlgdncQa9ipP2/H9voa'),('857d6a70-21ae-4711-9af0-959835cf4ee6','$2b$10$cu.6/euQOLVyYccHRaCPx.f4pHQD6CKwh2J9IIJpz3kg4pD.ZHx3e'),('8defd5e4-ffb3-4b32-8c71-b8d7ae8bd444','$2b$10$Er5BeqCGLQOxHinm3g0WQ.oJedN8mhb7nahlCkOTfuK9yroDPqH8O'),('9a1be637-859d-4e1c-b552-5ef06f1e5792','$2b$10$3u2vSyFf./9X6iYOdWGAEOEXkhjTt6zhDlrPlja5W6j3YxscoeUwe'),('9e6bc434-b404-4bd4-a119-62c5e70ac553','$2b$10$wxH0XYdLgVCHmBSt2vudXuDgbu/LhLxlmj/k337tXnZgAjcHdbShq'),('af5309d7-d156-4236-878c-2d7c3a91e67d','$2b$10$DNVHTKY7CSTXsFVxcBD0f.gzr2rF9YkMbzYqQdMfhf9D4i/KYp/GO'),('af7038c0-a596-4ae1-8073-5ad4955ff8e7','$2b$10$7p26C4x1epFIAJVmaUkp5u4SUGm7UgGEk6Hfi96Ak7fs6QFPU9A.6'),('b2dd7eb0-c697-4ea7-a9e7-4e35353405ed','$2b$10$zrR0RDrHIgaeGQ8BRLuj1OIa1ZLP6ADswjYIGCyzhwI5wRIR05zdm'),('d0a645ed-d30a-41cd-8b63-f1bb99292faa','$2b$10$krnFbD1zkKFNdj53maiy6OlqiihXoBXMIJhZ4npweHDvtTTD..K7.'),('d9578876-936e-4de1-8675-e555ac0e3e80','$2b$10$Q88r3QT/8Cb/KyItlQbwFuz0PXp0dnIfvCMLTDJrTY1l3.meyc9OC'),('da186ffe-1bd5-4547-b183-f1b1fca15a10','$2b$10$mhLMJboKqJO.Zd/0ntEqDuhWuYjJ7Shitv3ofQB2wm6aHngwNge0i'),('eb6580a0-3703-40b6-b99f-7b2e8de57fdb','$2b$10$wdN4vWMYck/JlCqiTJwEi.mOTJKO7X8JE3gT4scZ1XQJeRhPC9KFW'),('f161f536-accd-4c67-9840-30abf68f18cd','$2b$10$vZxXdY9gkT3gsgpPlqEqM.hqGWpB1sL/KeV1tHpllcbjV/8QvV2Wm'),('fa8eaa4d-a9a0-4919-959d-0d5c69e8796f','$2b$10$4482ZwoV2uO7iTC9iEbIveuDdxsFUGlzfsVMBVwkVUpjJxCasNwTO');
/*!40000 ALTER TABLE `employeepassword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `employeeId` char(36) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `supervisorId` char(36) DEFAULT NULL,
  `healthProfId` char(36) DEFAULT NULL,
  PRIMARY KEY (`employeeId`),
  KEY `employees_ibfk_1` (`supervisorId`),
  KEY `employees_ibfk_2` (`healthProfId`),
  CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`supervisorId`) REFERENCES `employees` (`employeeId`) ON DELETE SET NULL,
  CONSTRAINT `employees_ibfk_2` FOREIGN KEY (`healthProfId`) REFERENCES `healthprofessionals` (`healthProfId`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES ('179ef295-ffe0-4b37-90e2-fe227d8b792c','Ella','Sanchez','ella.sanchez@example.com','b2dd7eb0-c697-4ea7-a9e7-4e35353405ed','0e3f9145-b6a6-444f-ae3c-bc6b7a5bc4c5'),('2cf5ce4d-e017-4687-8e18-28fb4ac1f685','James','Brown','james.brown@example.com',NULL,'119bd9cc-be70-4b26-9174-eb34e97cb815'),('3f5676fe-775e-4296-b6a3-7817820e0942','admin','admin','admin@example.com',NULL,NULL),('4334d84a-f348-4624-9494-6b156d825882','Abigail','Young','abigail.young@example.com','9e6bc434-b404-4bd4-a119-62c5e70ac553','200d2cab-d2d3-4ece-9c3a-46c1fb994821'),('591abce1-ed16-4881-8843-2121ed304b48','Sophia','Clark','sophia.clark@example.com',NULL,'21ba2790-5784-4ac7-8412-85872e37e36e'),('64a642d5-d7a0-4bee-bf3b-6e5e58e2aa64','Lucas','Wilson','lucas.wilson@example.com',NULL,'119bd9cc-be70-4b26-9174-eb34e97cb815'),('6c3a2b5c-4c83-4b07-a3d4-42bc4b0bc3b2','Noah','Anderson','noah.anderson@example.com',NULL,NULL),('7ac9dec3-74dd-4b14-a9a4-89c6df59b5f2','Amelia','Davis','amelia.davis@example.com',NULL,NULL),('857d6a70-21ae-4711-9af0-959835cf4ee6','Ava','Martinez','ava.martinez@example.com',NULL,NULL),('8defd5e4-ffb3-4b32-8c71-b8d7ae8bd444','Isabella','Lee','isabella.lee@example.com','591abce1-ed16-4881-8843-2121ed304b48',NULL),('9a1be637-859d-4e1c-b552-5ef06f1e5792','Daniel','Harris','daniel.harris@example.com',NULL,NULL),('9e6bc434-b404-4bd4-a119-62c5e70ac553','Harper','Walker','harper.walker@example.com',NULL,NULL),('af5309d7-d156-4236-878c-2d7c3a91e67d','Evelyn','Perez','evelyn.perez@example.com','9a1be637-859d-4e1c-b552-5ef06f1e5792',NULL),('af7038c0-a596-4ae1-8073-5ad4955ff8e7','Olivia','Johnson','olivia.johnson@example.com','fa8eaa4d-a9a0-4919-959d-0d5c69e8796f',NULL),('b2dd7eb0-c697-4ea7-a9e7-4e35353405ed','Alexander','White','alexander.white@example.com','eb6580a0-3703-40b6-b99f-7b2e8de57fdb',NULL),('d0a645ed-d30a-41cd-8b63-f1bb99292faa','Mia','Taylor','mia.taylor@example.com','7ac9dec3-74dd-4b14-a9a4-89c6df59b5f2',NULL),('d9578876-936e-4de1-8675-e555ac0e3e80','Mason','Garcia','mason.garcia@example.com','2cf5ce4d-e017-4687-8e18-28fb4ac1f685',NULL),('da186ffe-1bd5-4547-b183-f1b1fca15a10','Liam','Thompson','liam.thompson@example.com','6c3a2b5c-4c83-4b07-a3d4-42bc4b0bc3b2',NULL),('eb6580a0-3703-40b6-b99f-7b2e8de57fdb','Benjamin','Moore','benjamin.moore@example.com',NULL,NULL),('f161f536-accd-4c67-9840-30abf68f18cd','Ethan','Robinson','ethan.robinson@example.com','64a642d5-d7a0-4bee-bf3b-6e5e58e2aa64',NULL),('fa8eaa4d-a9a0-4919-959d-0d5c69e8796f','Emma','Smith','emma.smith@example.com',NULL,NULL);
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employeewellnesslogs`
--

DROP TABLE IF EXISTS `employeewellnesslogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employeewellnesslogs` (
  `logId` char(36) NOT NULL,
  `stress` int DEFAULT NULL,
  `mood` varchar(255) DEFAULT NULL,
  `comments` text,
  `physicalSymptoms` text,
  `recordedAt` timestamp NULL DEFAULT NULL,
  `employeeId` char(36) DEFAULT NULL,
  PRIMARY KEY (`logId`),
  KEY `employeewellnesslogs_ibfk_1` (`employeeId`),
  CONSTRAINT `employeewellnesslogs_ibfk_1` FOREIGN KEY (`employeeId`) REFERENCES `employees` (`employeeId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employeewellnesslogs`
--

LOCK TABLES `employeewellnesslogs` WRITE;
/*!40000 ALTER TABLE `employeewellnesslogs` DISABLE KEYS */;
INSERT INTO `employeewellnesslogs` VALUES ('1a524b86-a738-4520-92d0-455dcdcb604d',3,'Content','Had a productive day at work; enjoyed a walk during lunch.','Mild headache, slight tension in shoulders.','2024-11-01 22:44:47','179ef295-ffe0-4b37-90e2-fe227d8b792c'),('1f42988e-3455-4fb6-bac1-3c48a787577b',1,'Calm','Had a restful weekend; practiced mindfulness and meditation.','None','2024-11-01 22:45:44','2cf5ce4d-e017-4687-8e18-28fb4ac1f685'),('8147baf9-0151-4bd2-b9b4-711cd5a584cf',5,'Anxious','Felt overwhelmed with deadlines approaching; needed to take a break.','Fatigue, stomach discomfort','2024-11-01 22:45:05','4334d84a-f348-4624-9494-6b156d825882'),('b1efd84f-202a-4cc7-a3a9-9efdf03b840f',2,'Happy','Spent quality time with friends; felt relaxed and supported.','None','2024-11-01 22:45:17','591abce1-ed16-4881-8843-2121ed304b48'),('f5bee16a-edab-4ca1-aa6d-633b61cec001',4,'Frustrated','Encountered unexpected issues at work that caused delays.','Increased heart rate, tightness in chest','2024-11-01 22:45:33','64a642d5-d7a0-4bee-bf3b-6e5e58e2aa64');
/*!40000 ALTER TABLE `employeewellnesslogs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `healthprofessionalpassword`
--

DROP TABLE IF EXISTS `healthprofessionalpassword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `healthprofessionalpassword` (
  `healthProfId` char(36) NOT NULL,
  `password` text,
  PRIMARY KEY (`healthProfId`),
  CONSTRAINT `healthprofessionalpassword_ibfk_1` FOREIGN KEY (`healthProfId`) REFERENCES `healthprofessionals` (`healthProfId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `healthprofessionalpassword`
--

LOCK TABLES `healthprofessionalpassword` WRITE;
/*!40000 ALTER TABLE `healthprofessionalpassword` DISABLE KEYS */;
INSERT INTO `healthprofessionalpassword` VALUES ('0e3f9145-b6a6-444f-ae3c-bc6b7a5bc4c5','$2b$10$1BCQT0wSodQOjPdllBa3W.edpv5Gzzizqow6rBmvYImMvstC.Gc7O'),('119bd9cc-be70-4b26-9174-eb34e97cb815','$2b$10$qBJ4GS6l5VuQzKaJtvIunO3p2O6BfGaSvLsjOK4WjJvZ6vZOhHWEe'),('200d2cab-d2d3-4ece-9c3a-46c1fb994821','$2b$10$dskPtPJ/Oey1xAhKyi9hYeYD5lmzTZ9e7OzSQkwRSr7VV1wk82bV.'),('21ba2790-5784-4ac7-8412-85872e37e36e','$2b$10$plxtOqVN2Sz/kvl5e0T0ne8wzzEQpXNvXEB4GI1IK6bhb4Ds.48uq'),('2435f73b-4520-43d7-a005-2373ebb3782f','$2b$10$riXtMA.XrrNWD66I78J6jeo54ukoReMwBzokgZuY82/8NX33um9du'),('590cccee-6703-4835-8191-fe1c271be283','$2b$10$1iyIPlToQzrqhZC5wnofGe07qYdAf14oVCUwabqvKgvZFIKxLl8FW'),('5d2955f5-08e0-4ab0-898f-7ecff7c8cda3','$2b$10$dsjrNr4jpg6XHVfVX9Fc6OxQj3FJ8kGMWqJulWDeid1t1O7KdUqp2'),('6a148ed5-32d6-41b4-98fd-d16bafcb7083','$2b$10$0LmULEYTUJYKj5013LXXAe/G3EI4GB2DzL9hmZcHD2SpHvCyHdSwO'),('6f06c1b1-22ac-40db-b68b-c8ddab800994','$2b$10$4MWB5wKzvkg6BnczVX5P/efbLmrHTWN8RgNTJf9.DYsjgDe4zj2ZO'),('6f1d6e99-14ae-427b-95a8-48e797a95344','$2b$10$bgxD4wJ.PL83kMG7YlvDhe0e1BZK0FTfJG7xqAPGQPStv3NDcWKzu'),('884e8d6e-576a-4879-b75b-132742a140f5','$2b$10$h8B5kL6B81ZIR2xgOwmV/OwDSEsKkn5iS7YxA/JbRgLz7jDZCMuTi'),('952c40c7-dd2a-4d45-98f8-c5a542f84434','$2b$10$f/TV0tdecKbBOaUAbbQgkO98Zn.ASHQniBPDjUPSR2THY2N52d7uS'),('95aa4a86-3d56-47b1-a672-a613a47f6fa4','$2b$10$zKYFdh85l19stiwRU0R4iO6sOAKLN6lI7zMf4rrP8WXqptiWP6TXK'),('98443cd1-4bf0-419f-b0cb-398320ff96cc','$2b$10$EJS6s1hPmwOMG5pT8ENrJ.hBVqXlphcHUfbLe4Tt8rkWeIsQJW7bW'),('a012c1ee-633b-4c0c-82be-01752823f472','$2b$10$7zL84CkSv0ztDTJ4n9e9eO8/uohRJRnZbXUN8TrxKhKTgLUnEnf4.'),('a34e033d-34e1-4d6a-a6c3-1f692ea98860','$2b$10$jSEy67a4pfKwV.QQsqg9S.qvi7LXP9SmqrKrpcic6eSYWml7AZn5.'),('bd2ae168-6365-4e23-9964-6ce2c6ccc436','$2b$10$/wwDIELCU3AHJuq/CQF4t.76Ut.54fQI1xHe84N/UxpqyQliu/8LS'),('c0dbb178-2049-472a-b696-3002197913ee','$2b$10$FC156EuGu6Dmj4XAmGYy1.z448VLvOJOdkiSyFT3lFiOsJGlGkuqG'),('cd185772-5c01-4b8a-8469-cd3949f1ec75','$2b$10$uH.jZxXWpd8kgYom8tHwtub90vFqAXSLeiNBC6V9IWAU/rfbkHVbu'),('f2498b74-d1e8-4a11-871c-fe91d9d4d8e3','$2b$10$B7q1LqP3BnURScAMrPplduSrhgoGM94ULtTSze29YPvWzFfRC6EgC');
/*!40000 ALTER TABLE `healthprofessionalpassword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `healthprofessionals`
--

DROP TABLE IF EXISTS `healthprofessionals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `healthprofessionals` (
  `healthProfId` char(36) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `specialization` varchar(255) NOT NULL,
  PRIMARY KEY (`healthProfId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `healthprofessionals`
--

LOCK TABLES `healthprofessionals` WRITE;
/*!40000 ALTER TABLE `healthprofessionals` DISABLE KEYS */;
INSERT INTO `healthprofessionals` VALUES ('0e3f9145-b6a6-444f-ae3c-bc6b7a5bc4c5','Stephanie','Rogers','stephanie.rogers@healthcare.com','Behavioral Health Specialist'),('119bd9cc-be70-4b26-9174-eb34e97cb815','Megan','Scott','megan.scott@healthcare.com','Anxiety Disorder Specialist'),('200d2cab-d2d3-4ece-9c3a-46c1fb994821','Sarah','Bennett','sarah.bennett@example.com','Physical Therapist'),('21ba2790-5784-4ac7-8412-85872e37e36e','Emily','Foster','emily.foster@example.com','Nutritionist'),('2435f73b-4520-43d7-a005-2373ebb3782f','Brandon','Green','brandon.green@healthcare.com','Grief Counselor'),('590cccee-6703-4835-8191-fe1c271be283','Michael','Carter','michael.carter@example.com','Psychologist'),('5d2955f5-08e0-4ab0-898f-7ecff7c8cda3','David','Green','david.green@example.com','Sports Medicine Doctor'),('6a148ed5-32d6-41b4-98fd-d16bafcb7083','Sarah','Thompson','sarah.thompson@healthcare.com','Clinical Psychologist'),('6f06c1b1-22ac-40db-b68b-c8ddab800994','Joshua','Davis','joshua.davis@healthcare.com','Mental Health Counselor'),('6f1d6e99-14ae-427b-95a8-48e797a95344','Michael','Ramirez','michael.ramirez@healthcare.com','Psychiatrist'),('884e8d6e-576a-4879-b75b-132742a140f5','Christopher','Martinez','christopher.martinez@healthcare.com','Depression Counselor'),('952c40c7-dd2a-4d45-98f8-c5a542f84434','Daniel','Evans','daniel.evans@healthcare.com','Addiction Counselor'),('95aa4a86-3d56-47b1-a672-a613a47f6fa4','Laura','Peterson','laura.peterson@healthcare.com','Cognitive Behavioral Therapist'),('98443cd1-4bf0-419f-b0cb-398320ff96cc','Laura','Howard','laura.howard@example.com','Mental Health Counselor'),('a012c1ee-633b-4c0c-82be-01752823f472','Ashley','Turner','ashley.turner@healthcare.com','Psychotherapist'),('a34e033d-34e1-4d6a-a6c3-1f692ea98860','Jessica','Miller','jessica.miller@healthcare.com','Psychologist'),('bd2ae168-6365-4e23-9964-6ce2c6ccc436','Andrew','Lopez','andrew.lopez@healthcare.com','Licensed Clinical Social Worker (LCSW)'),('c0dbb178-2049-472a-b696-3002197913ee','Rachel','Walker','rachel.walker@healthcare.com','Behavioral Therapist'),('cd185772-5c01-4b8a-8469-cd3949f1ec75','Emily','Carter','emily.carter@healthcare.com','Family Therapist'),('f2498b74-d1e8-4a11-871c-fe91d9d4d8e3','David','Morgan','david.morgan@healthcare.com','Trauma Specialist');
/*!40000 ALTER TABLE `healthprofessionals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mindfulnessactivitylog`
--

DROP TABLE IF EXISTS `mindfulnessactivitylog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mindfulnessactivitylog` (
  `logId` char(36) NOT NULL,
  `comments` text,
  `timestamp` timestamp NULL DEFAULT NULL,
  `techniqueId` char(36) DEFAULT NULL,
  `employeeId` char(36) DEFAULT NULL,
  PRIMARY KEY (`logId`),
  KEY `mindfulnessactivitylog_ibfk_2` (`employeeId`),
  KEY `mindfulnessactivitylog_ibfk_1` (`techniqueId`),
  CONSTRAINT `mindfulnessactivitylog_ibfk_1` FOREIGN KEY (`techniqueId`) REFERENCES `mindfulnesstechniques` (`techniqueId`) ON DELETE CASCADE,
  CONSTRAINT `mindfulnessactivitylog_ibfk_2` FOREIGN KEY (`employeeId`) REFERENCES `employees` (`employeeId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mindfulnessactivitylog`
--

LOCK TABLES `mindfulnessactivitylog` WRITE;
/*!40000 ALTER TABLE `mindfulnessactivitylog` DISABLE KEYS */;
INSERT INTO `mindfulnessactivitylog` VALUES ('3c85276b-1920-46ce-8e8d-389cf8815947','I have recovered from burnout!','2024-11-01 22:31:04','ae6d42df-387a-46a7-a937-37599d4c58ba','2cf5ce4d-e017-4687-8e18-28fb4ac1f685'),('7ed48cf9-dbd4-45b6-9afe-231f73a01dbf','worked really well!','2024-11-01 22:30:40','33901bd9-abfc-40c9-9a64-7acfdc629252','2cf5ce4d-e017-4687-8e18-28fb4ac1f685'),('914fef51-c885-4182-94fc-a2a1fac5b212','It was ok','2024-11-01 22:30:33','158df9e3-86c6-4e8c-ab7f-7b93185cdfb7','2cf5ce4d-e017-4687-8e18-28fb4ac1f685'),('dccada32-a729-4cd7-9f53-b158f894083f','Challenging, but effective','2024-11-01 22:31:26','ea3897ea-be31-4a09-8255-39a35fba4d12','2cf5ce4d-e017-4687-8e18-28fb4ac1f685'),('f28b22f1-7d7d-45e9-ba87-0cc0b8df28d4','I didn\'t really understand it','2024-11-01 22:31:18','6e2bb596-caf2-43a0-a197-c7074758ce2c','2cf5ce4d-e017-4687-8e18-28fb4ac1f685');
/*!40000 ALTER TABLE `mindfulnessactivitylog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mindfulnessrecommendations`
--

DROP TABLE IF EXISTS `mindfulnessrecommendations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mindfulnessrecommendations` (
  `recommendationId` char(36) NOT NULL,
  `recommendedAt` timestamp NOT NULL,
  `techniqueId` char(36) NOT NULL,
  `employeeId` char(36) NOT NULL,
  `supervisorId` char(36) DEFAULT NULL,
  `healthProfId` char(36) DEFAULT NULL,
  PRIMARY KEY (`recommendationId`),
  KEY `mindfulnessrecommendations_ibfk_2` (`employeeId`),
  KEY `mindfulnessrecommendations_ibfk_3` (`supervisorId`),
  KEY `mindfulnessrecommendations_ibfk_4` (`healthProfId`),
  KEY `mindfulnessrecommendations_ibfk_1` (`techniqueId`),
  CONSTRAINT `mindfulnessrecommendations_ibfk_1` FOREIGN KEY (`techniqueId`) REFERENCES `mindfulnesstechniques` (`techniqueId`) ON DELETE CASCADE,
  CONSTRAINT `mindfulnessrecommendations_ibfk_2` FOREIGN KEY (`employeeId`) REFERENCES `employees` (`employeeId`) ON DELETE CASCADE,
  CONSTRAINT `mindfulnessrecommendations_ibfk_3` FOREIGN KEY (`supervisorId`) REFERENCES `employees` (`employeeId`) ON DELETE SET NULL,
  CONSTRAINT `mindfulnessrecommendations_ibfk_4` FOREIGN KEY (`healthProfId`) REFERENCES `healthprofessionals` (`healthProfId`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mindfulnessrecommendations`
--

LOCK TABLES `mindfulnessrecommendations` WRITE;
/*!40000 ALTER TABLE `mindfulnessrecommendations` DISABLE KEYS */;
INSERT INTO `mindfulnessrecommendations` VALUES ('51e616eb-6b6b-42e1-9e5a-dce9a5ed2a22','2024-11-01 22:27:37','158df9e3-86c6-4e8c-ab7f-7b93185cdfb7','2cf5ce4d-e017-4687-8e18-28fb4ac1f685',NULL,'119bd9cc-be70-4b26-9174-eb34e97cb815'),('6db6bf5e-39c2-4759-af90-e582b14c1fe7','2024-11-01 22:27:45','33901bd9-abfc-40c9-9a64-7acfdc629252','2cf5ce4d-e017-4687-8e18-28fb4ac1f685',NULL,'119bd9cc-be70-4b26-9174-eb34e97cb815'),('8410e971-28c9-4c8f-8b88-2e44c4e64e6f','2024-11-01 22:27:58','ae6d42df-387a-46a7-a937-37599d4c58ba','2cf5ce4d-e017-4687-8e18-28fb4ac1f685',NULL,'119bd9cc-be70-4b26-9174-eb34e97cb815'),('9c62bdb2-350c-483a-a72e-bdda29fa0865','2024-11-01 22:27:51','6e2bb596-caf2-43a0-a197-c7074758ce2c','2cf5ce4d-e017-4687-8e18-28fb4ac1f685',NULL,'119bd9cc-be70-4b26-9174-eb34e97cb815'),('e48377d1-0700-477e-8af5-d40e3772270a','2024-11-01 22:28:07','ea3897ea-be31-4a09-8255-39a35fba4d12','2cf5ce4d-e017-4687-8e18-28fb4ac1f685',NULL,'119bd9cc-be70-4b26-9174-eb34e97cb815');
/*!40000 ALTER TABLE `mindfulnessrecommendations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mindfulnesstechniques`
--

DROP TABLE IF EXISTS `mindfulnesstechniques`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mindfulnesstechniques` (
  `techniqueId` char(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `duration` int DEFAULT NULL,
  `difficultyLevel` varchar(50) DEFAULT NULL,
  `createdAt` timestamp NOT NULL,
  `healthProfId` char(36) DEFAULT NULL,
  `link` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`techniqueId`),
  KEY `mindfulnesstechniques_ibfk_1` (`healthProfId`),
  CONSTRAINT `mindfulnesstechniques_ibfk_1` FOREIGN KEY (`healthProfId`) REFERENCES `healthprofessionals` (`healthProfId`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mindfulnesstechniques`
--

LOCK TABLES `mindfulnesstechniques` WRITE;
/*!40000 ALTER TABLE `mindfulnesstechniques` DISABLE KEYS */;
INSERT INTO `mindfulnesstechniques` VALUES ('158df9e3-86c6-4e8c-ab7f-7b93185cdfb7','Body Scan Meditation','This practice guides you to mentally scan your body from head to toe, noting areas of tension and promoting relaxation. It\'s a great way to connect with your body and release stress.',10,'medium','2024-11-01 22:24:10','119bd9cc-be70-4b26-9174-eb34e97cb815','https://www.mindful.org/body-scan-meditation/'),('33901bd9-abfc-40c9-9a64-7acfdc629252','Loving-Kindness Meditation','Loving-Kindness Meditation',15,'medium','2024-11-01 22:24:34','119bd9cc-be70-4b26-9174-eb34e97cb815','https://www.mindful.org/a-loving-kindness-meditation-to-boost-compassion/'),('6e2bb596-caf2-43a0-a197-c7074758ce2c','Deep Mindfulness Meditation','A more advanced technique designed to fully immerse you in the present moment by observing thoughts, emotions, and sensations without judgment. It requires strong focus and self-discipline.',30,'hard','2024-11-01 22:25:08','119bd9cc-be70-4b26-9174-eb34e97cb815','https://www.mindful.org/mindfulness-how-to-do-it/'),('ae6d42df-387a-46a7-a937-37599d4c58ba','Walking Meditation','A mindfulness practice done while walking, focusing on the sensations of each step and the rhythm of walking. It’s an active meditation that promotes both physical and mental balance.',10,'easy','2024-11-01 22:24:50','119bd9cc-be70-4b26-9174-eb34e97cb815','https://www.mindful.org/daily-mindful-walking-practice/'),('ea3897ea-be31-4a09-8255-39a35fba4d12','5-Minute Breathing Space','A quick practice to create mental clarity and calm by focusing solely on the breath. Ideal for beginners, this exercise helps you regain focus and relax in just five minutes.',5,'easy','2024-11-01 22:23:53','119bd9cc-be70-4b26-9174-eb34e97cb815','https://www.mindful.org/five-minute-breathing-space-practice/');
/*!40000 ALTER TABLE `mindfulnesstechniques` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timemanagementactivitylog`
--

DROP TABLE IF EXISTS `timemanagementactivitylog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timemanagementactivitylog` (
  `logId` char(36) NOT NULL,
  `comments` text,
  `timestamp` timestamp NULL DEFAULT NULL,
  `toolId` char(36) DEFAULT NULL,
  `employeeId` char(36) DEFAULT NULL,
  PRIMARY KEY (`logId`),
  KEY `timemanagementactivitylog_ibfk_2` (`employeeId`),
  KEY `timemanagementactivitylog_ibfk_1` (`toolId`),
  CONSTRAINT `timemanagementactivitylog_ibfk_1` FOREIGN KEY (`toolId`) REFERENCES `timemanagementtools` (`toolId`) ON DELETE CASCADE,
  CONSTRAINT `timemanagementactivitylog_ibfk_2` FOREIGN KEY (`employeeId`) REFERENCES `employees` (`employeeId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timemanagementactivitylog`
--

LOCK TABLES `timemanagementactivitylog` WRITE;
/*!40000 ALTER TABLE `timemanagementactivitylog` DISABLE KEYS */;
INSERT INTO `timemanagementactivitylog` VALUES ('12618a6d-6031-41c6-ab24-393f432be4b8','Awesome','2024-11-01 22:42:12','8208cd0a-a0cc-4cbf-a3c1-ace586ee1a10','179ef295-ffe0-4b37-90e2-fe227d8b792c'),('4c51871d-3ca4-493f-ad70-4129a95f081d','no comment','2024-11-01 22:42:27','3405ca4b-8329-4790-91df-60306c6c35d9','179ef295-ffe0-4b37-90e2-fe227d8b792c'),('4c8c818a-6e12-4b28-923b-7df2752e6963','Worked really well!','2024-11-01 22:42:00','e0f1ff51-8535-4cef-b762-f27136632bf0','179ef295-ffe0-4b37-90e2-fe227d8b792c'),('5a8a68e6-6e5e-4985-8996-a2b879db0164','Didn\'t really work','2024-11-01 22:42:07','7e9d84ae-12ec-49c3-b690-496fb436d80c','179ef295-ffe0-4b37-90e2-fe227d8b792c'),('76e26e47-6ebe-4030-9a24-149c74e4edf1','I\'m so productive now','2024-11-01 22:42:20','5d839cb3-8698-409f-9595-cd39782126f1','179ef295-ffe0-4b37-90e2-fe227d8b792c');
/*!40000 ALTER TABLE `timemanagementactivitylog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timemanagementrecommendations`
--

DROP TABLE IF EXISTS `timemanagementrecommendations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timemanagementrecommendations` (
  `recommendationId` char(36) NOT NULL,
  `recommendedAt` timestamp NOT NULL,
  `toolid` char(36) NOT NULL,
  `employeeId` char(36) NOT NULL,
  `supervisorId` char(36) DEFAULT NULL,
  `healthProfId` char(36) DEFAULT NULL,
  PRIMARY KEY (`recommendationId`),
  KEY `timemanagementrecommendations_ibfk_2` (`employeeId`),
  KEY `timemanagementrecommendations_ibfk_3` (`supervisorId`),
  KEY `timemanagementrecommendations_ibfk_4` (`healthProfId`),
  KEY `timemanagementrecommendations_ibfk_1` (`toolid`),
  CONSTRAINT `timemanagementrecommendations_ibfk_1` FOREIGN KEY (`toolid`) REFERENCES `timemanagementtools` (`toolId`) ON DELETE CASCADE,
  CONSTRAINT `timemanagementrecommendations_ibfk_2` FOREIGN KEY (`employeeId`) REFERENCES `employees` (`employeeId`) ON DELETE CASCADE,
  CONSTRAINT `timemanagementrecommendations_ibfk_3` FOREIGN KEY (`supervisorId`) REFERENCES `employees` (`employeeId`) ON DELETE SET NULL,
  CONSTRAINT `timemanagementrecommendations_ibfk_4` FOREIGN KEY (`healthProfId`) REFERENCES `healthprofessionals` (`healthProfId`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timemanagementrecommendations`
--

LOCK TABLES `timemanagementrecommendations` WRITE;
/*!40000 ALTER TABLE `timemanagementrecommendations` DISABLE KEYS */;
INSERT INTO `timemanagementrecommendations` VALUES ('11d3ca7d-2e1d-4ebb-ba2b-360ae5850ced','2024-11-01 22:39:56','e0f1ff51-8535-4cef-b762-f27136632bf0','179ef295-ffe0-4b37-90e2-fe227d8b792c',NULL,'0e3f9145-b6a6-444f-ae3c-bc6b7a5bc4c5'),('21b17323-7c16-4c68-a88f-bdfc0dbd3b62','2024-11-01 22:39:44','7e9d84ae-12ec-49c3-b690-496fb436d80c','179ef295-ffe0-4b37-90e2-fe227d8b792c',NULL,'0e3f9145-b6a6-444f-ae3c-bc6b7a5bc4c5'),('2806af98-578d-487d-b2c4-0d7779164772','2024-11-01 22:39:49','8208cd0a-a0cc-4cbf-a3c1-ace586ee1a10','179ef295-ffe0-4b37-90e2-fe227d8b792c',NULL,'0e3f9145-b6a6-444f-ae3c-bc6b7a5bc4c5'),('2dcb13b7-26ff-49c6-8e00-31fb83f073c3','2024-11-01 22:39:38','5d839cb3-8698-409f-9595-cd39782126f1','179ef295-ffe0-4b37-90e2-fe227d8b792c',NULL,'0e3f9145-b6a6-444f-ae3c-bc6b7a5bc4c5'),('d5770fd4-85f3-4838-9c04-2ddd8f38db81','2024-11-01 22:39:31','3405ca4b-8329-4790-91df-60306c6c35d9','179ef295-ffe0-4b37-90e2-fe227d8b792c',NULL,'0e3f9145-b6a6-444f-ae3c-bc6b7a5bc4c5');
/*!40000 ALTER TABLE `timemanagementrecommendations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timemanagementtools`
--

DROP TABLE IF EXISTS `timemanagementtools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timemanagementtools` (
  `toolId` char(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `createdAt` timestamp NOT NULL,
  `healthProfId` char(36) DEFAULT NULL,
  `link` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`toolId`),
  KEY `timemanagementtools_ibfk_1` (`healthProfId`),
  CONSTRAINT `timemanagementtools_ibfk_1` FOREIGN KEY (`healthProfId`) REFERENCES `healthprofessionals` (`healthProfId`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timemanagementtools`
--

LOCK TABLES `timemanagementtools` WRITE;
/*!40000 ALTER TABLE `timemanagementtools` DISABLE KEYS */;
INSERT INTO `timemanagementtools` VALUES ('3405ca4b-8329-4790-91df-60306c6c35d9','Todoist','Todoist is a task manager that lets you create to-do lists, prioritize tasks, and set reminders. It’s great for breaking down large projects into smaller tasks and staying on top of deadlines.','2024-11-01 22:37:41','0e3f9145-b6a6-444f-ae3c-bc6b7a5bc4c5','https://todoist.com/'),('5d839cb3-8698-409f-9595-cd39782126f1','Trello','Trello is a task management tool that uses boards and lists to help organize projects and tasks. It’s perfect for personal or team use, and it integrates with other tools to streamline workflows.','2024-11-01 22:37:19','0e3f9145-b6a6-444f-ae3c-bc6b7a5bc4c5','https://trello.com/'),('7e9d84ae-12ec-49c3-b690-496fb436d80c','RescueTime','RescueTime helps you understand how you spend your time online by tracking activities and giving insights into your productivity. It also allows you to set goals and block distracting sites to keep you focused.','2024-11-01 22:37:29','0e3f9145-b6a6-444f-ae3c-bc6b7a5bc4c5','https://www.rescuetime.com/'),('8208cd0a-a0cc-4cbf-a3c1-ace586ee1a10','Focus Booster','Focus Booster is a tool based on the Pomodoro technique, where you work in short, timed intervals with breaks in between. It helps you maintain productivity while avoiding burnout.','2024-11-01 22:38:00','0e3f9145-b6a6-444f-ae3c-bc6b7a5bc4c5','https://www.focusboosterapp.com/'),('e0f1ff51-8535-4cef-b762-f27136632bf0','Toggl Track','Toggl Track is a simple and powerful time-tracking tool that helps you monitor where your time goes. Whether you are working on multiple projects or tasks, Toggl provides detailed reports to improve productivity.','2024-11-01 22:36:56','0e3f9145-b6a6-444f-ae3c-bc6b7a5bc4c5','https://toggl.com/track/');
/*!40000 ALTER TABLE `timemanagementtools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wearabledatalogs`
--

DROP TABLE IF EXISTS `wearabledatalogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wearabledatalogs` (
  `logId` char(36) NOT NULL,
  `heartRate` int DEFAULT NULL,
  `steps` int DEFAULT NULL,
  `sleep` double DEFAULT NULL,
  `recordedAt` timestamp NULL DEFAULT NULL,
  `employeeId` char(36) DEFAULT NULL,
  PRIMARY KEY (`logId`),
  KEY `employeeId` (`employeeId`),
  CONSTRAINT `wearabledatalogs_ibfk_1` FOREIGN KEY (`employeeId`) REFERENCES `employees` (`employeeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wearabledatalogs`
--

LOCK TABLES `wearabledatalogs` WRITE;
/*!40000 ALTER TABLE `wearabledatalogs` DISABLE KEYS */;
/*!40000 ALTER TABLE `wearabledatalogs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-21 16:53:56
