-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: eoy_project
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id_client` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `telephone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id_client`),
  UNIQUE KEY `telephone` (`telephone`),
  KEY `idx_nom_client` (`nom`),
  KEY `idx_tel` (`telephone`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Rabekoto','Andry','0325123456'),(2,'Rakoto','Hery','0346728391'),(3,'Randrianarisoa','Miora','0339182736'),(4,'Rasoanaivo','Lova','0384591027'),(5,'Razafindrakoto','Tiana','0345029348'),(6,'Rajaonarivelo','Sarobidy','0326184759'),(7,'Andrianina','Fanilo','0339845632'),(8,'Ravelo','Haja','0386721984'),(9,'Randriamihaja','Soa','0347921865'),(10,'Rasolo','Nirina','0336029374'),(11,'Rakotomanga','Toky','0347281903'),(12,'Ravelomanana','Aina','0325847392'),(13,'Rafaralahy','Fitiavana','0348625463'),(14,'Rakotoarisoa','Jean','0389456125'),(15,'Radama','Franco','0328756845');
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commandes`
--

DROP TABLE IF EXISTS `commandes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commandes` (
  `id_commande` int NOT NULL AUTO_INCREMENT,
  `date_commande` datetime DEFAULT CURRENT_TIMESTAMP,
  `total` decimal(10,2) DEFAULT '0.00',
  `id_client` int NOT NULL,
  PRIMARY KEY (`id_commande`),
  KEY `id_client` (`id_client`),
  CONSTRAINT `commandes_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commandes`
--

LOCK TABLES `commandes` WRITE;
/*!40000 ALTER TABLE `commandes` DISABLE KEYS */;
INSERT INTO `commandes` VALUES (31,'2025-10-30 23:57:18',13.50,1),(32,'2025-10-30 23:57:31',6.50,2),(33,'2025-10-30 23:58:07',31.00,3),(34,'2025-10-30 23:58:46',71.00,4),(35,'2025-10-30 23:59:27',40.00,5),(36,'2025-10-31 00:00:50',39.10,6),(37,'2025-10-31 00:03:28',67.20,12),(38,'2025-10-31 00:15:51',72.00,10),(39,'2025-10-31 00:17:08',55.00,6),(42,'2025-10-31 07:07:37',26.00,6),(43,'2025-10-31 08:28:39',17.40,4),(44,'2025-10-31 08:40:45',13.50,12),(45,'2025-10-31 08:50:55',18.00,9),(47,'2025-10-31 05:56:09',40.00,7),(48,'2025-11-01 06:29:24',55.50,3),(50,'2025-11-01 14:20:03',40.50,3),(51,'2025-11-01 14:22:21',43.50,1),(52,'2025-11-01 14:24:08',56.00,5),(56,'2025-11-02 14:44:47',37.50,10),(57,'2025-11-02 14:52:10',72.80,4),(59,'2025-11-02 14:58:28',38.70,4),(61,'2025-11-03 11:47:04',12.50,10),(62,'2025-11-03 15:28:27',13.50,9),(63,'2025-11-03 17:26:27',28.50,15),(64,'2025-11-03 17:27:27',59.60,10),(65,'2025-11-04 05:17:35',37.90,13);
/*!40000 ALTER TABLE `commandes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detailscommande`
--

DROP TABLE IF EXISTS `detailscommande`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detailscommande` (
  `id_commande` int NOT NULL,
  `id_plat` int NOT NULL,
  `quantite` int NOT NULL DEFAULT '1',
  `prix_unitaire` double NOT NULL,
  KEY `id_commande` (`id_commande`),
  KEY `id_plat` (`id_plat`),
  CONSTRAINT `detailscommande_ibfk_1` FOREIGN KEY (`id_commande`) REFERENCES `commandes` (`id_commande`) ON DELETE CASCADE,
  CONSTRAINT `detailscommande_ibfk_2` FOREIGN KEY (`id_plat`) REFERENCES `plats` (`id_plat`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detailscommande`
--

LOCK TABLES `detailscommande` WRITE;
/*!40000 ALTER TABLE `detailscommande` DISABLE KEYS */;
INSERT INTO `detailscommande` VALUES (31,1,1,7.5),(31,2,1,6),(32,17,1,6.5),(33,11,2,11.5),(33,25,2,4),(34,11,4,11.5),(34,21,2,3.5),(34,26,4,4.5),(35,35,2,4),(35,41,1,11),(35,24,3,4),(36,37,2,4.5),(36,22,2,3.5),(36,38,3,4.2),(36,44,1,10.5),(37,31,3,5),(37,9,2,14.5),(37,16,4,5.8),(38,40,5,9.5),(38,23,7,3.5),(39,27,7,5),(39,35,5,4),(42,17,4,6.5),(43,16,3,5.8),(44,30,3,4.5),(47,31,5,5),(47,27,3,5),(48,2,2,6),(48,7,1,12.5),(48,13,1,11),(48,31,4,5),(50,1,4,7.5),(50,21,3,3.5),(51,9,3,14.5),(52,5,3,9),(52,9,2,14.5),(56,5,3,9),(56,21,3,3.5),(57,7,4,12.5),(57,19,4,5.7),(59,12,3,12.9),(62,6,3,4.5),(63,15,3,6),(63,21,3,3.5),(64,10,2,13.8),(64,22,2,3.5),(64,18,5,5),(65,4,2,8.2),(65,15,2,6),(65,27,1,5),(65,26,1,4.5);
/*!40000 ALTER TABLE `detailscommande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detailsstock`
--

DROP TABLE IF EXISTS `detailsstock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detailsstock` (
  `id_produit` int NOT NULL,
  `id_plat` int NOT NULL,
  `quantite_prise` double NOT NULL,
  PRIMARY KEY (`id_produit`,`id_plat`),
  KEY `id_plat` (`id_plat`),
  CONSTRAINT `detailsstock_ibfk_1` FOREIGN KEY (`id_produit`) REFERENCES `stock` (`id_produit`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailsstock_ibfk_2` FOREIGN KEY (`id_plat`) REFERENCES `plats` (`id_plat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detailsstock`
--

LOCK TABLES `detailsstock` WRITE;
/*!40000 ALTER TABLE `detailsstock` DISABLE KEYS */;
INSERT INTO `detailsstock` VALUES (1,1,0.3),(2,3,0.2),(3,1,0.1),(3,2,0.1),(3,3,0.2),(3,5,0.1),(4,2,0.3),(5,3,0.05),(5,4,0.05),(5,40,0.03),(6,5,0.3),(7,6,0.15),(8,4,0.25),(8,7,0.2),(8,12,0.15),(8,14,0.3),(9,1,0.2),(9,8,0.25),(10,8,0.3),(10,11,0.2),(10,13,0.3),(11,9,0.3),(12,10,0.25),(13,6,0.1),(13,11,0.25),(14,7,0.25),(14,12,0.2),(16,1,0.1),(16,13,0.1),(16,15,0.05),(16,16,0.05),(16,17,0.1),(16,19,0.1),(16,31,0.05),(16,33,0.05),(16,43,0.05),(17,8,0.1),(17,11,0.1),(17,15,0.15),(17,19,0.1),(17,37,0.1),(17,39,0.05),(18,4,0.05),(18,8,0.05),(18,10,0.05),(18,14,0.05),(18,16,0.1),(18,18,0.03),(19,17,0.2),(19,19,0.15),(20,18,0.3),(21,15,0.05),(21,16,0.05),(21,17,0.05),(21,18,0.05),(22,20,1),(23,21,1),(24,22,1),(25,23,1),(26,24,1),(27,25,1),(28,26,1),(28,27,1),(29,28,1),(31,35,0.25),(31,37,0.25),(31,39,0.25),(32,1,0.1),(32,2,0.1),(32,5,0.1),(32,12,0.1),(32,33,0.15),(32,37,0.1),(32,42,0.15),(32,43,0.1),(33,2,0.1),(33,16,0.05),(33,17,0.05),(33,37,0.05),(33,39,0.05),(35,38,0.25),(36,30,0.15),(37,31,0.15),(40,13,0.1),(40,30,0.1),(40,34,0.15),(40,44,0.15),(41,6,0.1),(41,40,0.2),(41,41,0.2),(41,42,0.2),(41,43,0.2),(41,44,0.2),(42,7,0.15),(42,12,0.1),(42,40,0.1),(42,41,0.1),(42,42,0.05),(42,43,0.1),(42,44,0.1),(43,40,0.1),(43,41,0.1),(43,42,0.1),(43,44,0.1),(44,41,0.08),(45,41,0.1),(45,43,0.1),(46,3,0.05),(46,4,0.05),(46,6,0.05),(46,7,0.05),(46,9,0.05),(46,10,0.05),(46,11,0.05),(46,13,0.05),(46,14,0.05),(46,30,0.05),(46,31,0.05),(46,33,0.05),(46,34,0.05),(46,35,0.05),(46,38,0.03),(47,9,0.02),(48,31,0.1),(48,33,0.1),(48,34,0.05),(49,35,0.01),(49,38,0.01),(49,39,0.01);
/*!40000 ALTER TABLE `detailsstock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facture`
--

DROP TABLE IF EXISTS `facture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `facture` (
  `id_facture` int NOT NULL AUTO_INCREMENT,
  `id_commande` int NOT NULL,
  `id_client` int NOT NULL,
  `date_facture` datetime DEFAULT CURRENT_TIMESTAMP,
  `net_a_payer` double NOT NULL,
  PRIMARY KEY (`id_facture`),
  KEY `id_commande` (`id_commande`),
  KEY `id_client` (`id_client`),
  CONSTRAINT `facture_ibfk_1` FOREIGN KEY (`id_commande`) REFERENCES `commandes` (`id_commande`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `facture_ibfk_2` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facture`
--

LOCK TABLES `facture` WRITE;
/*!40000 ALTER TABLE `facture` DISABLE KEYS */;
INSERT INTO `facture` VALUES (8,31,1,'2025-10-30 20:57:19',13.5),(9,32,2,'2025-10-30 20:57:32',6.5),(10,33,3,'2025-10-30 20:58:08',31),(11,34,4,'2025-10-30 20:58:47',71),(12,35,5,'2025-10-30 20:59:28',40),(13,36,6,'2025-10-30 21:00:51',39.1),(14,37,12,'2025-10-30 21:03:29',67.2),(15,38,10,'2025-10-30 21:15:51',72),(16,39,6,'2025-10-30 21:17:09',55),(19,42,6,'2025-10-31 04:07:37',26),(20,43,4,'2025-10-31 05:28:40',17.4),(21,44,12,'2025-10-31 05:40:45',13.5),(22,45,9,'2025-10-31 05:50:56',18),(24,47,7,'2025-10-31 05:56:09',40),(25,48,3,'2025-11-01 06:29:24',55.5),(27,50,3,'2025-11-01 14:20:03',40.5),(28,51,1,'2025-11-01 14:22:21',43.5),(29,52,5,'2025-11-01 14:24:08',56),(33,56,10,'2025-11-02 14:44:47',37.5),(34,57,4,'2025-11-02 14:52:10',72.8),(36,59,4,'2025-11-02 14:58:28',38.7),(38,61,10,'2025-11-03 11:47:04',12.5),(39,62,9,'2025-11-03 15:28:27',13.5),(40,63,15,'2025-11-03 17:26:27',28.5),(41,64,10,'2025-11-03 17:27:28',59.6),(42,65,13,'2025-11-04 05:17:36',37.9);
/*!40000 ALTER TABLE `facture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plats`
--

DROP TABLE IF EXISTS `plats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plats` (
  `id_plat` int NOT NULL AUTO_INCREMENT,
  `nom_plat` varchar(50) NOT NULL,
  `prix` decimal(8,2) NOT NULL,
  `categorie` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_plat`),
  KEY `idx_nom_plat` (`nom_plat`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plats`
--

LOCK TABLES `plats` WRITE;
/*!40000 ALTER TABLE `plats` DISABLE KEYS */;
INSERT INTO `plats` VALUES (1,'Salade César',7.50,'Entrée'),(2,'Soupe à l’oignon',6.00,'Entrée'),(3,'Bruschetta tomate-basilic',5.50,'Entrée'),(4,'Carpaccio de bœuf',8.20,'Entrée'),(5,'Assiette de charcuterie',9.00,'Entrée'),(6,'Samoussa au thon',4.50,'Entrée'),(7,'Spaghetti bolognaise',12.50,'Plat principal'),(8,'Poulet coco et riz',13.00,'Plat principal'),(9,'Zébu grillé sauce poivre',14.50,'Plat principal'),(10,'Poisson grillé au citron',13.80,'Plat principal'),(11,'Curry de légumes',11.50,'Plat principal'),(12,'Lasagnes maison',12.90,'Plat principal'),(13,'Riz cantonais',11.00,'Plat principal'),(14,'Brochettes de bœuf',13.50,'Plat principal'),(15,'Crème brûlée',6.00,'Dessert'),(16,'Tarte au citron',5.80,'Dessert'),(17,'Fondant au chocolat',6.50,'Dessert'),(18,'Salade de fruits frais',5.00,'Dessert'),(19,'Mousse au chocolat',5.70,'Dessert'),(20,'Eau minérale',2.00,'Boisson'),(21,'Coca-Cola',3.50,'Boisson'),(22,'Fanta orange',3.50,'Boisson'),(23,'Sprite',3.50,'Boisson'),(24,'Jus d’orange frais',4.00,'Boisson'),(25,'Jus de mangue',4.00,'Boisson'),(26,'Bière THB',4.50,'Boisson'),(27,'Bière Gold',5.00,'Boisson'),(28,'Café espresso',2.50,'Boisson'),(30,'Nems au poulet',4.50,'Snack'),(31,'Beignets de crevettes',5.00,'Snack'),(33,'Croquettes de fromage',4.80,'Snack'),(34,'Samoussas légumes',4.20,'Snack'),(35,'Frites maison',4.00,'Collation'),(37,'Gratin dauphinois',4.50,'Collation'),(38,'Légumes sautés',4.20,'Collation'),(39,'Purée de pommes de terre',3.80,'Collation'),(40,'Pizza Margherita',9.50,'Pizza'),(41,'Pizza Reine',11.00,'Pizza'),(42,'Pizza 4 Fromages',12.00,'Pizza'),(43,'Pizza Calzone',11.50,'Pizza'),(44,'Pizza Végétarienne',10.50,'Pizza');
/*!40000 ALTER TABLE `plats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `id_produit` int NOT NULL AUTO_INCREMENT,
  `nom_produit` varchar(50) NOT NULL,
  `quantite` double DEFAULT NULL,
  PRIMARY KEY (`id_produit`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,'salade',27.9),(2,'tomate',49.2),(3,'pain',37.6),(4,'oignon',34.1),(5,'basilic',19.55),(6,'charcuterie',23.200000000000003),(7,'thon',14.55),(8,'boeuf',37.599999999999994),(9,'poulet',43.599999999999994),(10,'riz',76.69999999999999),(11,'zébu',31.4),(12,'poisson',28.5),(13,'légumes',58.2),(14,'pâtes',67.55000000000001),(15,'lasagnes',20),(16,'oeuf',36.199999999999996),(17,'crème',22.650000000000006),(18,'citron',18.75),(19,'chocolat',27.4),(20,'fruits',38.5),(21,'sucre',48.8),(22,'eau',100),(23,'cola',69),(24,'fanta',56),(25,'sprite',51),(26,'jus d’orange',47),(27,'jus de mangue',43),(28,'bière',51),(29,'café',40),(31,'pomme de terre',57.75),(32,'fromage',32.45),(33,'beurre',23.9),(34,'gratin',20),(35,'légumes sautés',39.25),(36,'poulet haché',24.1),(37,'crevette',23.2),(38,'pain burger',29.4),(39,'fromage râpé',30),(40,'légumes variés',39.00000000000001),(41,'pâte à pizza',48.3),(42,'sauce tomate',37.95),(43,'mozzarella',34.3),(44,'champignon',24.92),(45,'jambon',19.9),(46,'huile',36.649999999999984),(47,'poivre',14.760000000000002),(48,'farine',38.800000000000004),(49,'sel',19.869999999999997);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-04 10:01:34
