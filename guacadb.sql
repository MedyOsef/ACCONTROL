/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.1-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: guacadb
-- ------------------------------------------------------
-- Server version	11.8.1-MariaDB-2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `guacamole_connection`
--

DROP TABLE IF EXISTS `guacamole_connection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection` (
  `connection_id` int(11) NOT NULL AUTO_INCREMENT,
  `connection_name` varchar(128) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `protocol` varchar(32) NOT NULL,
  `proxy_port` int(11) DEFAULT NULL,
  `proxy_hostname` varchar(512) DEFAULT NULL,
  `proxy_encryption_method` enum('NONE','SSL') DEFAULT NULL,
  `max_connections` int(11) DEFAULT NULL,
  `max_connections_per_user` int(11) DEFAULT NULL,
  `connection_weight` int(11) DEFAULT NULL,
  `failover_only` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`connection_id`),
  UNIQUE KEY `connection_name_parent` (`connection_name`,`parent_id`),
  KEY `guacamole_connection_ibfk_1` (`parent_id`),
  CONSTRAINT `guacamole_connection_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `guacamole_connection_group` (`connection_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection`
--

LOCK TABLES `guacamole_connection` WRITE;
/*!40000 ALTER TABLE `guacamole_connection` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `guacamole_connection` VALUES
(4,'SERVEUR DE FICHIER',NULL,'rdp',NULL,NULL,NULL,NULL,NULL,NULL,0),
(5,'TULEAP',NULL,'ssh',NULL,NULL,NULL,NULL,NULL,NULL,0),
(6,'SERVEUR AD SECONDAIRE',NULL,'rdp',NULL,NULL,NULL,NULL,NULL,NULL,0),
(7,'WWW',NULL,'ssh',NULL,NULL,NULL,NULL,NULL,NULL,0),
(8,'SIGP',NULL,'ssh',NULL,NULL,NULL,NULL,NULL,NULL,0),
(9,'GLPI',NULL,'ssh',NULL,NULL,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `guacamole_connection` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_connection_attribute`
--

DROP TABLE IF EXISTS `guacamole_connection_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection_attribute` (
  `connection_id` int(11) NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`connection_id`,`attribute_name`),
  KEY `connection_id` (`connection_id`),
  CONSTRAINT `guacamole_connection_attribute_ibfk_1` FOREIGN KEY (`connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_attribute`
--

LOCK TABLES `guacamole_connection_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_attribute` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `guacamole_connection_attribute` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_connection_group`
--

DROP TABLE IF EXISTS `guacamole_connection_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection_group` (
  `connection_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `connection_group_name` varchar(128) NOT NULL,
  `type` enum('ORGANIZATIONAL','BALANCING') NOT NULL DEFAULT 'ORGANIZATIONAL',
  `max_connections` int(11) DEFAULT NULL,
  `max_connections_per_user` int(11) DEFAULT NULL,
  `enable_session_affinity` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`connection_group_id`),
  UNIQUE KEY `connection_group_name_parent` (`connection_group_name`,`parent_id`),
  KEY `guacamole_connection_group_ibfk_1` (`parent_id`),
  CONSTRAINT `guacamole_connection_group_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `guacamole_connection_group` (`connection_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_group`
--

LOCK TABLES `guacamole_connection_group` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_group` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `guacamole_connection_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_connection_group_attribute`
--

