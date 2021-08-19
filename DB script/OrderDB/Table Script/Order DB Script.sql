-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Go2Shop
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ShoppingCartDB
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema UserDB
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ProductDB
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema OrderDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema OrderDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `OrderDB` ;
-- -----------------------------------------------------
-- Schema TestDB
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema orderdb
-- -----------------------------------------------------
USE `OrderDB` ;

DROP TABLE IF EXISTS `OrderDB`.`TB_ORDER`;

-- -----------------------------------------------------
-- Table `OrderDB`.`TB_ORDER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OrderDB`.`TB_ORDER` (
  `ID` INT NOT NULL,
  `STATUS` VARCHAR(25) NOT NULL,
  `ORDER_DATE` DATETIME NOT NULL,
  `TB_USER_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `TB_USER_ID`))
ENGINE = InnoDB;

DROP TABLE IF EXISTS `OrderDB`.`TB_ORDER_DETAIL`;

-- -----------------------------------------------------
-- Table `OrderDB`.`TB_ORDER_DETAIL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `OrderDB`.`TB_ORDER_DETAIL` (
  `ID` INT NOT NULL,
  `ORDER_DATE` DATETIME NOT NULL,
  `ORDER_RECEIVED` DATETIME NULL,
  `PAYMENT_DATE` DATETIME NULL,
  `PAYMENT` DECIMAL(6) NULL,
  `TB_ORDER_ID` INT NOT NULL,
  `TB_PRODUCT_ID` INT NOT NULL,
  PRIMARY KEY (`ID`, `TB_ORDER_ID`, `TB_PRODUCT_ID`),
  INDEX `fk_TB_ORDER_DETAIL_TB_ORDER1_idx` (`TB_ORDER_ID` ASC) VISIBLE,
  CONSTRAINT `fk_TB_ORDER_DETAIL_TB_ORDER1`
    FOREIGN KEY (`TB_ORDER_ID`)
    REFERENCES `OrderDB`.`TB_ORDER` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
