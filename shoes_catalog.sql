-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: shoes_catalog
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `products`
--
CREATE DATABASE IF NOT EXISTS shoes_catalog;
USE shoes_catalog;
DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `colors` text,
  `category` varchar(20) DEFAULT 'unisex',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Saucony Endorphin Pro 4 Women\'s Running Shoes - AW25','Push it to the next level in the Endorphin Pro 4, with PWRRUN PB and PWRRUN HG for propulsive movement and snappy Carbon plate for responsive speed.',14500.00,'https://cdn11.bigcommerce.com/s-21x65e8kfn/images/stencil/original/products/79692/428169/SAU5255_1000_1__32776.1750083679.jpg','2026-03-29 05:51:22','[{\"hex\":\"#ff0000\",\"name\":\"Red\",\"image_url\":\"https://example.com/red.jpg\"}]','women'),(3,'Asics Novablast 5 Women\'s Running Shoes - SS26','The Novablast line gets a major update with a fast and fun model suitable for every type of runner. The fifth generation of these iconic shoes delivers a super soft, comfortable ride thanks to ASICS\' most energetic midsole foam, FF Blast Max cushioning.',13500.00,'https://cdn11.bigcommerce.com/s-21x65e8kfn/images/stencil/original/products/84413/464278/ASI16212_1000_1__23459.1764674402.jpg','2026-03-30 19:06:16','[{\"hex\":\"#ffffff\",\"name\":\"\",\"image_url\":\"https://cdn11.bigcommerce.com/s-21x65e8kfn/images/stencil/original/products/84361/463749/ASI16214_1000_1__75777.1764339651.jpg\"},{\"hex\":\"#3758fb\",\"name\":\"\",\"image_url\":\"https://cdn11.bigcommerce.com/s-21x65e8kfn/images/stencil/original/products/84416/464268/ASI16211_1000_1__03245.1764670826.jpg\"},{\"hex\":\"#dd466c\",\"name\":\"\",\"image_url\":\"https://cdn11.bigcommerce.com/s-21x65e8kfn/images/stencil/original/products/87709/487590/ASI16517_1000_1__67451.1773419120.jpg\"}]','women'),(4,'Hoka Cielo X1 2.0 Running Shoes','A tip-of-the-spear product tuned for higher tempo pickups, the Cielo X1 2.0 is a must for speed seekers. Engineered with an aggressive forefoot rocker and ultra-responsive dual-density PEBA midsole with snappy carbon fibre plate, this pace-pushing road racer has been finished with a light, breathable upper.',13450.00,'https://cdn11.bigcommerce.com/s-21x65e8kfn/images/stencil/original/products/76181/401837/HOK2921_1000_1__05168.1739467208.jpg','2026-03-31 08:27:12','[{\"hex\":\"#ffffff\",\"name\":\"\",\"image_url\":\"https://cdn11.bigcommerce.com/s-21x65e8kfn/images/stencil/original/products/77252/409429/HOK2933_1000_1__30084.1741774794.jpg\"},{\"hex\":\"#67a0cb\",\"name\":\"\",\"image_url\":\"https://cdn11.bigcommerce.com/s-21x65e8kfn/images/stencil/original/products/80138/431753/HOK3078_1000_1__40186.1751354458.jpg\"},{\"hex\":\"#000000\",\"name\":\"\",\"image_url\":\"https://cdn11.bigcommerce.com/s-21x65e8kfn/images/stencil/original/products/84206/462356/HOK3453_1000_1__87480.1764156001.png\"}]','men'),(5,'Asics Gel-Excite 11 Men\'s Running Shoes - SS26','The Gel-Excite 11 features a comfortable and versatile design. It\'s formed to help create more underfoot comfort for your run and fitness routine. Layered with Amplifoam Plus technology in the midsole, this shoe also includes a higher stack height to help provide a softer and more comfortable cushioning experience.',6890.00,'https://cdn11.bigcommerce.com/s-21x65e8kfn/images/stencil/original/products/86650/480230/ASI16263_1000_1__93171.1771514543.jpg','2026-03-31 08:29:01','[{\"hex\":\"#0f0000\",\"name\":\"\",\"image_url\":\"https://cdn11.bigcommerce.com/s-21x65e8kfn/images/stencil/original/products/80347/433474/ASI15957_1000_1__79250.1751646060.jpg\"}]','men'),(6,'Asics Jolt 3 GS Junior Running Shoes','For young runners who crave comfort and style, the ASICS Jolt 3 GS Junior Running Shoes is the perfect shoe for beginners to intermediates.',5780.00,'https://cdn11.bigcommerce.com/s-21x65e8kfn/images/stencil/original/products/47969/216907/ASI13166_1000_1__54634.1688510279.jpg','2026-03-31 08:31:15','[{\"hex\":\"#e18f41\",\"name\":\"\",\"image_url\":\"https://cdn11.bigcommerce.com/s-21x65e8kfn/images/stencil/original/products/47971/216893/ASI13164_1000_1__70513.1688510267.jpg\"}]','kids'),(7,'Asics Venture 9 GS Junior Trail Running Shoes - AW25','The Pre-Venture 9 GS is designed to provide good cushioning for active feet. The outsole features an advanced traction pattern that\'s versatile for various surfaces.',7890.00,'https://cdn11.bigcommerce.com/s-21x65e8kfn/images/stencil/original/products/81409/442517/ASI15948_1000_1__97634.1754911316.jpg','2026-03-31 08:33:05','[]','kids'),(8,'Nike Zoom Mamba 5 Bowerman Track Club','Designed specifically for the steeplechase, the Nike Zoom Mamba 5 Bowerman Track Club delivers solid traction and a secure, consistent fit in wet conditions. The upper helps let water out, leaving your feet dry and light to maintain your speed.',31000.00,'https://static.nike.com/a/images/t_web_pdp_535_v2/f_auto/dpr2m4y5kyeqjnahwmlo/NIKE+ZOOM+MAMBA+V+BTC.png','2026-03-31 08:37:30','[]','unisex');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-31 11:40:33
