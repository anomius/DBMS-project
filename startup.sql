-- -----------------------------------------------------
-- Schema py_medicine_tracker
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `py_medicine_tracker`;
CREATE SCHEMA `py_medicine_tracker`;
USE `py_medicine_tracker` ;
-- -----------------------------------------------------
-- Table `py_medicine_tracker`.`stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `py_medicine_tracker`.`stock` (
 `id` int NOT NULL AUTO_INCREMENT,
 `drugName` varchar(45) DEFAULT NULL,
 `quantity` int DEFAULT NULL,
 `price` int DEFAULT NULL,
 `stock_status` varchar(45) DEFAULT NULL,
 `sLastUpdationDate` date DEFAULT NULL,
 PRIMARY KEY (`id`)
)
ENGINE=InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARSET=latin1;
------------------------------------------------------
-- Before Trigger on stock
------------------------------------------------------
DELIMITER $$
DROP TRIGGER IF EXISTS `updateStock`$$
CREATE TRIGGER updateStock
 BEFORE INSERT
 ON stock
FOR EACH ROW
BEGIN
set new.sLastUpdationDate = curdate();
END$$
DELIMITER ;
-- -----------------------------------------------------
-- Add sample data
-- -----------------------------------------------------
insert into stock (id,drugName,quantity,price,stock_status)
values ('1','Paracetamol','100','10','Available');
insert into stock (id,drugName,quantity,price,stock_status)
values ('2','Testimol','100','20','Available');
insert into stock (id,drugName,quantity,price,stock_status)
values ('3','Sinarest','100','30','Available');
insert into stock (id,drugName,quantity,price,stock_status)
values ('4','FebrexPlus','100','40','Available');
insert into stock (id,drugName,quantity,price,stock_status)
values ('5','Crocin','100','50','Available');
-- -----------------------------------------------------
-- Table `py_medicine_tracker`.`pharmacist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `py_medicine_tracker`.`pharmacist` (
 `id` int NOT NULL AUTO_INCREMENT,
 `userName` varchar(45) DEFAULT NULL,
 `pwd` varchar(45) DEFAULT NULL,
 `isAdmin` boolean DEFAULT NULL,
 `pLastUpdationDate` date DEFAULT NULL,
 PRIMARY KEY (`id`)
)
ENGINE=InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARSET=latin1;
------------------------------------------------------
-- Before Trigger on pharmacist
------------------------------------------------------
DELIMITER $$
DROP TRIGGER IF EXISTS `updatePharmacist`$$
CREATE TRIGGER updatePharmacist
 BEFORE INSERT
 ON pharmacist
FOR EACH ROW
BEGIN
set new.pLastUpdationDate = curdate();
END$$
DELIMITER ;
-- -----------------------------------------------------
-- Add sample data
-- -----------------------------------------------------
insert into pharmacist (id,userName,pwd,isAdmin)
values ('1','admin','admin',true);
insert into pharmacist (id,userName,pwd,isAdmin)
values ('2','yuvraj','poo',false);
-- -----------------------------------------------------
-- Table `py_medicine_tracker`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `py_medicine_tracker`.`customer` (
 `id` int NOT NULL AUTO_INCREMENT,
 `firstName` varchar(45) DEFAULT NULL,
 `lastName` varchar(45) DEFAULT NULL,
 `address` varchar(45) DEFAULT NULL,
 `cLastUpdationDate` date DEFAULT NULL,
 PRIMARY KEY (`id`)
)
ENGINE=InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARSET=latin1;
------------------------------------------------------
-- Before Trigger on customer
------------------------------------------------------
DELIMITER $$
DROP TRIGGER IF EXISTS `updateCustomer`$$
CREATE TRIGGER updateCustomer
 BEFORE INSERT
 ON customer
FOR EACH ROW
BEGIN
set new.cLastUpdationDate = curdate();
END$$
DELIMITER ;
-- -----------------------------------------------------
-- Add sample data
-- -----------------------------------------------------
insert into customer (id,firstName,lastName,address)
values ('1','Swaraj','Purohit','Surat');
insert into customer (id,firstName,lastName,address)
values ('2','Poonam','Purohit','Surat');
insert into customer (id,firstName,lastName,address)
values ('3','Renuka','Purohit','Surat');
insert into customer (id,firstName,lastName,address)
values ('4','Dwarkadas','Purohit','Surat');
insert into customer (id,firstName,lastName,address)
values ('5','Darshan','Guru','Ahmedabad');
-- -----------------------------------------------------
-- Table `py_medicine_tracker`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `py_medicine_tracker`.`orders` (
 `id` int NOT NULL AUTO_INCREMENT,
 `orderDate` date DEFAULT NULL,
 `orderQty` int DEFAULT NULL,
 `orderTotal` int DEFAULT NULL,
 `customerId` int NOT NULL,
 `oLastUpdationDate` date DEFAULT NULL,
 PRIMARY KEY (`id`),
 FOREIGN KEY (customerId)
 REFERENCES customer(id)
 ON DELETE CASCADE
)
ENGINE=InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARSET=latin1;
------------------------------------------------------
-- Before Trigger on orders
------------------------------------------------------
DELIMITER $$
DROP TRIGGER IF EXISTS `updateOrders`$$
CREATE TRIGGER updateOrders
 BEFORE INSERT
 ON orders
FOR EACH ROW
BEGIN
set new.oLastUpdationDate = curdate();
END$$
DELIMITER ;
-- -----------------------------------------------------
-- Add sample data
-- -----------------------------------------------------
insert into orders (id,orderDate,orderQty,orderTotal,customerId)
values ('1','2021/09/06','2','100','1');
insert into orders (id,orderDate,orderQty,orderTotal,customerId)
values ('2','2021/09/06','2','100','2');
insert into orders (id,orderDate,orderQty,orderTotal,customerId)
values ('3','2021/09/06','2','100','3');
insert into orders (id,orderDate,orderQty,orderTotal,customerId)
values ('4','2021/09/06','2','100','3');
-- -----------------------------------------------------
-- Table `py_medicine_tracker`.`stockorder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `py_medicine_tracker`.`stockorder` (
 `orderId` int NOT NULL,
 `stockId` int NOT NULL,
 `pharmacistId` int NOT NULL,
 FOREIGN KEY (orderId)
 REFERENCES orders(id)
 ON DELETE CASCADE,
FOREIGN KEY (stockId)
 REFERENCES stock(id)
 ON DELETE CASCADE,
FOREIGN KEY (pharmacistId)
 REFERENCES pharmacist(id)
 ON DELETE CASCADE
)
ENGINE=InnoDB
AUTO_INCREMENT = 1
DEFAULT CHARSET=latin1;
-- -----------------------------------------------------
-- Add sample data
-- -----------------------------------------------------
insert into stockorder (orderId,stockId,pharmacistId)
values ('1','5','2');
insert into stockorder (orderId,stockId,pharmacistId)
values ('2','5','2');
insert into stockorder (orderId,stockId,pharmacistId)
values ('3','5','2');
insert into stockorder (orderId,stockId,pharmacistId)
values ('4','5','2');
---------------------------------------------------------
--Procedure to get orders by customerId
---------------------------------------------------------
DELIMITER //
CREATE PROCEDURE GetOrdersByCustomerId(
IN custId VARCHAR(255)
)
BEGIN
SELECT *
 FROM orders
WHERE customerId = custId;
END //
DELIMITER ;

