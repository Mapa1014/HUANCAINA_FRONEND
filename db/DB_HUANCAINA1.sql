/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.5-10.4.22-MariaDB : Database - db_huancaina
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_huancaina` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `db_huancaina`;

/*Table structure for table `detalle_ordenes` */

DROP TABLE IF EXISTS `detalle_ordenes`;

CREATE TABLE `detalle_ordenes` (
  `ordenes_id_orden` int(11) NOT NULL,
  `productos_id_producto` int(11) NOT NULL,
  `cantidad_producto` decimal(10,2) NOT NULL,
  `precio_total` decimal(10,2) NOT NULL,
  KEY `fk_detalle_ordenes_ordenes1_idx` (`ordenes_id_orden`),
  KEY `fk_detalle_ordenes_productos1_idx` (`productos_id_producto`),
  CONSTRAINT `fk_detalle_ordenes_ordenes1` FOREIGN KEY (`ordenes_id_orden`) REFERENCES `ordenes` (`id_orden`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_detalle_ordenes_productos1` FOREIGN KEY (`productos_id_producto`) REFERENCES `productos` (`id_producto`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `detalle_ordenes` */

/*Table structure for table `inventarios` */

DROP TABLE IF EXISTS `inventarios`;

CREATE TABLE `inventarios` (
  `id_inventario` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(100) NOT NULL,
  `cantidad_disponible` decimal(10,2) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  `fecha_movimiento` datetime NOT NULL,
  `usuarios_id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_inventario`),
  KEY `fk_inventarios_usuarios1_idx` (`usuarios_id_usuario`),
  CONSTRAINT `fk_inventarios_usuarios1` FOREIGN KEY (`usuarios_id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `inventarios` */

insert  into `inventarios`(`id_inventario`,`categoria`,`cantidad_disponible`,`fecha_creacion`,`fecha_movimiento`,`usuarios_id_usuario`) values (1,'Carnes',100.00,'2025-03-02 12:00:00','2025-03-02 12:00:00',2),(2,'Lácteos',50.00,'2025-03-02 12:00:00','2025-03-02 12:00:00',1),(3,'Pescados y Mariscos',75.00,'2025-03-02 12:00:00','2025-03-02 12:00:00',3),(4,'Bebidas',200.00,'2025-03-02 12:00:00','2025-03-02 12:00:00',4),(5,'Verduras',120.00,'2025-03-02 12:00:00','2025-03-02 12:00:00',5);

/*Table structure for table `menu` */

DROP TABLE IF EXISTS `menu`;

CREATE TABLE `menu` (
  `id_menu` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_menu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `menu` */

/*Table structure for table `ordenes` */

DROP TABLE IF EXISTS `ordenes`;

CREATE TABLE `ordenes` (
  `id_orden` int(11) NOT NULL AUTO_INCREMENT,
  `n_mesa` int(11) NOT NULL,
  `fecha_orden` datetime NOT NULL,
  `estado` enum('PENDIENTE','EN PREPARACION','LISTO PARA SERVIR','ENTREGADO','CANCELADO') NOT NULL DEFAULT 'PENDIENTE',
  `observaciones` varchar(100) DEFAULT NULL,
  `usuarios_id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_orden`),
  KEY `fk_Ordenes_usuarios1_idx` (`usuarios_id_usuario`),
  CONSTRAINT `fk_Ordenes_usuarios1` FOREIGN KEY (`usuarios_id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;

/*Data for the table `ordenes` */

insert  into `ordenes`(`id_orden`,`n_mesa`,`fecha_orden`,`estado`,`observaciones`,`usuarios_id_usuario`) values (1,5,'2025-03-02 12:30:00','PENDIENTE','Sin ají en el ceviche',5),(2,8,'2025-03-02 12:45:00','EN PREPARACION','Agregar más limón',6),(3,2,'2025-03-02 13:00:00','LISTO PARA SERVIR','Platos separados',7),(4,10,'2025-03-02 13:15:00','ENTREGADO','Sin cebolla en el lomo saltado',8),(5,6,'2025-03-02 13:30:00','CANCELADO','Cancelado por el cliente',5),(6,3,'2025-03-02 13:45:00','PENDIENTE','Con doble ración de arroz',6),(7,1,'2025-03-02 14:00:00','EN PREPARACION','Sin azúcar en la chicha morada',7),(8,7,'2025-03-02 14:15:00','LISTO PARA SERVIR','Agregar más hielo en la bebida',8),(9,4,'2025-03-02 14:30:00','ENTREGADO','Sin cilantro en la causa',5),(10,9,'2025-03-02 14:45:00','CANCELADO','Orden cancelada antes de preparar',6);

/*Table structure for table `productos` */

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_producto` varchar(100) NOT NULL,
  `unidad_medida` varchar(45) NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `cantidad_producto` decimal(10,2) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `fecha_actualizacion` datetime NOT NULL,
  `estado` enum('DISPONIBLE','NO DISPONIBLE') NOT NULL DEFAULT 'DISPONIBLE',
  `descripcion` varchar(100) DEFAULT NULL,
  `inventarios_id_inventario` int(11) DEFAULT NULL,
  `inventarios_usuarios_id_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_producto`),
  KEY `fk_productos_inventarios1_idx` (`inventarios_id_inventario`,`inventarios_usuarios_id_usuario`),
  CONSTRAINT `fk_productos_inventarios1` FOREIGN KEY (`inventarios_id_inventario`) REFERENCES `inventarios` (`id_inventario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4;

/*Data for the table `productos` */

insert  into `productos`(`id_producto`,`nombre_producto`,`unidad_medida`,`categoria`,`cantidad_producto`,`precio_unitario`,`fecha_actualizacion`,`estado`,`descripcion`,`inventarios_id_inventario`,`inventarios_usuarios_id_usuario`) values (1,'Lomo de Res','kg','Carnes',15.00,45000.00,'2025-03-02 16:15:24','DISPONIBLE','Corte premium de lomo de res.',1,2),(2,'Pechuga de Pollo','kg','Carnes',20.00,30000.00,'2025-03-02 16:15:24','DISPONIBLE','Pechuga de pollo sin piel y sin hueso.',1,3),(3,'Costillas de Cerdo','kg','Carnes',12.00,38000.00,'2025-03-02 16:15:24','DISPONIBLE','Costillas tiernas de cerdo para asado.',1,4),(4,'Chicharron de pescado','kg','Carnes',25.00,12000.00,'2025-03-02 16:15:24','DISPONIBLE','Chorizo artesanal ahumado.',1,2),(5,'Queso Doble Crema','kg','Lácteos',10.00,25000.00,'2025-03-02 16:15:24','DISPONIBLE','Queso suave y cremoso.',2,3),(6,'Leche Entera','lts','Lácteos',50.00,6000.00,'2025-03-02 16:15:24','DISPONIBLE','Leche fresca pasteurizada.',2,4),(7,'Yogur Natural','lts','Lácteos',30.00,8000.00,'2025-03-02 16:15:24','DISPONIBLE','Yogur sin azúcar y sin conservantes.',2,2),(8,'Mantequilla Artesanal','kg','Lácteos',15.00,10000.00,'2025-03-02 16:15:24','DISPONIBLE','Mantequilla sin aditivos.',2,3),(9,'Filete de Salmón','kg','Pescados y Mariscos',8.00,55000.00,'2025-03-02 16:15:24','DISPONIBLE','Salmón fresco de alta calidad.',3,2),(10,'Camarones Jumbo','kg','Pescados y Mariscos',12.00,45000.00,'2025-03-02 16:15:24','DISPONIBLE','Camarones grandes y frescos.',3,4),(11,'Atún en Lomo','kg','Pescados y Mariscos',10.00,50000.00,'2025-03-02 16:15:24','DISPONIBLE','Lomo de atún fresco.',3,3),(12,'Pulpo Fresco','kg','Pescados y Mariscos',7.00,65000.00,'2025-03-02 16:15:24','DISPONIBLE','Pulpo fresco para ceviche.',3,2),(13,'Jugo de Naranja','lts','Bebidas',30.00,10000.00,'2025-03-02 16:15:24','DISPONIBLE','Jugo natural de naranja.',4,3),(14,'Gaseosa Cola','lts','Bebidas',40.00,6000.00,'2025-03-02 16:15:24','DISPONIBLE','Refresco de cola.',4,2),(15,'Agua Mineral','lts','Bebidas',50.00,5000.00,'2025-03-02 16:15:24','DISPONIBLE','Agua mineral sin gas.',4,4),(16,'Limonada Natural','lts','Bebidas',25.00,12000.00,'2025-03-02 16:15:24','DISPONIBLE','Limonada fresca con azúcar.',4,3),(17,'Tomates Chontos','kg','Verduras',20.00,5000.00,'2025-03-02 16:15:24','DISPONIBLE','Tomates frescos y jugosos.',5,2),(18,'Lechuga Crespa','kg','Verduras',15.00,4000.00,'2025-03-02 16:15:24','DISPONIBLE','Lechuga fresca y crujiente.',5,3),(19,'Cebolla Roja','kg','Verduras',18.00,3500.00,'2025-03-02 16:15:24','DISPONIBLE','Cebolla de sabor intenso.',5,4),(20,'Papas Criollas','kg','Verduras',25.00,7000.00,'2025-03-02 16:15:24','DISPONIBLE','Papas criollas ideales para freír.',5,2);

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `rol_usuario` varchar(45) NOT NULL,
  `nombre_usuario` varchar(50) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contrasena` varchar(100) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `telefono` varchar(15) NOT NULL,
  `telefono_emergencia` varchar(15) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4;

/*Data for the table `usuarios` */

insert  into `usuarios`(`id_usuario`,`rol_usuario`,`nombre_usuario`,`nombre_completo`,`email`,`contrasena`,`direccion`,`telefono`,`telefono_emergencia`,`fecha_registro`) values (1,'Administrador','juanperez','Juan Pérez','juan.perez@huancaina.com','admin123','Calle 123 #45-67, Bogotá','3001234567','3101234567','2025-03-02 12:00:00'),(2,'Cocinero','marialopez','María López','maria.lopez@huancaina.com','cocina456','Carrera 10 #20-30, Bogotá','3002345678','3102345678','2025-03-02 12:05:00'),(3,'Cocinero','carlosgomez','Carlos Gómez','carlos.gomez@huancaina.com','chef789','Avenida Caracas #50-12, Bogotá','3003456789','3103456789','2025-03-02 12:10:00'),(4,'Bartender','luisramirez','Luis Ramírez','luis.ramirez@huancaina.com','bar123','Transversal 93 #22A-45, Bogotá','3004567890','3104567890','2025-03-02 12:15:00'),(5,'Mesero','anatorres','Ana Torres','ana.torres@huancaina.com','mesero001','Diagonal 74 #9-50, Bogotá','3005678901','3105678901','2025-03-02 12:20:00'),(6,'Mesero','pedrosanchez','Pedro Sánchez','pedro.sanchez@huancaina.com','mesero002','Calle 80 #15-10, Bogotá','3006789012','3106789012','2025-03-02 12:25:00'),(7,'Mesero','luciaherrera','Lucía Herrera','lucia.herrera@huancaina.com','mesero003','Carrera 7 #45-20, Bogotá','3007890123','3107890123','2025-03-02 12:30:00'),(8,'Mesero','ricardodiaz','Ricardo Díaz','ricardo.diaz@huancaina.com','mesero004','Avenida Suba #120-30, Bogotá','3008901234','3108901234','2025-03-02 12:35:00');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
