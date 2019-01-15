-- MySQL Script generated by MySQL Workbench
-- Tue Jan 15 23:02:55 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema larva
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `larva` ;

-- -----------------------------------------------------
-- Schema larva
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `larva` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `larva` ;

-- -----------------------------------------------------
-- Table `larva`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`user` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`user` (
  `user_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(60) NOT NULL COMMENT '用户姓名',
  `password` VARCHAR(255) NOT NULL COMMENT '密码',
  `real_name` VARCHAR(45) NOT NULL COMMENT '真实姓名',
  `user_email` VARCHAR(100) NOT NULL COMMENT '用户邮箱',
  `user_status` INT(11) NOT NULL DEFAULT 0 COMMENT '用户状态',
  `create_time` DATETIME NOT NULL,
  `modified_time` DATETIME NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_name_UNIQUE` (`user_name` ASC),
  UNIQUE INDEX `user_email_UNIQUE` (`user_email` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`user_meta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`user_meta` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`user_meta` (
  `user_meta_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `meta_key` VARCHAR(255) NULL,
  `meta_value` LONGTEXT NULL,
  PRIMARY KEY (`user_meta_id`),
  INDEX `fk_user_meta_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_meta_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `larva`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`role` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`role` (
  `role_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(45) NOT NULL,
  `role_status` INT(11) NOT NULL DEFAULT 0,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`role_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`resource` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`resource` (
  `resource_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `resource_name` VARCHAR(45) NOT NULL,
  `resource_type` INT(11) NOT NULL,
  `resource_value` BIGINT(20) UNSIGNED NOT NULL,
  `resource_status` INT(11) NOT NULL DEFAULT 0,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`resource_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`permission` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`permission` (
  `perm_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `perm_name` VARCHAR(45) NOT NULL,
  `resource_id` BIGINT(20) UNSIGNED NOT NULL,
  `operation` INT(11) NULL,
  `perm_status` INT(11) NOT NULL DEFAULT 0,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`perm_id`),
  INDEX `fk_permission_resource_idx` (`resource_id` ASC),
  CONSTRAINT `fk_permission_resource`
    FOREIGN KEY (`resource_id`)
    REFERENCES `larva`.`resource` (`resource_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = big5;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`user_group`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`user_group` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`user_group` (
  `user_group_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_group_name` VARCHAR(45) NOT NULL,
  `user_group_status` INT(11) NOT NULL DEFAULT 0,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`user_group_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`user_group_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`user_group_user` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`user_group_user` (
  `user_id` BIGINT UNSIGNED NOT NULL,
  `user_group_user_group_id` BIGINT UNSIGNED NOT NULL,
  INDEX `fk_user_group_user_user1_idx` (`user_id` ASC),
  INDEX `fk_user_group_user_user_group1_idx` (`user_group_user_group_id` ASC),
  CONSTRAINT `fk_user_group_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `larva`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_group_user_user_group1`
    FOREIGN KEY (`user_group_user_group_id`)
    REFERENCES `larva`.`user_group` (`user_group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`user_group_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`user_group_role` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`user_group_role` (
  `user_group_user_group_id` BIGINT UNSIGNED NOT NULL,
  `role_role_id` BIGINT(20) UNSIGNED NOT NULL,
  INDEX `fk_user_group_role_user_group1_idx` (`user_group_user_group_id` ASC),
  INDEX `fk_user_group_role_role1_idx` (`role_role_id` ASC),
  CONSTRAINT `fk_user_group_role_user_group1`
    FOREIGN KEY (`user_group_user_group_id`)
    REFERENCES `larva`.`user_group` (`user_group_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_group_role_role1`
    FOREIGN KEY (`role_role_id`)
    REFERENCES `larva`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`role_permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`role_permission` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`role_permission` (
  `role_role_id` BIGINT(20) UNSIGNED NOT NULL,
  `permission_perm_id` BIGINT(20) UNSIGNED NOT NULL,
  INDEX `fk_role_permission_role1_idx` (`role_role_id` ASC),
  INDEX `fk_role_permission_permission1_idx` (`permission_perm_id` ASC),
  CONSTRAINT `fk_role_permission_role1`
    FOREIGN KEY (`role_role_id`)
    REFERENCES `larva`.`role` (`role_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_permission_permission1`
    FOREIGN KEY (`permission_perm_id`)
    REFERENCES `larva`.`permission` (`perm_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`post` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`post` (
  `post_id` BIGINT(20) UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `post_title` TEXT NOT NULL,
  `post_content` LONGTEXT NOT NULL,
  `post_type` INT(11) NOT NULL DEFAULT 0,
  `post_rank` INT NOT NULL DEFAULT 0,
  `post_status` INT(11) NOT NULL DEFAULT 0,
  `create_time` DATETIME NOT NULL,
  `modified_time` DATETIME NOT NULL,
  PRIMARY KEY (`post_id`),
  INDEX `fk_post_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `larva`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`post_meta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`post_meta` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`post_meta` (
  `post_meta_id` BIGINT(20) UNSIGNED NOT NULL,
  `post_id` BIGINT(20) UNSIGNED NOT NULL,
  `meta_key` VARCHAR(255) NULL,
  `meta_value` LONGTEXT NULL,
  PRIMARY KEY (`post_meta_id`),
  INDEX `fk_post_meta_post1_idx` (`post_id` ASC),
  CONSTRAINT `fk_post_meta_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `larva`.`post` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`tag` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`tag` (
  `tag_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(45) NOT NULL,
  `tag_status` INT(11) NOT NULL DEFAULT 0,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`tag_id`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`post_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`post_tag` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`post_tag` (
  `post_id` BIGINT(20) UNSIGNED NOT NULL,
  `tag_id` BIGINT(20) UNSIGNED NOT NULL,
  INDEX `fk_post_tag_post1_idx` (`post_id` ASC),
  INDEX `fk_post_tag_tag1_idx` (`tag_id` ASC),
  CONSTRAINT `fk_post_tag_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `larva`.`post` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_tag_tag1`
    FOREIGN KEY (`tag_id`)
    REFERENCES `larva`.`tag` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`category` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`category` (
  `category_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  `category_status` INT(11) NOT NULL,
  `description` VARCHAR(255) NULL DEFAULT 0,
  `parent_category` BIGINT(20) NOT NULL,
  PRIMARY KEY (`category_id`),
  INDEX `fk_category_category1_idx` (`parent_category` ASC),
  CONSTRAINT `fk_category_category1`
    FOREIGN KEY (`parent_category`)
    REFERENCES `larva`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`post_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`post_category` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`post_category` (
  `post_id` BIGINT(20) UNSIGNED NOT NULL,
  `category_id` BIGINT(20) NOT NULL,
  INDEX `fk_post_category_post1_idx` (`post_id` ASC),
  INDEX `fk_post_category_category1_idx` (`category_id` ASC),
  CONSTRAINT `fk_post_category_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `larva`.`post` (`post_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `larva`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`folder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`folder` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`folder` (
  `folder_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `folder_name` VARCHAR(255) NOT NULL,
  `create_time` DATETIME NOT NULL,
  `modified_time` DATETIME NOT NULL,
  `description` VARCHAR(255) NULL,
  `parent_folder` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`folder_id`),
  INDEX `fk_folder_folder1_idx` (`parent_folder` ASC),
  CONSTRAINT `fk_folder_folder1`
    FOREIGN KEY (`parent_folder`)
    REFERENCES `larva`.`folder` (`folder_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `larva`.`file`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`file` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `larva`.`file` (
  `file_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `file_name` VARCHAR(255) NOT NULL,
  `file_type` VARCHAR(255) NULL,
  `file_size` BIGINT NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `create_time` DATETIME NOT NULL,
  `modified_time` DATETIME NOT NULL,
  `description` VARCHAR(255) NULL,
  `parent_folder` BIGINT(20) UNSIGNED NOT NULL,
  PRIMARY KEY (`file_id`),
  INDEX `fk_file_user1_idx` (`user_id` ASC),
  INDEX `fk_file_folder1_idx` (`parent_folder` ASC),
  CONSTRAINT `fk_file_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `larva`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_file_folder1`
    FOREIGN KEY (`parent_folder`)
    REFERENCES `larva`.`folder` (`folder_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
SET SQL_MODE = '';
DROP USER IF EXISTS larva;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
SHOW WARNINGS;
CREATE USER 'larva' IDENTIFIED BY 'SWUFE12346!@#$%^';

GRANT ALL ON `larva`.* TO 'larva';
SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
