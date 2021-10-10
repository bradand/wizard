-- MySQL dump 10.13  Distrib 5.7.35, for Linux (x86_64)
--
-- Host: localhost    Database: sample
-- ------------------------------------------------------
-- Server version	5.7.35-0ubuntu0.18.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `sample`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sample` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `sample`;

--
-- Table structure for table `sample_alerts`
--

DROP TABLE IF EXISTS `sample_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sample_alerts` (
  `Type` tinytext NOT NULL,
  `Identifier` tinytext NOT NULL,
  `Triggered` int(11) NOT NULL,
  `Active` int(11) NOT NULL,
  `Users_To_Email` tinytext NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sample_alerts`
--

LOCK TABLES `sample_alerts` WRITE;
/*!40000 ALTER TABLE `sample_alerts` DISABLE KEYS */;
INSERT INTO `sample_alerts` VALUES ('Thermostat','000',0,0,'sample_person',1),('Thermostat','0001',0,0,'sample_person',2),('Thermostat','000_C_wet',0,0,'sample_person',3),('Thermostat','000_C_dry',0,0,'sample_person',4);
/*!40000 ALTER TABLE `sample_alerts` ENABLE KEYS */;
UNLOCK TABLES;