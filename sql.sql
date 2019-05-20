-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema onepieceDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema onepieceDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `onepieceDB` DEFAULT CHARACTER SET utf8 ;
USE `onepieceDB` ;

-- -----------------------------------------------------
-- Table `onepieceDB`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onepieceDB`.`user` (
  `user_id` VARCHAR(45) NOT NULL,
  `user_pw` VARCHAR(45) NOT NULL,
  `user_name` VARCHAR(45) NOT NULL,
  `user_nickname` VARCHAR(45) NULL,
  `user_phone` VARCHAR(45) NOT NULL,
  `user_email` VARCHAR(45) NOT NULL,
  `user_birth` DATE NULL,
  `user_gender` CHAR NOT NULL,
  `user_address` VARCHAR(100) NULL,
  `user_school` VARCHAR(45) NULL,
  `user_edu_city` VARCHAR(45) NOT NULL,
  `user_th` INT NOT NULL,
  `user_rank` VARCHAR(45) NOT NULL,
  `user_point` INT NOT NULL DEFAULT 0,
  `user_photo` VARCHAR(100) NOT NULL,
  `user_isleave` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_nickname_UNIQUE` (`user_nickname` ASC) VISIBLE,
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC) VISIBLE,
  UNIQUE INDEX `user_phone_UNIQUE` (`user_phone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `onepieceDB`.`notice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onepieceDB`.`notice` (
  `notice_no` INT NOT NULL AUTO_INCREMENT,
  `notice_title` VARCHAR(45) NOT NULL,
  `notice_content` VARCHAR(20000) NOT NULL,
  `notice_date` DATETIME NOT NULL DEFAULT current_timestamp,
  `notice_hits` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`notice_no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `onepieceDB`.`notice_comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onepieceDB`.`notice_comment` (
  `ncomment_no` INT NOT NULL AUTO_INCREMENT,
  `ncomment_user_id` VARCHAR(45) NOT NULL,
  `ncomment_notice_no` INT NOT NULL,
  `ncomment_content` VARCHAR(20000) NOT NULL,
  `ncomment_date` DATETIME NOT NULL DEFAULT current_timestamp,
  `ncomment_pno` INT NULL,
  PRIMARY KEY (`ncomment_no`),
  INDEX `fk_user_has_notice_notice1_idx` (`ncomment_notice_no` ASC) VISIBLE,
  INDEX `fk_user_has_notice_user_idx` (`ncomment_user_id` ASC) VISIBLE,
  INDEX `fk_notice_comment_notice_comment1_idx` (`ncomment_pno` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_notice_user`
    FOREIGN KEY (`ncomment_user_id`)
    REFERENCES `onepieceDB`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_notice_notice1`
    FOREIGN KEY (`ncomment_notice_no`)
    REFERENCES `onepieceDB`.`notice` (`notice_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_notice_comment_notice_comment1`
    FOREIGN KEY (`ncomment_pno`)
    REFERENCES `onepieceDB`.`notice_comment` (`ncomment_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `onepieceDB`.`freeboard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onepieceDB`.`freeboard` (
  `freeboard_no` INT NOT NULL AUTO_INCREMENT,
  `freeboard_title` VARCHAR(45) NOT NULL,
  `freeboard_content` VARCHAR(20000) NOT NULL,
  `freeboard_date` DATETIME NOT NULL DEFAULT current_timestamp,
  `freeboard_hits` INT NOT NULL DEFAULT 0,
  `freeboard_likes` INT NOT NULL DEFAULT 0,
  `freeboard_hates` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`freeboard_no`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `onepieceDB`.`freeboard_comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onepieceDB`.`freeboard_comment` (
  `fbcomment_no` INT NOT NULL AUTO_INCREMENT,
  `fbcomment_freeboard_no` INT NOT NULL,
  `fbcomment_user_id` VARCHAR(45) NOT NULL,
  `fbcomment_content` VARCHAR(20000) NOT NULL,
  `fbcomment_date` DATETIME NOT NULL DEFAULT current_timestamp,
  `fbcomment_likes` INT NOT NULL DEFAULT 0,
  `fbcomment_hates` INT NOT NULL DEFAULT 0,
  `fbcomment_pno` INT NOT NULL,
  INDEX `fk_freeboard_has_user_user1_idx` (`fbcomment_user_id` ASC) VISIBLE,
  INDEX `fk_freeboard_has_user_freeboard1_idx` (`fbcomment_freeboard_no` ASC) VISIBLE,
  PRIMARY KEY (`fbcomment_no`),
  INDEX `fk_freeboard_comment_freeboard_comment1_idx` (`fbcomment_pno` ASC) VISIBLE,
  CONSTRAINT `fk_freeboard_has_user_freeboard1`
    FOREIGN KEY (`fbcomment_freeboard_no`)
    REFERENCES `onepieceDB`.`freeboard` (`freeboard_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_freeboard_has_user_user1`
    FOREIGN KEY (`fbcomment_user_id`)
    REFERENCES `onepieceDB`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_freeboard_comment_freeboard_comment1`
    FOREIGN KEY (`fbcomment_pno`)
    REFERENCES `onepieceDB`.`freeboard_comment` (`fbcomment_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `onepieceDB`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `onepieceDB`.`message` (
  `message_no` INT NOT NULL AUTO_INCREMENT,
  `message_suser_id` VARCHAR(45) NOT NULL,
  `message_ruser_id` VARCHAR(45) NOT NULL,
  `message_title` VARCHAR(45) NOT NULL,
  `message_content` VARCHAR(20000) NOT NULL,
  `message_date` DATETIME NOT NULL,
  `message_isread` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`message_no`),
  INDEX `fk_message_user1_idx` (`message_ruser_id` ASC) VISIBLE,
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`message_ruser_id`)
    REFERENCES `onepieceDB`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
