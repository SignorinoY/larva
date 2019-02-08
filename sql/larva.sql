-- MySQL Script generated by MySQL Workbench
-- Wed Feb  6 18:19:57 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = 'TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema larva
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `larva`;

-- -----------------------------------------------------
-- Schema larva
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `larva` DEFAULT CHARACTER SET utf8;
USE `larva`;

-- -----------------------------------------------------
-- Table `larva`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`user`;

CREATE TABLE IF NOT EXISTS `larva`.`user` (
  `user_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(60) NOT NULL DEFAULT '',
  `password` VARCHAR(255) NOT NULL DEFAULT '',
  `real_name` VARCHAR(45) NOT NULL DEFAULT '',
  `user_email` VARCHAR(100) NOT NULL DEFAULT '',
  `user_status` INT(11) NOT NULL DEFAULT 0,
  `create_time` DATETIME NOT NULL DEFAULT NOW(),
  `modified_time` DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_email_UNIQUE`(`user_email` ASC)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `larva`.`user_meta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`user_meta`;

CREATE TABLE IF NOT EXISTS `larva`.`user_meta` (
  `user_id` BIGINT UNSIGNED NOT NULL,
  `meta_key` VARCHAR(255) NULL DEFAULT '',
  `meta_value` LONGTEXT NULL,
  INDEX `fk_user_meta_user1_idx`(`user_id` ASC),
  CONSTRAINT `fk_user_meta_user1`
    FOREIGN KEY (`user_id`)
      REFERENCES `larva`.`user`(`user_id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `larva`.`role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`role`;

CREATE TABLE IF NOT EXISTS `larva`.`role` (
  `role_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_name` VARCHAR(45) NOT NULL DEFAULT '',
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`role_id`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `larva`.`resource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`resource`;

CREATE TABLE IF NOT EXISTS `larva`.`resource` (
  `resource_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `resource_name` VARCHAR(45) NOT NULL DEFAULT '',
  `resource_type` INT(11) NOT NULL DEFAULT 0,
  `resource_value` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`resource_id`)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `larva`.`permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`permission`;

CREATE TABLE IF NOT EXISTS `larva`.`permission` (
  `perm_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `perm_name` VARCHAR(45) NOT NULL DEFAULT '',
  `resource_id` BIGINT(20) UNSIGNED NOT NULL,
  `operation` INT(11) NOT NULL DEFAULT 0,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`perm_id`),
  INDEX `fk_permission_resource_idx`(`resource_id` ASC),
  CONSTRAINT `fk_permission_resource`
    FOREIGN KEY (`resource_id`)
      REFERENCES `larva`.`resource`(`resource_id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = big5;

-- -----------------------------------------------------
-- Table `larva`.`user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`user_role`;

CREATE TABLE IF NOT EXISTS `larva`.`user_role` (
  `user_id` BIGINT UNSIGNED NOT NULL,
  `role_id` BIGINT(20) UNSIGNED NOT NULL,
  INDEX `fk_user_group_user_user1_idx`(`user_id` ASC),
  INDEX `fk_user_group_user_role1_idx`(`role_id` ASC),
  CONSTRAINT `fk_user_group_user_user1`
    FOREIGN KEY (`user_id`)
      REFERENCES `larva`.`user`(`user_id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_group_user_role1`
    FOREIGN KEY (`role_id`)
      REFERENCES `larva`.`role`(`role_id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `larva`.`role_permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`role_permission`;

CREATE TABLE IF NOT EXISTS `larva`.`role_permission` (
  `role_role_id` BIGINT(20) UNSIGNED NOT NULL,
  `permission_perm_id` BIGINT(20) UNSIGNED NOT NULL,
  INDEX `fk_role_permission_role1_idx`(`role_role_id` ASC),
  INDEX `fk_role_permission_permission1_idx`(`permission_perm_id` ASC),
  CONSTRAINT `fk_role_permission_role1`
    FOREIGN KEY (`role_role_id`)
      REFERENCES `larva`.`role`(`role_id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  CONSTRAINT `fk_role_permission_permission1`
    FOREIGN KEY (`permission_perm_id`)
      REFERENCES `larva`.`permission`(`perm_id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `larva`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`post`;

CREATE TABLE IF NOT EXISTS `larva`.`post` (
  `post_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `post_title` TEXT NOT NULL,
  `post_content` LONGTEXT NOT NULL,
  `post_type` INT(11) NOT NULL DEFAULT 0,
  `post_rank` INT NOT NULL DEFAULT 0,
  `post_status` INT(11) NOT NULL DEFAULT 0,
  `create_time` DATETIME NOT NULL DEFAULT NOW(),
  `modified_time` DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`post_id`),
  INDEX `fk_post_user1_idx`(`user_id` ASC),
  CONSTRAINT `fk_post_user1`
    FOREIGN KEY (`user_id`)
      REFERENCES `larva`.`user`(`user_id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `larva`.`post_meta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`post_meta`;

CREATE TABLE IF NOT EXISTS `larva`.`post_meta` (
  `post_id` BIGINT(20) UNSIGNED NOT NULL,
  `meta_key` VARCHAR(255) NOT NULL DEFAULT '',
  `meta_value` LONGTEXT NOT NULL,
  INDEX `fk_post_meta_post1_idx`(`post_id` ASC),
  CONSTRAINT `fk_post_meta_post1`
    FOREIGN KEY (`post_id`)
      REFERENCES `larva`.`post`(`post_id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `larva`.`tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`tag`;

CREATE TABLE IF NOT EXISTS `larva`.`tag` (
  `tag_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag_name` VARCHAR(45) NOT NULL DEFAULT '',
  `tag_description` VARCHAR(255) NULL,
  PRIMARY KEY (`tag_id`),
  UNIQUE INDEX `tag_name_UNIQUE`(`tag_name` ASC)
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `larva`.`post_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`post_tag`;

CREATE TABLE IF NOT EXISTS `larva`.`post_tag` (
  `post_id` BIGINT(20) UNSIGNED NOT NULL,
  `tag_id` BIGINT(20) UNSIGNED NOT NULL,
  INDEX `fk_post_tag_post1_idx`(`post_id` ASC),
  INDEX `fk_post_tag_tag1_idx`(`tag_id` ASC),
  CONSTRAINT `fk_post_tag_post1`
    FOREIGN KEY (`post_id`)
      REFERENCES `larva`.`post`(`post_id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_tag_tag1`
    FOREIGN KEY (`tag_id`)
      REFERENCES `larva`.`tag`(`tag_id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `larva`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`category`;

CREATE TABLE IF NOT EXISTS `larva`.`category` (
  `category_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL DEFAULT '',
  `category_description` VARCHAR(255) NULL,
  `parent_category` BIGINT(20) NOT NULL,
  PRIMARY KEY (`category_id`),
  INDEX `fk_category_category1_idx`(`parent_category` ASC),
  CONSTRAINT `fk_category_category1`
    FOREIGN KEY (`parent_category`)
      REFERENCES `larva`.`category`(`category_id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table `larva`.`post_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`post_category`;

CREATE TABLE IF NOT EXISTS `larva`.`post_category` (
  `post_id` BIGINT(20) UNSIGNED NOT NULL,
  `category_id` BIGINT(20) NOT NULL,
  INDEX `fk_post_category_post1_idx`(`post_id` ASC),
  INDEX `fk_post_category_category1_idx`(`category_id` ASC),
  CONSTRAINT `fk_post_category_post1`
    FOREIGN KEY (`post_id`)
      REFERENCES `larva`.`post`(`post_id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  CONSTRAINT `fk_post_category_category1`
    FOREIGN KEY (`category_id`)
      REFERENCES `larva`.`category`(`category_id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `larva`.`file`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `larva`.`file`;

CREATE TABLE IF NOT EXISTS `larva`.`file` (
  `file_id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `file_name` VARCHAR(255) NOT NULL DEFAULT '',
  `file_type` VARCHAR(255) NOT NULL DEFAULT '',
  `file_size` BIGINT NOT NULL DEFAULT 0,
  `local_url` VARCHAR(1024) NOT NULL DEFAULT '',
  `visit_url` VARCHAR(1024) NOT NULL DEFAULT '',
  `user_id` BIGINT UNSIGNED NOT NULL,
  `create_time` DATETIME NOT NULL DEFAULT NOW(),
  `modified_time` DATETIME NOT NULL DEFAULT NOW(),
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`file_id`),
  INDEX `fk_file_user1_idx`(`user_id` ASC),
  CONSTRAINT `fk_file_user1`
    FOREIGN KEY (`user_id`)
      REFERENCES `larva`.`user`(`user_id`)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
  ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS larva;
SET SQL_MODE = 'TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'larva' IDENTIFIED BY 'SWUFE12346!@#$%^';

GRANT ALL ON `larva`.* TO 'larva';

SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
