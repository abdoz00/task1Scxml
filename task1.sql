USE `injaz`;
-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: injaz
-- ------------------------------------------------------
-- Server version	8.0.25

--
-- Dumping data for table `database_profile`
--

LOCK TABLES `database_profile` WRITE;
/*!40000 ALTER TABLE `database_profile` DISABLE KEYS */;
INSERT INTO `database_profile` VALUES ('userProfile','userProfile','user',0);
/*!40000 ALTER TABLE `database_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `database_query`
--

LOCK TABLES `database_query` WRITE;
/*!40000 ALTER TABLE `database_query` DISABLE KEYS */;
INSERT INTO `database_query` VALUES ('getUserInfo','SELECT * from user where user.userName = :$inputUserName','SELECT');
/*!40000 ALTER TABLE `database_query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `http_server_request`
--

LOCK TABLES `http_server_request` WRITE;
/*!40000 ALTER TABLE `http_server_request` DISABLE KEYS */;
INSERT INTO `http_server_request` VALUES ('/injaz/hello','application/json','json','','GENERIC_ERROR','HELLO_WORLD','CONFIDENTIAL'),('/injaz/login','application/json','json',NULL,'GENERIC_ERROR','USER_AUTH','CONFIDENTIAL');
/*!40000 ALTER TABLE `http_server_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `profile_query`
--

LOCK TABLES `profile_query` WRITE;
/*!40000 ALTER TABLE `profile_query` DISABLE KEYS */;
INSERT INTO `profile_query` VALUES ('getUserInfo','userProfile',1);
/*!40000 ALTER TABLE `profile_query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `service_flow`
--

LOCK TABLES `service_flow` WRITE;
/*!40000 ALTER TABLE `service_flow` DISABLE KEYS */;
INSERT INTO `service_flow` VALUES ('HELLO_WORLD','</FSM>',0,'first fsm','com.edafa.pgw.flow.hello_world',5,1,10,7),('USER_AUTH','</FSM>',1,'check_auth','com.edafa.training.tasks.user_auth',5,2,10,7);
/*!40000 ALTER TABLE `service_flow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `service_flow_custom_action`
--

LOCK TABLES `service_flow_custom_action` WRITE;
/*!40000 ALTER TABLE `service_flow_custom_action` DISABLE KEYS */;
INSERT INTO `service_flow_custom_action` VALUES ('USER_AUTH','Execute'),('USER_AUTH','GenerateID'),('USER_AUTH','Hash'),('HELLO_WORLD','Log'),('USER_AUTH','Log'),('HELLO_WORLD','Respond'),('USER_AUTH','Respond');
/*!40000 ALTER TABLE `service_flow_custom_action` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-30 15:11:34
CREATE DATABASE  IF NOT EXISTS `user` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `user`;
-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: user
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userName` varchar(45) NOT NULL,
  `password` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `user_name_UNIQUE` (`userName`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'abdo','03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-30 15:11:34
