-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb`;
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`buget`(
`buget_initial` INT(11) NULL DEFAULT NULL,
`buget_temporar` INT(11) NULL DEFAULT NULL,
`data_initiala` DATETIME NULL DEFAULT NULL,
`data_temporala` DATETIME NULL DEFAULT NULL,
`STUDENT_id` INT NULL DEFAULT NULL,
CONSTRAINT `fk_buget1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`student` (`id`)
     ON DELETE 	CASCADE
     ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`student` (
  `id` INT(11) NOT NULL,
  `nume` VARCHAR(45) NULL DEFAULT NULL,
  `prenume` VARCHAR(45) NULL DEFAULT NULL,
  `anul_de_studiu` INT NULL DEFAULT NULL,
  `adresa` VARCHAR(45) NULL DEFAULT NULL,
  `domiciliu_temporar` VARCHAR(45) NULL DEFAULT NULL,
  `buget_membru` INT DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`evidenta_cheltuieli` (
  `data_intermediara` DATETIME NULL,
  `suma_cheltuita` INT NULL,
  `buget_ramas` INT NULL,
  `STUDENT_id` INT NOT NULL,
 # PRIMARY KEY (`situatie_scolara_id_semestru`, `situatie_scolara_STUDENT_id`),
  CONSTRAINT `fk_evidenta_cheltuieli_student1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`student` (`id`)
     ON DELETE 	CASCADE
     ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `mydb`.`evidenta_bani_primiti` (
  `data_intermediara` DATETIME NULL,
  `suma_primita` INT NULL,
  `buget_nou` INT NULL,
  `STUDENT_id` INT NOT NULL,
 # PRIMARY KEY (`situatie_scolara_id_semestru`, `situatie_scolara_STUDENT_id`),
  CONSTRAINT `fk_evidenta_bani_primiti_student1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`student` (`id`)
     ON DELETE 	CASCADE
     ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `mydb`.`situatie_scolara`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`situatie_scolara` (
  `id_semestru` INT(11) NOT NULL,
  `tip_finantare` VARCHAR(45) NULL DEFAULT NULL,
  `nr_examen_r` INT(11) NULL DEFAULT NULL,
  `nr_ani_examen_r` INT(11) NULL DEFAULT NULL,
  `nr_laboratoare_r` INT(11) NULL DEFAULT NULL,
  `STUDENT_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_semestru`, `STUDENT_id`),
  INDEX `fk_situatie_scolara_STUDENT1_idx` (`STUDENT_id` ASC),
  CONSTRAINT `fk_situatie_scolara_STUDENT1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `mydb`.`medie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`medie` (
  `media_an_anterior` INT  NULL,
  `media_sem1` INT NULL,
  `media_sem2` INT NULL,
  `situatie_scolara_id_semestru` INT NOT NULL,
  `situatie_scolara_STUDENT_id` INT NOT NULL,
 PRIMARY KEY (`situatie_scolara_id_semestru`, `situatie_scolara_STUDENT_id`),
 
  CONSTRAINT `fk_situatie_scolara_medie1`
    FOREIGN KEY ( `situatie_scolara_STUDENT_id`)
    REFERENCES `mydb`.`situatie_scolara` (`STUDENT_id`))
   # ON DELETE 	CASCADE
	#ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`situatie_sociala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`situatie_sociala` (
  `tip_social` VARCHAR(45) NULL DEFAULT NULL,
  `STUDENT_id` INT NOT NULL,
  PRIMARY KEY (`STUDENT_id`),
  CONSTRAINT `fk_situatie_sociala_STUDENT1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`student` (`id`)
	ON DELETE 	CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`bursa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bursa` (
  `tip_bursa` VARCHAR(45) NULL,
  `suma_bursa` INT NULL,
  `data_intrare_bursa` DATETIME NULL,
  `situatie_sociala_STUDENT_id` INT NOT NULL,
  `medie_situatie_scolara_id_semestru` INT NOT NULL,
  `medie_situatie_scolara_STUDENT_id` INT NOT NULL,
 # PRIMARY KEY ( `medie_situatie_scolara_id_semestru`, `medie_situatie_scolara_STUDENT_id`),
  INDEX `fk_bursa_medie1_idx` (`medie_situatie_scolara_id_semestru` ASC, `medie_situatie_scolara_STUDENT_id` ASC),
   CONSTRAINT `fk_bursa_situatie_sociala1`
    FOREIGN KEY (`situatie_sociala_STUDENT_id`)
    REFERENCES `mydb`.`situatie_sociala` (`STUDENT_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bursa_medie1`
    FOREIGN KEY ( `medie_situatie_scolara_STUDENT_id`)
    REFERENCES `mydb`.`medie` ( `situatie_scolara_STUDENT_id`))

   

ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`cumparaturi_extra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cumparaturi_extra` (
  `tip_cumparaturi` VARCHAR(45) NULL DEFAULT NULL,
  `plata_cumparaturi` INT(11) NULL DEFAULT NULL,
  `data_c` DATETIME NULL DEFAULT NULL,
  `STUDENT_id` INT(11) NOT NULL,
  #PRIMARY KEY (`STUDENT_id`),
  CONSTRAINT `fk_cumparaturi_extra_STUDENT1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`divertisment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`divertisment` (
  `tip_activitate` VARCHAR(45) NULL DEFAULT NULL,
  `plata_activitate` INT(11) NULL DEFAULT NULL,
  `data_d` DATETIME NULL DEFAULT NULL,
  `STUDENT_id` INT(11) NOT NULL,
 -- PRIMARY KEY (`STUDENT_id`),
  CONSTRAINT `fk_divertisment_STUDENT1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`domiciuliu_temp`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`domiciliu_temp` (
  `tip_domiciliu` VARCHAR(45) NULL DEFAULT NULL,
  `plata` INT(11) NULL DEFAULT NULL,
  `data_mutarii` DATETIME NULL DEFAULT NULL,
  `data_plata` DATETIME NULL DEFAULT NULL,
  `STUDENT_id` INT(11) NOT NULL,
  PRIMARY KEY (`STUDENT_id`),
  CONSTRAINT `fk_domiciuliu_temp_STUDENT1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`facultate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`facultate` (
  `id_facultate` INT(11) NOT NULL,
  `nume_specializare` VARCHAR(45) NULL DEFAULT NULL,
  `nume_facultate` VARCHAR(45) NULL DEFAULT NULL,
  `media_minima_bursa` INT(11) NULL DEFAULT NULL,
  `STUDENT_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_facultate`, `STUDENT_id`),
  INDEX `fk_FACULTATE_STUDENT_idx` (`STUDENT_id` ASC),
  CONSTRAINT `fk_FACULTATE_STUDENT`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`imprumuturi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`imprumuturi` (
  
  `id_student_cerere` INT(11) NULL DEFAULT NULL,
  `id_student_imprumutor` INT(11) NULL DEFAULT NULL,
  `suma_imprumutata` INT(11) NULL DEFAULT NULL,
  `data_imprumut` DATETIME NULL DEFAULT NULL,
  `data_returnare_imprumut` DATETIME NULL DEFAULT NULL,
  `STUDENT_id` INT NULL DEFAULT NULL,
  #PRIMARY KEY (`STUDENT_id`),
  INDEX `fk_imprumuturi_STUDENT1_idx` (`STUDENT_id` ASC),
  CONSTRAINT `fk_imprumuturi_STUDENT1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`job`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`job` (
  `tip_job` VARCHAR(45) NULL DEFAULT NULL,
  `data_angajare` DATETIME NULL DEFAULT NULL,
  `data_salarizare` DATETIME NULL DEFAULT NULL,
  `salariu_brut` INT(11) NULL DEFAULT NULL,
  `STUDENT_id` INT(11) NOT NULL,
  PRIMARY KEY (`STUDENT_id`),
  CONSTRAINT `fk_job_STUDENT1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`mancare`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mancare` (
  `id_masa` INT(11) NULL DEFAULT NULL,
  `data_m` DATETIME NULL,
  `STUDENT_id` INT(11)  NULL,
  `plata_mancare` INT(11) NULL DEFAULT NULL,
  #PRIMARY KEY (`id_masa`,`STUDENT_id`))
  INDEX `fk_mancare_STUDENT1_idx` (`STUDENT_id` ASC),
  CONSTRAINT `fk_mancare_STUDENT1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`student` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`loc_mancare`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`loc_mancare` (
  `tip_loc` VARCHAR(45) NULL DEFAULT NULL,
  `mancare_id_masa` INT(11) NOT NULL,
  `mancare_STUDENT_id` INT(11) NOT NULL,
  #PRIMARY KEY (`mancare_id_masa`),
  CONSTRAINT `fk_mancare_STUDENT_id1`
    FOREIGN KEY (`mancare_STUDENT_id`)
    REFERENCES `mydb`.`mancare` (`STUDENT_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`transport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`transport` (
  `tip_transport` VARCHAR(45) NULL DEFAULT  NULL,
  `plata_transport` INT(11) NULL DEFAULT NULL,
  `data_t` DATETIME NULL DEFAULT NULL,
  `STUDENT_id` INT(11) NOT NULL,

  `situatie_scolara_STUDENT_id` INT(11) NOT NULL,
 # PRIMARY KEY (`STUDENT_id`, `situatie_scolara_id_semestru`, `situatie_scolara_STUDENT_id`),
  INDEX `fk_transport_situatie_scolara1_idx` (`situatie_scolara_STUDENT_id` ASC),
  CONSTRAINT `fk_transport_STUDENT1`
    FOREIGN KEY (`STUDENT_id`)
    REFERENCES `mydb`.`student` (`id`),
 
  CONSTRAINT `fk_transport_situatie_scolara1`
    FOREIGN KEY ( `situatie_scolara_STUDENT_id`)
    REFERENCES `mydb`.`situatie_scolara` (`STUDENT_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