DROP TABLE IF EXISTS `guacamole_connection_group_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection_group_attribute` (
  `connection_group_id` int(11) NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`connection_group_id`,`attribute_name`),
  KEY `connection_group_id` (`connection_group_id`),
  CONSTRAINT `guacamole_connection_group_attribute_ibfk_1` FOREIGN KEY (`connection_group_id`) REFERENCES `guacamole_connection_group` (`connection_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_group_attribute`
--

LOCK TABLES `guacamole_connection_group_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_group_attribute` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `guacamole_connection_group_attribute` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_connection_group_permission`
--

DROP TABLE IF EXISTS `guacamole_connection_group_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection_group_permission` (
  `entity_id` int(11) NOT NULL,
  `connection_group_id` int(11) NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`connection_group_id`,`permission`),
  KEY `guacamole_connection_group_permission_ibfk_1` (`connection_group_id`),
  CONSTRAINT `guacamole_connection_group_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_connection_group_permission_ibfk_1` FOREIGN KEY (`connection_group_id`) REFERENCES `guacamole_connection_group` (`connection_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_group_permission`
--

LOCK TABLES `guacamole_connection_group_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_group_permission` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `guacamole_connection_group_permission` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_connection_history`
--

DROP TABLE IF EXISTS `guacamole_connection_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection_history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(128) NOT NULL,
  `remote_host` varchar(256) DEFAULT NULL,
  `connection_id` int(11) DEFAULT NULL,
  `connection_name` varchar(128) NOT NULL,
  `sharing_profile_id` int(11) DEFAULT NULL,
  `sharing_profile_name` varchar(128) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `user_id` (`user_id`),
  KEY `connection_id` (`connection_id`),
  KEY `sharing_profile_id` (`sharing_profile_id`),
  KEY `start_date` (`start_date`),
  KEY `end_date` (`end_date`),
  KEY `connection_start_date` (`connection_id`,`start_date`),
  CONSTRAINT `guacamole_connection_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE SET NULL,
  CONSTRAINT `guacamole_connection_history_ibfk_2` FOREIGN KEY (`connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE SET NULL,
  CONSTRAINT `guacamole_connection_history_ibfk_3` FOREIGN KEY (`sharing_profile_id`) REFERENCES `guacamole_sharing_profile` (`sharing_profile_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_history`
--

LOCK TABLES `guacamole_connection_history` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_history` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `guacamole_connection_history` VALUES
(7,2,'kamagate.idrissa','10.222.221.3',NULL,'Serveur_Fichier',NULL,NULL,'2025-04-30 15:56:19','2025-04-30 15:56:29'),
(8,2,'kamagate.idrissa','10.222.221.3',NULL,'Serveur_Fichier',NULL,NULL,'2025-04-30 15:56:47','2025-04-30 15:56:57'),
(9,2,'kamagate.idrissa','10.222.221.3',NULL,'Serveur_Fichier',NULL,NULL,'2025-04-30 15:57:58','2025-04-30 15:58:08'),
(10,2,'kamagate.idrissa','10.222.221.3',NULL,'Serveur_Fichier',NULL,NULL,'2025-04-30 15:58:56','2025-04-30 15:59:06'),
(11,2,'kamagate.idrissa','10.222.221.3',NULL,'Serveur_Fichier',NULL,NULL,'2025-04-30 16:00:31','2025-04-30 16:00:36'),
(12,2,'kamagate.idrissa','10.222.221.3',NULL,'Serveur_Fichier',NULL,NULL,'2025-04-30 16:00:37','2025-04-30 16:00:47'),
(13,2,'kamagate.idrissa','10.222.221.3',NULL,'Tuleap',NULL,NULL,'2025-04-30 16:00:57','2025-04-30 16:01:36'),
(14,2,'kamagate.idrissa','10.222.221.3',NULL,'Tuleap',NULL,NULL,'2025-04-30 16:01:36','2025-04-30 16:01:45'),
(15,1,'guacadmin','10.222.221.3',NULL,'Serveur_Fichier',NULL,NULL,'2025-04-30 16:02:45','2025-04-30 16:02:46'),
(16,2,'kamagate.idrissa','10.222.221.3',NULL,'Serveur_Fichier',NULL,NULL,'2025-04-30 16:03:05','2025-04-30 16:03:05'),
(17,2,'kamagate.idrissa','10.222.221.3',NULL,'Serveur_Fichier',NULL,NULL,'2025-04-30 16:03:09','2025-04-30 16:03:09'),
(18,2,'kamagate.idrissa','10.222.221.3',NULL,'Serveur_Fichier',NULL,NULL,'2025-04-30 16:03:15','2025-04-30 16:03:16'),
(19,2,'kamagate.idrissa','10.222.221.3',NULL,'Tuleap',NULL,NULL,'2025-04-30 16:03:18','2025-04-30 16:03:40'),
(20,2,'kamagate.idrissa','10.222.221.3',NULL,'Tuleap',NULL,NULL,'2025-04-30 16:03:41','2025-04-30 16:03:44'),
(21,2,'kamagate.idrissa','10.222.221.3',NULL,'Serveur_Fichier',NULL,NULL,'2025-04-30 16:04:26','2025-04-30 16:04:27'),
(22,2,'kamagate.idrissa','10.222.221.3',NULL,'Tuleap',NULL,NULL,'2025-04-30 16:04:30','2025-04-30 16:05:00'),
(23,2,'kamagate.idrissa','10.222.221.3',NULL,'Tuleap',NULL,NULL,'2025-04-30 16:05:01','2025-04-30 16:06:06'),
(24,2,'kamagate.idrissa','10.222.221.3',NULL,'Serveur_Fichier',NULL,NULL,'2025-04-30 16:05:52','2025-04-30 16:05:53'),
(25,2,'kamagate.idrissa','10.222.221.3',NULL,'Serveur_Fichier',NULL,NULL,'2025-04-30 16:06:08','2025-04-30 16:06:09'),
(26,2,'kamagate.idrissa','10.222.221.3',4,'SERVEUR DE FICHIER',NULL,NULL,'2025-04-30 16:08:53','2025-04-30 16:08:54'),
(27,2,'kamagate.idrissa','10.222.221.3',4,'SERVEUR DE FICHIER',NULL,NULL,'2025-04-30 16:26:03','2025-04-30 16:30:41'),
(28,2,'kamagate.idrissa','10.222.221.3',5,'TULEAP',NULL,NULL,'2025-04-30 16:31:20','2025-04-30 16:32:10'),
(29,2,'kamagate.idrissa','10.222.221.3',5,'TULEAP',NULL,NULL,'2025-04-30 16:33:12','2025-04-30 16:34:02'),
(30,1,'guacadmin','10.222.221.3',5,'TULEAP',NULL,NULL,'2025-04-30 16:34:01','2025-04-30 16:34:02'),
(31,2,'kamagate.idrissa','10.222.221.3',4,'SERVEUR DE FICHIER',NULL,NULL,'2025-04-30 16:34:05','2025-04-30 16:35:50'),
(32,1,'guacadmin','10.222.221.3',4,'SERVEUR DE FICHIER',NULL,NULL,'2025-04-30 16:34:18','2025-04-30 16:34:44'),
(33,1,'guacadmin','10.222.221.3',4,'SERVEUR DE FICHIER',NULL,NULL,'2025-04-30 16:35:29','2025-04-30 16:35:31'),
(34,1,'guacadmin','10.222.221.3',5,'TULEAP',NULL,NULL,'2025-04-30 16:38:25','2025-04-30 16:38:30'),
(35,2,'kamagate.idrissa','10.222.221.3',4,'SERVEUR DE FICHIER',NULL,NULL,'2025-04-30 16:54:39','2025-04-30 16:56:42'),
(36,2,'kamagate.idrissa','10.222.221.3',5,'TULEAP',NULL,NULL,'2025-04-30 16:55:05','2025-04-30 16:55:18'),
(37,2,'kamagate.idrissa','10.222.221.3',5,'TULEAP',NULL,NULL,'2025-04-30 16:55:22','2025-04-30 16:55:43'),
(38,2,'kamagate.idrissa','127.0.0.1',4,'SERVEUR DE FICHIER',NULL,NULL,'2025-04-30 18:39:27','2025-04-30 18:40:48'),
(39,1,'guacadmin','10.222.221.3',5,'TULEAP',NULL,NULL,'2025-05-02 09:10:43','2025-05-02 09:10:50'),
(40,3,'ac.guard','127.0.0.1',4,'SERVEUR DE FICHIER',NULL,NULL,'2025-05-06 14:48:58','2025-05-06 14:49:16'),
(41,3,'ac.guard','127.0.0.1',4,'SERVEUR DE FICHIER',NULL,NULL,'2025-05-06 14:49:27','2025-05-06 14:49:51'),
(42,2,'kamagate.idrissa','127.0.0.1',6,'SERVEUR AD SECONDAIRE',NULL,NULL,'2025-05-07 14:05:17','2025-05-07 14:06:34'),
(43,2,'kamagate.idrissa','127.0.0.1',5,'TULEAP',NULL,NULL,'2025-05-07 14:06:40','2025-05-07 14:08:00'),
(44,2,'kamagate.idrissa','127.0.0.1',6,'SERVEUR AD SECONDAIRE',NULL,NULL,'2025-05-07 14:09:09','2025-05-07 14:09:42'),
(45,10,'diallo.sisse','127.0.0.1',4,'SERVEUR DE FICHIER',NULL,NULL,'2025-05-07 16:02:51','2025-05-07 16:04:04'),
(46,10,'diallo.sisse','127.0.0.1',9,'GLPI',NULL,NULL,'2025-05-07 16:03:12','2025-05-07 16:04:08'),
(47,10,'diallo.sisse','127.0.0.1',5,'TULEAP',NULL,NULL,'2025-05-07 16:03:25','2025-05-07 16:04:06'),
(48,2,'kamagate.idrissa','127.0.0.1',6,'SERVEUR AD SECONDAIRE',NULL,NULL,'2025-05-12 10:09:08','2025-05-12 10:09:44'),
(49,2,'kamagate.idrissa','127.0.0.1',7,'WWW',NULL,NULL,'2025-05-12 10:09:48','2025-05-12 10:09:58'),
(50,2,'kamagate.idrissa','127.0.0.1',5,'TULEAP',NULL,NULL,'2025-05-12 10:10:02','2025-05-12 10:10:23'),
(51,11,'marc','127.0.0.1',4,'SERVEUR DE FICHIER',NULL,NULL,'2025-05-12 10:13:02','2025-05-12 10:13:43'),
(52,11,'marc','127.0.0.1',4,'SERVEUR DE FICHIER',NULL,NULL,'2025-05-12 10:13:42','2025-05-12 10:13:48'),
(53,11,'marc','127.0.0.1',6,'SERVEUR AD SECONDAIRE',NULL,NULL,'2025-05-12 10:14:06','2025-05-12 10:14:54');
/*!40000 ALTER TABLE `guacamole_connection_history` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_connection_parameter`
--

DROP TABLE IF EXISTS `guacamole_connection_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection_parameter` (
  `connection_id` int(11) NOT NULL,
  `parameter_name` varchar(128) NOT NULL,
  `parameter_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`connection_id`,`parameter_name`),
  CONSTRAINT `guacamole_connection_parameter_ibfk_1` FOREIGN KEY (`connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_parameter`
--

LOCK TABLES `guacamole_connection_parameter` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_parameter` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `guacamole_connection_parameter` VALUES
(4,'create-recording-path','true'),
(4,'enable-desktop-composition','true'),
(4,'enable-font-smoothing','true'),
(4,'enable-full-window-drag','true'),
(4,'enable-menu-animations','true'),
(4,'enable-theming','true'),
(4,'enable-wallpaper','true'),
(4,'hostname','10.3.5.1'),
(4,'ignore-cert','true'),
(4,'password','${GUAC_PASSWORD}'),
(4,'recording-include-keys','true'),
(4,'recording-name','${GUAC_DATE}-${GUAC_TIME}-RDP-${GUAC_USERNAME}'),
(4,'recording-path','${HISTORY_PATH}/${HISTORY_UUID}'),
(4,'server-layout','fr-fr-azerty'),
(4,'timezone','Africa/Abidjan'),
(4,'username','${GUAC_USERNAME}'),
(5,'create-recording-path','true'),
(5,'hostname','10.222.223.7'),
(5,'port','2222'),
(5,'recording-include-keys','true'),
(5,'recording-name','${GUAC_DATE}-${GUAC_TIME}-SSH-${GUAC_USERNAME}'),
(5,'recording-path','${HISTORY_PATH}/${HISTORY_UUID}'),
(6,'create-recording-path','true'),
(6,'enable-desktop-composition','true'),
(6,'enable-font-smoothing','true'),
(6,'enable-full-window-drag','true'),
(6,'enable-menu-animations','true'),
(6,'enable-theming','true'),
(6,'enable-wallpaper','true'),
(6,'hostname','10.3.6.1'),
(6,'ignore-cert','true'),
(6,'password','${GUAC_PASSWORD}'),
(6,'recording-include-keys','true'),
(6,'recording-name','${GUAC_DATE}-${GUAC_TIME}-RDP-${GUAC_USERNAME}'),
(6,'recording-path','${HISTORY_PATH}/${HISTORY_UUID}'),
(6,'server-layout','fr-fr-azerty'),
(6,'timezone','Africa/Abidjan'),
(6,'username','${GUAC_USERNAME}'),
(7,'create-recording-path','true'),
(7,'hostname','10.222.223.2'),
(7,'recording-include-keys','true'),
(7,'recording-name','${GUAC_DATE}-${GUAC_TIME}-SSH-${GUAC_USERNAME}'),
(7,'recording-path','${HISTORY_PATH}/${HISTORY_UUID}'),
(8,'create-recording-path','true'),
(8,'hostname','10.222.223.222'),
(8,'recording-include-keys','true'),
(8,'recording-name','${GUAC_DATE}-${GUAC_TIME}-SSH-${GUAC_USERNAME}'),
(8,'recording-path','${HISTORY_PATH}/${HISTORY_UUID}'),
(9,'create-recording-path','true'),
(9,'hostname','10.3.4.77'),
(9,'recording-include-keys','true'),
(9,'recording-name','${GUAC_DATE}-${GUAC_TIME}-SSH-${GUAC_USERNAME}'),
(9,'recording-path','${HISTORY_PATH}/${HISTORY_UUID}');
/*!40000 ALTER TABLE `guacamole_connection_parameter` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_connection_permission`
--

DROP TABLE IF EXISTS `guacamole_connection_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_connection_permission` (
  `entity_id` int(11) NOT NULL,
  `connection_id` int(11) NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`connection_id`,`permission`),
  KEY `guacamole_connection_permission_ibfk_1` (`connection_id`),
  CONSTRAINT `guacamole_connection_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_connection_permission_ibfk_1` FOREIGN KEY (`connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_connection_permission`
--

LOCK TABLES `guacamole_connection_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_connection_permission` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `guacamole_connection_permission` VALUES
(2,4,'READ'),
(2,4,'UPDATE'),
(2,4,'DELETE'),
(2,4,'ADMINISTER'),
(5,4,'READ'),
(8,4,'READ'),
(9,4,'READ'),
(10,4,'READ'),
(11,4,'READ'),
(12,4,'READ'),
(14,4,'READ'),
(15,4,'READ'),
(16,4,'READ'),
(19,4,'READ'),
(2,5,'READ'),
(2,5,'UPDATE'),
(2,5,'DELETE'),
(2,5,'ADMINISTER'),
(5,5,'READ'),
(9,5,'READ'),
(10,5,'READ'),
(11,5,'READ'),
(12,5,'READ'),
(19,5,'READ'),
(2,6,'READ'),
(2,6,'UPDATE'),
(2,6,'DELETE'),
(2,6,'ADMINISTER'),
(5,6,'READ'),
(8,6,'READ'),
(9,6,'READ'),
(2,7,'READ'),
(2,7,'UPDATE'),
(2,7,'DELETE'),
(2,7,'ADMINISTER'),
(5,7,'READ'),
(9,7,'READ'),
(2,8,'READ'),
(2,8,'UPDATE'),
(2,8,'DELETE'),
(2,8,'ADMINISTER'),
(18,8,'READ'),
(2,9,'READ'),
(2,9,'UPDATE'),
(2,9,'DELETE'),
(2,9,'ADMINISTER'),
(20,9,'READ');
/*!40000 ALTER TABLE `guacamole_connection_permission` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_entity`
--

DROP TABLE IF EXISTS `guacamole_entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_entity` (
  `entity_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `type` enum('USER','USER_GROUP') NOT NULL,
  PRIMARY KEY (`entity_id`),
  UNIQUE KEY `guacamole_entity_name_scope` (`type`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_entity`
--

LOCK TABLES `guacamole_entity` WRITE;
/*!40000 ALTER TABLE `guacamole_entity` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `guacamole_entity` VALUES
(3,'ac.guard','USER'),
(13,'cherel.koffi','USER'),
(15,'comblan.guedou','USER'),
(19,'diabagate','USER'),
(16,'diallo.sisse','USER'),
(14,'djane.nguettia','USER'),
(1,'guacadmin','USER'),
(10,'jonas','USER'),
(2,'kamagate.idrissa','USER'),
(17,'marc','USER'),
(18,'siagbe.delon','USER'),
(11,'soumanou','USER'),
(12,'tia.brice','USER'),
(20,'zeng','USER'),
(9,'GroupeA0','USER_GROUP'),
(5,'GroupeA1','USER_GROUP'),
(8,'GroupeA2','USER_GROUP'),
(7,'GroupeA3','USER_GROUP');
/*!40000 ALTER TABLE `guacamole_entity` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_sharing_profile`
--

DROP TABLE IF EXISTS `guacamole_sharing_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_sharing_profile` (
  `sharing_profile_id` int(11) NOT NULL AUTO_INCREMENT,
  `sharing_profile_name` varchar(128) NOT NULL,
  `primary_connection_id` int(11) NOT NULL,
  PRIMARY KEY (`sharing_profile_id`),
  UNIQUE KEY `sharing_profile_name_primary` (`sharing_profile_name`,`primary_connection_id`),
  KEY `guacamole_sharing_profile_ibfk_1` (`primary_connection_id`),
  CONSTRAINT `guacamole_sharing_profile_ibfk_1` FOREIGN KEY (`primary_connection_id`) REFERENCES `guacamole_connection` (`connection_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_sharing_profile`
--

LOCK TABLES `guacamole_sharing_profile` WRITE;
/*!40000 ALTER TABLE `guacamole_sharing_profile` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `guacamole_sharing_profile` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_sharing_profile_attribute`
--

DROP TABLE IF EXISTS `guacamole_sharing_profile_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_sharing_profile_attribute` (
  `sharing_profile_id` int(11) NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`sharing_profile_id`,`attribute_name`),
  KEY `sharing_profile_id` (`sharing_profile_id`),
  CONSTRAINT `guacamole_sharing_profile_attribute_ibfk_1` FOREIGN KEY (`sharing_profile_id`) REFERENCES `guacamole_sharing_profile` (`sharing_profile_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_sharing_profile_attribute`
--

LOCK TABLES `guacamole_sharing_profile_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_sharing_profile_attribute` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `guacamole_sharing_profile_attribute` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_sharing_profile_parameter`
--

DROP TABLE IF EXISTS `guacamole_sharing_profile_parameter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_sharing_profile_parameter` (
  `sharing_profile_id` int(11) NOT NULL,
  `parameter_name` varchar(128) NOT NULL,
  `parameter_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`sharing_profile_id`,`parameter_name`),
  CONSTRAINT `guacamole_sharing_profile_parameter_ibfk_1` FOREIGN KEY (`sharing_profile_id`) REFERENCES `guacamole_sharing_profile` (`sharing_profile_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_sharing_profile_parameter`
--

LOCK TABLES `guacamole_sharing_profile_parameter` WRITE;
/*!40000 ALTER TABLE `guacamole_sharing_profile_parameter` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `guacamole_sharing_profile_parameter` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_sharing_profile_permission`
--

DROP TABLE IF EXISTS `guacamole_sharing_profile_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_sharing_profile_permission` (
  `entity_id` int(11) NOT NULL,
  `sharing_profile_id` int(11) NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`sharing_profile_id`,`permission`),
  KEY `guacamole_sharing_profile_permission_ibfk_1` (`sharing_profile_id`),
  CONSTRAINT `guacamole_sharing_profile_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_sharing_profile_permission_ibfk_1` FOREIGN KEY (`sharing_profile_id`) REFERENCES `guacamole_sharing_profile` (`sharing_profile_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_sharing_profile_permission`
--

LOCK TABLES `guacamole_sharing_profile_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_sharing_profile_permission` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `guacamole_sharing_profile_permission` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_system_permission`
--

DROP TABLE IF EXISTS `guacamole_system_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_system_permission` (
  `entity_id` int(11) NOT NULL,
  `permission` enum('CREATE_CONNECTION','CREATE_CONNECTION_GROUP','CREATE_SHARING_PROFILE','CREATE_USER','CREATE_USER_GROUP','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`permission`),
  CONSTRAINT `guacamole_system_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_system_permission`
--

LOCK TABLES `guacamole_system_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_system_permission` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `guacamole_system_permission` VALUES
(1,'CREATE_CONNECTION'),
(1,'CREATE_CONNECTION_GROUP'),
(1,'CREATE_SHARING_PROFILE'),
(1,'CREATE_USER'),
(1,'CREATE_USER_GROUP'),
(1,'ADMINISTER'),
(2,'CREATE_CONNECTION'),
(2,'CREATE_CONNECTION_GROUP'),
(2,'CREATE_SHARING_PROFILE'),
(2,'CREATE_USER'),
(2,'CREATE_USER_GROUP'),
(2,'ADMINISTER'),
(3,'CREATE_CONNECTION'),
(3,'CREATE_CONNECTION_GROUP'),
(3,'CREATE_SHARING_PROFILE'),
(3,'CREATE_USER'),
(3,'CREATE_USER_GROUP'),
(3,'ADMINISTER'),
(5,'CREATE_CONNECTION'),
(5,'CREATE_CONNECTION_GROUP'),
(5,'CREATE_SHARING_PROFILE'),
(5,'CREATE_USER'),
(5,'CREATE_USER_GROUP'),
(5,'ADMINISTER'),
(9,'ADMINISTER'),
(10,'ADMINISTER'),
(11,'CREATE_CONNECTION'),
(11,'CREATE_CONNECTION_GROUP'),
(11,'CREATE_SHARING_PROFILE'),
(11,'CREATE_USER'),
(11,'CREATE_USER_GROUP'),
(11,'ADMINISTER'),
(12,'ADMINISTER');
/*!40000 ALTER TABLE `guacamole_system_permission` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_user`
--

DROP TABLE IF EXISTS `guacamole_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` int(11) NOT NULL,
  `password_hash` binary(32) NOT NULL,
  `password_salt` binary(32) DEFAULT NULL,
  `password_date` datetime NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT 0,
  `expired` tinyint(1) NOT NULL DEFAULT 0,
  `access_window_start` time DEFAULT NULL,
  `access_window_end` time DEFAULT NULL,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `timezone` varchar(64) DEFAULT NULL,
  `full_name` varchar(256) DEFAULT NULL,
  `email_address` varchar(256) DEFAULT NULL,
  `organization` varchar(256) DEFAULT NULL,
  `organizational_role` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `guacamole_user_single_entity` (`entity_id`),
  CONSTRAINT `guacamole_user_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user`
--

LOCK TABLES `guacamole_user` WRITE;
/*!40000 ALTER TABLE `guacamole_user` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `guacamole_user` VALUES
(1,1,' Eä}IN;Ë$ı··u°UléÔ,-}Ûc;ÏJ)ƒA`','˛$≠≈·+%(ç´Êzy„BÏ¬`dŒi≈≥wï®\"d','2025-04-30 10:01:31',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(2,2,'“5èŒñ˜\0x®úŸÏHêe§à´ÆÅ” 8öB\\Q','3L¸èÁwá^J\noíï9_ä·.Ÿ@ÁKÎ“Ç8uô','2025-04-30 11:17:21',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(3,3,'¢»f∂–›˚_õ°*,~pä3:<ÆúÄº:ÓÇ~X\"X','ËÉ]¸ä≠éyV¬¬u:∏1˙(\r>T«æ¿›-∏','2025-04-30 11:28:42',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(4,10,'–%5˚xñˇ%—ÏÑ T:◊E‹n„!çßﬁ±F#Hœ5∂','`7Ü”rq¯ÀÃ˝<em°∑ï%Üóˇ	Ø4¢»ñõ','2025-05-06 15:19:59',0,0,NULL,NULL,'2025-05-05',NULL,'Africa/Abidjan','Jonas Koffi','jonas.koffi@budget.gouv.ci','DSIB','Sous Directeur'),
(5,11,'Sû=ˇz©k·I©≤®˝K˘I\0âí\"Ω˚“=·m9F','¥ÀÍqjRŸÇÉ∫ó◊B+àrÃ#¿$@4{∑≤xß´','2025-05-06 15:29:56',0,0,NULL,NULL,'2025-05-05',NULL,'Africa/Abidjan','Soumanou Bian Paul Henri Eusebuo','soumanou@budget.gouv.ci','DSIB','Chez de Service'),
(6,12,'ß¢_gUeX€Í?Búr\"Ÿm¨Ç‰€ﬂ‘jâòªò0}˛`','ÓÈØ‡jO≥9ÇjDü4é∑πl‰~“àﬁÍ’€A&L†b˙ö','2025-05-06 15:37:49',0,0,NULL,NULL,'2025-05-05',NULL,'Africa/Abidjan','Detho Brice Tia','tia.brice@budget.gouv.ci','DBA','--'),
(7,13,'	:B	Kø˚@{\Z5¶\'€s5FP|‰ëktc‘\'µ˚\Z˚c','òÀ—¨Â‰&7*WÈ\"€FQÚ∂.à´1‘TûÀtˆv','2025-05-06 15:45:03',0,0,NULL,NULL,'2025-05-05',NULL,'Africa/Abidjan','Koffi Jean Cherel Yao','cherel.koffi@budget.gouv.ci','DSIB',NULL),
(8,14,'ã¬w–aLÅHlzA\0ãáØö\0ï€9\0X0[<é”Bè','ï(`yÉî{ü;ÀY≈Ò)yÖÈ‹›C‰°î⁄Ri˝¥','2025-05-06 15:52:20',0,0,NULL,NULL,'2025-05-05',NULL,'Africa/Abidjan',NULL,NULL,NULL,NULL),
(9,15,'QF©ç-`_g∏©ŸmÍïÒà>©Ò3\r≤æíy	7£','Ö◊ÌcáÆƒL#´8À†¥{¬√Å•°êcÈ§{“DË©‹','2025-05-06 16:07:27',0,0,NULL,NULL,'2025-05-05',NULL,NULL,'Comblan Joseph D√©sir√© GUEDOU',NULL,NULL,NULL),
(10,16,'»ÏL|à¡√@n{»◊8â¡ê·ÁEÚ˜Íß˙ÁPà','(ôÈ\\á√x¨A\Z·Èíù\r∫`ÏÎ_@L™h(¨êQ<','2025-05-06 16:11:02',0,0,NULL,NULL,'2025-05-05',NULL,'Africa/Abidjan','Salimata DIALLO n√©e SISSE','diallo.sisse@budget.gouv.ci','DSIB',NULL),
(11,17,'\Z•\"qwÉCtÓcà\nÃ^€sœÑ√}eß4Y‰¸\\','Æ∑N‡X]0èüÖ(Œ4Zq[∞ë]¿twä∂±‹','2025-05-06 16:13:44',0,0,NULL,NULL,'2025-05-05',NULL,'Africa/Abidjan','YAO Yao Jean Marc',NULL,NULL,NULL),
(12,18,'Œ^_LñÔ∫¶d¡ˇÆº’¯√\nüMØﬂ∫¬!¿∏aSÖ≠','9ÎAKØ™_	ó˙Ù»bπB}ãÿÔ+≤áWCºqA','2025-05-06 16:21:00',0,0,NULL,NULL,'2025-05-05',NULL,'Africa/Abidjan','delon lucien siagbe','siagbe.delon@budget.gouv.ci','DRHMC',NULL),
(13,19,'Sm1szÀK‘\\líü{∂vëß∂dH≠µìπ}õô¥g','„QêAF†keÙ¢9Öµ√£∞˘aÙ˝xN\\]Vºﬂ','2025-05-06 16:30:12',0,0,NULL,NULL,'2025-05-05',NULL,'Africa/Abidjan','Yacouba Diabagate','diabagate@budget.gouv.ci',NULL,NULL),
(14,20,'£s<N•Å¢c‰Û`aX€\n:™<À}++∂0’\\DØì','{Q´ W‹Vmº!˛+èS4ñFeüÈ\'sã`yû#YF','2025-05-07 14:02:26',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `guacamole_user` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_user_attribute`
--

DROP TABLE IF EXISTS `guacamole_user_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_attribute` (
  `user_id` int(11) NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`user_id`,`attribute_name`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `guacamole_user_attribute_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_attribute`
--

LOCK TABLES `guacamole_user_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_user_attribute` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `guacamole_user_attribute` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_user_group`
--

DROP TABLE IF EXISTS `guacamole_user_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_group` (
  `user_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` int(11) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_group_id`),
  UNIQUE KEY `guacamole_user_group_single_entity` (`entity_id`),
  CONSTRAINT `guacamole_user_group_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_group`
--

LOCK TABLES `guacamole_user_group` WRITE;
/*!40000 ALTER TABLE `guacamole_user_group` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `guacamole_user_group` VALUES
(2,5,0),
(4,7,0),
(5,8,0),
(6,9,0);
/*!40000 ALTER TABLE `guacamole_user_group` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_user_group_attribute`
--

DROP TABLE IF EXISTS `guacamole_user_group_attribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_group_attribute` (
  `user_group_id` int(11) NOT NULL,
  `attribute_name` varchar(128) NOT NULL,
  `attribute_value` varchar(4096) NOT NULL,
  PRIMARY KEY (`user_group_id`,`attribute_name`),
  KEY `user_group_id` (`user_group_id`),
  CONSTRAINT `guacamole_user_group_attribute_ibfk_1` FOREIGN KEY (`user_group_id`) REFERENCES `guacamole_user_group` (`user_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_group_attribute`
--

LOCK TABLES `guacamole_user_group_attribute` WRITE;
/*!40000 ALTER TABLE `guacamole_user_group_attribute` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `guacamole_user_group_attribute` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_user_group_member`
--

DROP TABLE IF EXISTS `guacamole_user_group_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_group_member` (
  `user_group_id` int(11) NOT NULL,
  `member_entity_id` int(11) NOT NULL,
  PRIMARY KEY (`user_group_id`,`member_entity_id`),
  KEY `guacamole_user_group_member_entity_id` (`member_entity_id`),
  CONSTRAINT `guacamole_user_group_member_entity_id` FOREIGN KEY (`member_entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_user_group_member_parent_id` FOREIGN KEY (`user_group_id`) REFERENCES `guacamole_user_group` (`user_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_group_member`
--

LOCK TABLES `guacamole_user_group_member` WRITE;
/*!40000 ALTER TABLE `guacamole_user_group_member` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `guacamole_user_group_member` VALUES
(2,2),
(6,10),
(2,11),
(2,12),
(5,14),
(5,15),
(5,16),
(5,17),
(4,18),
(4,20);
/*!40000 ALTER TABLE `guacamole_user_group_member` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_user_group_permission`
--

DROP TABLE IF EXISTS `guacamole_user_group_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_group_permission` (
  `entity_id` int(11) NOT NULL,
  `affected_user_group_id` int(11) NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`affected_user_group_id`,`permission`),
  KEY `guacamole_user_group_permission_affected_user_group` (`affected_user_group_id`),
  CONSTRAINT `guacamole_user_group_permission_affected_user_group` FOREIGN KEY (`affected_user_group_id`) REFERENCES `guacamole_user_group` (`user_group_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_user_group_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_group_permission`
--

LOCK TABLES `guacamole_user_group_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_user_group_permission` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `guacamole_user_group_permission` VALUES
(3,2,'READ'),
(3,2,'UPDATE'),
(3,2,'DELETE'),
(3,2,'ADMINISTER'),
(3,4,'READ'),
(3,4,'UPDATE'),
(3,4,'DELETE'),
(3,4,'ADMINISTER'),
(3,5,'READ'),
(3,5,'UPDATE'),
(3,5,'DELETE'),
(3,5,'ADMINISTER'),
(3,6,'READ'),
(3,6,'UPDATE'),
(3,6,'DELETE'),
(3,6,'ADMINISTER');
/*!40000 ALTER TABLE `guacamole_user_group_permission` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_user_history`
--

DROP TABLE IF EXISTS `guacamole_user_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_history` (
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(128) NOT NULL,
  `remote_host` varchar(256) DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `user_id` (`user_id`),
  KEY `start_date` (`start_date`),
  KEY `end_date` (`end_date`),
  KEY `user_start_date` (`user_id`,`start_date`),
  CONSTRAINT `guacamole_user_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_history`
--

LOCK TABLES `guacamole_user_history` WRITE;
/*!40000 ALTER TABLE `guacamole_user_history` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `guacamole_user_history` VALUES
(1,1,'guacadmin','10.222.221.3','2025-04-30 10:13:00',NULL),
(2,1,'guacadmin','10.222.221.3','2025-04-30 11:12:02','2025-04-30 11:17:28'),
(3,1,'guacadmin','10.222.221.3','2025-04-30 11:25:36','2025-04-30 11:30:48'),
(4,3,'ac.guard','10.222.221.3','2025-04-30 11:31:04','2025-04-30 11:32:57'),
(5,3,'ac.guard','10.222.221.3','2025-04-30 11:34:29',NULL),
(6,2,'kamagate.idrissa','10.222.221.3','2025-04-30 14:58:42',NULL),
(7,1,'guacadmin','10.222.221.3','2025-04-30 15:35:18',NULL),
(8,1,'guacadmin','10.222.221.3','2025-04-30 15:50:39','2025-04-30 15:52:58'),
(9,2,'kamagate.idrissa','10.222.221.3','2025-04-30 15:56:08','2025-04-30 15:57:05'),
(10,1,'guacadmin','10.222.221.3','2025-04-30 15:57:10','2025-04-30 16:02:38'),
(11,2,'kamagate.idrissa','10.222.221.3','2025-04-30 15:57:20','2025-04-30 16:03:48'),
(12,1,'guacadmin','10.222.221.3','2025-04-30 16:02:44',NULL),
(13,2,'kamagate.idrissa','10.222.221.3','2025-04-30 16:04:01',NULL),
(14,2,'kamagate.idrissa','10.222.221.3','2025-04-30 16:04:26',NULL),
(15,2,'kamagate.idrissa','10.222.221.3','2025-04-30 16:07:07',NULL),
(16,1,'guacadmin','10.222.221.3','2025-04-30 16:07:29',NULL),
(17,1,'guacadmin','10.222.221.3','2025-04-30 16:13:42','2025-04-30 16:21:50'),
(18,1,'guacadmin','10.222.221.3','2025-04-30 16:21:56','2025-04-30 16:22:00'),
(19,1,'guacadmin','10.222.221.3','2025-04-30 16:22:04','2025-04-30 16:38:17'),
(20,2,'kamagate.idrissa','10.222.221.3','2025-04-30 16:25:58',NULL),
(21,1,'guacadmin','10.222.221.3','2025-04-30 16:38:24',NULL),
(22,2,'kamagate.idrissa','10.222.221.3','2025-04-30 16:39:26',NULL),
(23,1,'guacadmin','10.222.221.3','2025-04-30 16:40:27',NULL),
(24,1,'guacadmin','10.222.221.3','2025-04-30 16:46:28','2025-04-30 17:53:15'),
(25,2,'kamagate.idrissa','10.222.221.3','2025-04-30 16:47:55','2025-04-30 16:54:20'),
(26,2,'kamagate.idrissa','10.222.221.3','2025-04-30 16:54:36','2025-04-30 16:59:14'),
(27,2,'kamagate.idrissa','127.0.0.1','2025-04-30 17:56:33','2025-04-30 17:56:47'),
(28,3,'ac.guard','127.0.0.1','2025-04-30 18:06:28','2025-04-30 18:06:31'),
(29,2,'kamagate.idrissa','127.0.0.1','2025-04-30 18:39:24','2025-04-30 18:41:51'),
(30,1,'guacadmin','10.222.221.3','2025-05-02 09:10:34','2025-05-02 09:31:13'),
(31,3,'ac.guard','127.0.0.1','2025-05-02 10:05:11','2025-05-02 10:05:15'),
(32,3,'ac.guard','127.0.0.1','2025-05-02 10:05:29','2025-05-02 10:06:33'),
(33,2,'kamagate.idrissa','127.0.0.1','2025-05-02 10:14:33','2025-05-02 10:33:11'),
(34,1,'guacadmin','127.0.0.1','2025-05-06 09:35:16','2025-05-06 09:36:16'),
(35,3,'ac.guard','127.0.0.1','2025-05-06 09:36:44','2025-05-06 12:37:15'),
(36,1,'guacadmin','127.0.0.1','2025-05-06 14:30:32','2025-05-06 14:31:44'),
(37,3,'ac.guard','127.0.0.1','2025-05-06 14:31:56','2025-05-06 17:37:15'),
(38,2,'kamagate.idrissa','127.0.0.1','2025-05-07 13:49:30','2025-05-07 14:05:07'),
(39,2,'kamagate.idrissa','127.0.0.1','2025-05-07 14:05:11','2025-05-07 14:10:00'),
(40,10,'diallo.sisse','127.0.0.1','2025-05-07 16:02:19','2025-05-07 16:04:13'),
(41,3,'ac.guard','127.0.0.1','2025-05-07 16:02:56','2025-05-07 16:09:28'),
(42,2,'kamagate.idrissa','127.0.0.1','2025-05-07 16:03:10','2025-05-07 16:03:15'),
(43,2,'kamagate.idrissa','127.0.0.1','2025-05-07 16:03:47','2025-05-07 16:32:55'),
(44,10,'diallo.sisse','127.0.0.1','2025-05-07 16:04:50','2025-05-07 16:07:19'),
(45,1,'guacadmin','127.0.0.1','2025-05-08 10:01:45','2025-05-08 11:02:15'),
(46,2,'kamagate.idrissa','127.0.0.1','2025-05-09 10:01:22','2025-05-09 10:02:45'),
(47,1,'guacadmin','127.0.0.1','2025-05-09 10:08:18','2025-05-09 10:08:56'),
(48,3,'ac.guard','127.0.0.1','2025-05-09 10:09:48','2025-05-09 12:39:58'),
(49,1,'guacadmin','127.0.0.1','2025-05-09 16:29:37','2025-05-09 17:29:58'),
(50,2,'kamagate.idrissa','127.0.0.1','2025-05-12 08:58:22','2025-05-12 08:58:48'),
(51,2,'kamagate.idrissa','127.0.0.1','2025-05-12 10:08:41','2025-05-12 10:12:01'),
(52,11,'marc','127.0.0.1','2025-05-12 10:12:54','2025-05-12 10:13:48'),
(53,11,'marc','127.0.0.1','2025-05-12 10:13:59','2025-05-12 10:14:54');
/*!40000 ALTER TABLE `guacamole_user_history` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_user_password_history`
--

DROP TABLE IF EXISTS `guacamole_user_password_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_password_history` (
  `password_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `password_hash` binary(32) NOT NULL,
  `password_salt` binary(32) DEFAULT NULL,
  `password_date` datetime NOT NULL,
  PRIMARY KEY (`password_history_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `guacamole_user_password_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_password_history`
--

LOCK TABLES `guacamole_user_password_history` WRITE;
/*!40000 ALTER TABLE `guacamole_user_password_history` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `guacamole_user_password_history` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Table structure for table `guacamole_user_permission`
--

DROP TABLE IF EXISTS `guacamole_user_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guacamole_user_permission` (
  `entity_id` int(11) NOT NULL,
  `affected_user_id` int(11) NOT NULL,
  `permission` enum('READ','UPDATE','DELETE','ADMINISTER') NOT NULL,
  PRIMARY KEY (`entity_id`,`affected_user_id`,`permission`),
  KEY `guacamole_user_permission_ibfk_1` (`affected_user_id`),
  CONSTRAINT `guacamole_user_permission_entity` FOREIGN KEY (`entity_id`) REFERENCES `guacamole_entity` (`entity_id`) ON DELETE CASCADE,
  CONSTRAINT `guacamole_user_permission_ibfk_1` FOREIGN KEY (`affected_user_id`) REFERENCES `guacamole_user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guacamole_user_permission`
--

LOCK TABLES `guacamole_user_permission` WRITE;
/*!40000 ALTER TABLE `guacamole_user_permission` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `guacamole_user_permission` VALUES
(1,1,'READ'),
(1,1,'UPDATE'),
(1,1,'ADMINISTER'),
(1,2,'READ'),
(1,2,'UPDATE'),
(1,2,'DELETE'),
(1,2,'ADMINISTER'),
(2,2,'READ'),
(1,3,'READ'),
(1,3,'UPDATE'),
(1,3,'DELETE'),
(1,3,'ADMINISTER'),
(3,3,'READ'),
(3,3,'UPDATE'),
(3,4,'READ'),
(3,4,'UPDATE'),
(3,4,'DELETE'),
(3,4,'ADMINISTER'),
(10,4,'READ'),
(10,4,'UPDATE'),
(3,5,'READ'),
(3,5,'UPDATE'),
(3,5,'DELETE'),
(3,5,'ADMINISTER'),
(11,5,'READ'),
(11,5,'UPDATE'),
(3,6,'READ'),
(3,6,'UPDATE'),
(3,6,'DELETE'),
(3,6,'ADMINISTER'),
(12,6,'READ'),
(12,6,'UPDATE'),
(3,7,'READ'),
(3,7,'UPDATE'),
(3,7,'DELETE'),
(3,7,'ADMINISTER'),
(13,7,'READ'),
(3,8,'READ'),
(3,8,'UPDATE'),
(3,8,'DELETE'),
(3,8,'ADMINISTER'),
(14,8,'READ'),
(14,8,'UPDATE'),
(3,9,'READ'),
(3,9,'UPDATE'),
(3,9,'DELETE'),
(3,9,'ADMINISTER'),
(15,9,'READ'),
(3,10,'READ'),
(3,10,'UPDATE'),
(3,10,'DELETE'),
(3,10,'ADMINISTER'),
(16,10,'READ'),
(3,11,'READ'),
(3,11,'UPDATE'),
(3,11,'DELETE'),
(3,11,'ADMINISTER'),
(17,11,'READ'),
(3,12,'READ'),
(3,12,'UPDATE'),
(3,12,'DELETE'),
(3,12,'ADMINISTER'),
(18,12,'READ'),
(3,13,'READ'),
(3,13,'UPDATE'),
(3,13,'DELETE'),
(3,13,'ADMINISTER'),
(19,13,'READ'),
(2,14,'READ'),
(2,14,'UPDATE'),
(2,14,'DELETE'),
(2,14,'ADMINISTER'),
(20,14,'READ');
/*!40000 ALTER TABLE `guacamole_user_permission` ENABLE KEYS */;
UNLOCK TABLES;
commit;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2025-05-30 15:55:14
