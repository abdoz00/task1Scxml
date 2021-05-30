CREATE DATABASE  IF NOT EXISTS `injaz` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `injaz`;
-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: localhost    Database: injaz
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
-- Table structure for table `database_profile`
--

DROP TABLE IF EXISTS `database_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `database_profile` (
  `profile_id` varchar(100) NOT NULL,
  `profile_name` varchar(255) NOT NULL,
  `data_source` varchar(100) DEFAULT NULL,
  `is_transaction` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_profile`
--

LOCK TABLES `database_profile` WRITE;
/*!40000 ALTER TABLE `database_profile` DISABLE KEYS */;
INSERT INTO `database_profile` VALUES ('userProfile','userProfile','user',0);
/*!40000 ALTER TABLE `database_profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `database_query`
--

DROP TABLE IF EXISTS `database_query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `database_query` (
  `query_id` varchar(100) NOT NULL,
  `query_sql` varchar(2048) NOT NULL,
  `query_type` enum('INSERT','SELECT','DELETE','UPDATE') NOT NULL,
  PRIMARY KEY (`query_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `database_query`
--

LOCK TABLES `database_query` WRITE;
/*!40000 ALTER TABLE `database_query` DISABLE KEYS */;
INSERT INTO `database_query` VALUES ('getUserInfo','SELECT * from user where user.userName = :$inputUserName','SELECT');
/*!40000 ALTER TABLE `database_query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `http_server_request`
--

DROP TABLE IF EXISTS `http_server_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `http_server_request` (
  `uri_path` varchar(255) NOT NULL,
  `content_type` varchar(50) DEFAULT NULL,
  `parsing_type` varchar(50) DEFAULT NULL,
  `parameters` varchar(255) DEFAULT NULL,
  `generic_error_response` varchar(100) DEFAULT NULL,
  `flow_id` varchar(100) NOT NULL,
  `marker_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uri_path`),
  KEY `fk_http_server_request_error_response_idx` (`generic_error_response`),
  KEY `fk_http_server_request_flow_id_idx` (`flow_id`),
  KEY `fk_http_server_request_parsing_type_idx` (`parsing_type`),
  KEY `fk_http_server_request_content_type_idx` (`content_type`),
  CONSTRAINT `fk_http_server_request_content_type` FOREIGN KEY (`content_type`) REFERENCES `http_content_type` (`id`),
  CONSTRAINT `fk_http_server_request_error_response` FOREIGN KEY (`generic_error_response`) REFERENCES `http_server_response` (`id`),
  CONSTRAINT `fk_http_server_request_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `service_flow` (`flow_id`),
  CONSTRAINT `fk_http_server_request_parsing_type` FOREIGN KEY (`parsing_type`) REFERENCES `http_parsing_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `http_server_request`
--

LOCK TABLES `http_server_request` WRITE;
/*!40000 ALTER TABLE `http_server_request` DISABLE KEYS */;
INSERT INTO `http_server_request` VALUES ('/injaz/hello','application/json','json','','GENERIC_ERROR','HELLO_WORLD','CONFIDENTIAL'),('/injaz/login','application/json','json',NULL,'GENERIC_ERROR','USER_AUTH','CONFIDENTIAL');
/*!40000 ALTER TABLE `http_server_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_query`
--

DROP TABLE IF EXISTS `profile_query`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profile_query` (
  `query_id` varchar(100) NOT NULL,
  `profile_id` varchar(100) NOT NULL,
  `query_order` int NOT NULL,
  PRIMARY KEY (`query_id`,`profile_id`),
  KEY `transaction_config_query_1_idx` (`query_id`),
  KEY `transaction_config_query_2` (`profile_id`),
  CONSTRAINT `transaction_config_query_1` FOREIGN KEY (`query_id`) REFERENCES `database_query` (`query_id`),
  CONSTRAINT `transaction_config_query_2` FOREIGN KEY (`profile_id`) REFERENCES `database_profile` (`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_query`
--

LOCK TABLES `profile_query` WRITE;
/*!40000 ALTER TABLE `profile_query` DISABLE KEYS */;
INSERT INTO `profile_query` VALUES ('getUserInfo','userProfile',1);
/*!40000 ALTER TABLE `profile_query` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_flow`
--

DROP TABLE IF EXISTS `service_flow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_flow` (
  `flow_id` varchar(100) NOT NULL,
  `fsm` mediumblob NOT NULL,
  `is_enabled` tinyint(1) NOT NULL,
  `flow_name` varchar(255) DEFAULT NULL,
  `tracer_name` varchar(100) DEFAULT NULL,
  `pool_initial_size` int NOT NULL,
  `pool_extension_size` int NOT NULL,
  `pool_max_size` int NOT NULL,
  `pool_steady_size` int NOT NULL,
  PRIMARY KEY (`flow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_flow`
--

LOCK TABLES `service_flow` WRITE;
/*!40000 ALTER TABLE `service_flow` DISABLE KEYS */;
INSERT INTO `service_flow` VALUES ('HELLO_WORLD',_binary '<?xml version=\"1.0\"?>\n\n<scxml\n	xmlns=\"http://www.w3.org/2005/07/scxml\" version=\"1.0\"\n	xmlns:injaz=\"http://actions.injaz.edafa.com/injaz\"\n	xmlns:http=\"http://actions.injaz.edafa.com/http\"\n>\n\n	<datamodel>\n		<data id=\"name\" expr=\"null\"/>\n		<data id=\"stateName\" expr=\"null\"/>\n		<data id=\"flowStartTime\" expr=\"null\"/>\n	</datamodel>\n\n	<state id=\"IDLE\">\n\n		<transition event=\"HttpRequest.POST\">\n			<assign location=\"stateName\" expr=\"\'IDLE\'\"/>\n			<assign location=\"flowStartTime\" expr=\'new (\"java.util.Date\").getTime()\'/>\n\n			<injaz:Log logLevel=\"\'info\'\" message=\"stateName + \' | event=\' + _event.name + \', Request, requestParameters=\' + _event.data\" marker=\"\'CONFIDENTIAL\'\"/>\n\n			<assign location=\"name\" expr=\"_event.data.get(\'name\')\"/>\n\n			<raise event=\"internal.idle.parametersStored\"/>\n		</transition>\n\n		<transition event=\"internal.idle.parametersStored\" target=\"FINAL\"/>\n\n	</state>\n\n	<state id=\"FINAL\">\n\n		<onentry>\n			<assign location=\"stateName\" expr=\"\'FINAL\'\"/>\n\n			<http:Respond profileID=\"\'JSON_RESPONSE\'\">\n				<ResponseParams>\n					<ResponseParam name=\"responseId\" value=\"\'hello \'+name\"/>\n				</ResponseParams>\n			</http:Respond>\n\n			<assign location=\"flowEndTime\" expr=\'new (\"java.util.Date\").getTime()\'/>\n			<assign location=\"flowDurationTime\" expr=\"flowEndTime - flowStartTime\"/>\n\n		</onentry>\n\n	</state>\n\n</scxml>\n',0,'first fsm','com.edafa.pgw.flow.hello_world',5,1,10,7),('USER_AUTH',_binary '<?xml version=\"1.0\"?>\n\n<scxml\n	xmlns=\"http://www.w3.org/2005/07/scxml\" version=\"1.0\"\n	\n	xmlns:injaz=\"http://actions.injaz.edafa.com/injaz\"\n	xmlns:http=\"http://actions.injaz.edafa.com/http\"\n	xmlns:db=\"http://actions.injaz.edafa.com/db\"\n	xmlns:kpi=\"http://actions.injaz.edafa.com/kpi\"\n	>\n\n\n	<datamodel>\n\n		<!-- Request Parameters -->\n		<data id=\"userName\" expr=\"null\"/>\n		<data id=\"password\" expr=\"null\"/>\n		<data id=\"sessionId\" expr=\"null\"/>\n		<data id=\"status\" expr=\"\'FAIL\'\"/>\n\n		<!-- log Parameters -->\n		<data id=\"stateName\" expr=\"null\"/>\n\n\n		<!-- db parameters -->\n		<data id=\"profileID\" expr=\"null\"/>\n		<data id=\"queryId\" expr=\"null\"/>\n		<data id=\"dbResponse\" expr=\"null\"/>\n		<data id=\"dbResult\" expr=\"null\"/>\n		\n		<data id=\"hashedPass\" expr=\"null\"/>\n		<!-- http parameters -->\n		<data id=\"url\" expr=\"null\"/>\n		<data id=\"httpResponse\" expr=\"null\"/>\n		<data id=\"httpResult\" expr=\"null\"/>\n		\n		<!--kpis-->\n		<data id=\"kpiContext\" expr=\"\'login.serviceflows\'\"/>\n		<data id=\"kpiSetSystem\" expr=\"\'system_counters\'\"/>\n\n	</datamodel>\n\n\n	<state id=\"IDLE\">\n\n		<transition event=\"HttpRequest.POST\">\n\n			<assign location=\"stateName\" expr=\"\'IDLE\'\"/>\n			<injaz:Log logLevel=\"\'info\'\" message=\"stateName + \' | event=\' + _event.name + \', Request, requestParameters=\' + _event.data\" marker=\"\'CONFIDENTIAL\'\"/>\n			\n\n			<if cond=\"_event.data.containsKey(\'userName\') and _event.data.containsKey(\'password\')\">\n				<assign location=\"password\" expr=\"_event.data.get(\'password\')\"/>\n				<assign location=\"userName\" expr=\"_event.data.get(\'userName\')\"/>\n				<injaz:Hash prefix=\"\'\'\" data=\"password\" response=\"hashedPass\"/>\n				<raise event=\"internal.idle.parametersStored\"/>\n				<injaz:Log logLevel=\"\'info\'\" message=\"stateName + \' in if condition\'\"/>\n\n\n			<else/>\n				<raise event=\"internal.idle.invalidRequestParameters\"/>\n				<assign location=\"status\" expr=\"\'Invalid request parameters\'\"/>\n				<injaz:Log logLevel=\"\'info\'\" message=\"stateName + \' in else condition\'\"/>\n			</if>\n\n\n		</transition>\n\n		<transition event=\"internal.idle.invalidRequestParameters\" target=\"FINAL\"/>\n		<transition event=\"internal.idle.parametersStored\" target=\"CHECK_AUTH\"/>\n\n	</state>\n\n\n\n	<state id=\"CHECK_AUTH\">\n\n		<onentry>\n\n			<assign location=\"stateName\" expr=\"\'CHECK_AUTH\'\"/>\n			<assign location=\"profileID\" expr=\"\'userProfile\'\"/>\n			<assign location=\"queryId\" expr=\"\'getUserInfo\'\"/>\n\n			<db:Execute profileID=\"profileID\" response=\"dbResponse\">\n				<QueryParams>\n					<QueryParam name=\"$inputUserName\" value=\"userName\"/>\n				</QueryParams>\n\n				<Queries>\n						<Query id=\"getUserInfo\" enable=\"true\"/>\n				</Queries>\n\n			</db:Execute>\n\n			<assign location=\"dbResult\" expr=\"dbResponse.getResponse().getDbResponse().get(queryId).getResponseObject().getSelectedRows()\"/>\n\n			<injaz:Log logLevel=\"\'info\'\" message=\"\'dbResult= \'+dbResult\"/>\n\n			<if cond=\"dbResult.size()>0\">\n				<if cond=\"dbResult.get(0).get(\'password\').equals(hashedPass)\">\n					<injaz:GenerateID prefix=\"\'id\'\"\n						dateFormat=\"\'yyMMddHHmmssS\'\" response=\"sessionId\" />\n					<assign location=\"status\" expr=\"\'Success\'\"/>\n					<raise event=\"internal.check_auth.checked\"/>\n				<else/>\n					<assign location=\"status\" expr=\"\'userName or password are invalid\'\"/>\n					<raise event=\"internal.check_auth.failed\"/>\n				</if>\n			\n			<else/>\n				<assign location=\"status\" expr=\"\'userName or password are invalid\'\"/>				\n				<raise event=\"internal.check_auth.failed\"/>\n			</if>	\n		</onentry>\n\n			<transition event=\"internal.check_auth.checked\" target=\"FINAL\"/>\n			<transition event=\"internal.check_auth.failed\" target=\"FINAL\"/>\n		\n	</state>\n\n	<state id=\"FINAL\">\n\n		<onentry>\n\n			<assign location=\"stateName\" expr=\"\'FINAL\'\"/>\n\n			<http:Respond profileID=\"\'JSON_RESPONSE\'\">\n				<ResponseParams>\n					<ResponseParam name=\"sessionId\" value=\"sessionId\"/>\n 					<ResponseParam name=\"status\" value=\"status\" />\n\n				</ResponseParams>\n			</http:Respond>\n\n		</onentry>\n			\n\n\n	</state>\n\n\n</scxml>\n\n\n	',1,'check_auth','com.edafa.training.tasks.user_auth',5,2,10,7);
/*!40000 ALTER TABLE `service_flow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_flow_custom_action`
--

DROP TABLE IF EXISTS `service_flow_custom_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_flow_custom_action` (
  `service_flow_id` varchar(100) NOT NULL,
  `custom_action_name` varchar(100) NOT NULL,
  PRIMARY KEY (`service_flow_id`,`custom_action_name`),
  KEY `fk_service_flow_custom_action_flow_action_idx` (`custom_action_name`),
  CONSTRAINT `fk_service_flow_custom_action_action` FOREIGN KEY (`custom_action_name`) REFERENCES `custom_action` (`name`),
  CONSTRAINT `fk_service_flow_custom_action_flow` FOREIGN KEY (`service_flow_id`) REFERENCES `service_flow` (`flow_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

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
