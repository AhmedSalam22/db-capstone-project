-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Little_Lemon
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Little_Lemon
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Little_Lemon` DEFAULT CHARACTER SET utf8 ;
USE `Little_Lemon` ;

-- -----------------------------------------------------
-- Table `Little_Lemon`.`booking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`booking` (
  `booking_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NULL,
  `table_num` INT NULL,
  PRIMARY KEY (`booking_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`staff` (
  `idstaff` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NULL,
  `salary` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idstaff`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`customer` (
  `idcustomer` INT NOT NULL AUTO_INCREMENT,
  `FullName` VARCHAR(45) NULL,
  `ContactNumber` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `staff_idstaff` INT NOT NULL,
  PRIMARY KEY (`idcustomer`),
  INDEX `fk_customer_staff1_idx` (`staff_idstaff` ASC) VISIBLE,
  CONSTRAINT `fk_customer_staff1`
    FOREIGN KEY (`staff_idstaff`)
    REFERENCES `Little_Lemon`.`staff` (`idstaff`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`Orders` (
  `idOrders` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NULL,
  `quantity` INT NULL,
  `total_cost` FLOAT NULL,
  `customer_idcustomer` INT NOT NULL,
  PRIMARY KEY (`idOrders`, `customer_idcustomer`),
  INDEX `fk_Orders_customer_idx` (`customer_idcustomer` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_customer`
    FOREIGN KEY (`customer_idcustomer`)
    REFERENCES `Little_Lemon`.`customer` (`idcustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`delivery_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`delivery_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NULL,
  `status` VARCHAR(45) NULL,
  `Orders_idOrders` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_delivery_status_Orders1_idx` (`Orders_idOrders` ASC) VISIBLE,
  CONSTRAINT `fk_delivery_status_Orders1`
    FOREIGN KEY (`Orders_idOrders`)
    REFERENCES `Little_Lemon`.`Orders` (`idOrders`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`menus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `cuisine` VARCHAR(45) NULL,
  `Orders_idOrders` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_menus_Orders1_idx` (`Orders_idOrders` ASC) VISIBLE,
  CONSTRAINT `fk_menus_Orders1`
    FOREIGN KEY (`Orders_idOrders`)
    REFERENCES `Little_Lemon`.`Orders` (`idOrders`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`menusItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`menusItems` (
  `idmenusItems` INT NOT NULL AUTO_INCREMENT,
  `CourseName` VARCHAR(45) NULL,
  `Starter` VARCHAR(45) NULL,
  `desert` VARCHAR(45) NULL,
  `drink` VARCHAR(45) NULL,
  `sides` VARCHAR(45) NULL,
  PRIMARY KEY (`idmenusItems`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Little_Lemon`.`menus_has_menusItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Little_Lemon`.`menus_has_menusItems` (
  `menus_id` INT NOT NULL,
  `menusItems_idmenusItems` INT NOT NULL,
  PRIMARY KEY (`menus_id`, `menusItems_idmenusItems`),
  INDEX `fk_menus_has_menusItems_menusItems1_idx` (`menusItems_idmenusItems` ASC) VISIBLE,
  INDEX `fk_menus_has_menusItems_menus1_idx` (`menus_id` ASC) VISIBLE,
  CONSTRAINT `fk_menus_has_menusItems_menus1`
    FOREIGN KEY (`menus_id`)
    REFERENCES `Little_Lemon`.`menus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menus_has_menusItems_menusItems1`
    FOREIGN KEY (`menusItems_idmenusItems`)
    REFERENCES `Little_Lemon`.`menusItems` (`idmenusItems`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
