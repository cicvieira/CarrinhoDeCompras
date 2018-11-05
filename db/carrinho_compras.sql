-- MySQL Script generated by MySQL Workbench
-- Sun 04 Nov 2018 02:57:07 PM -02
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema carrinho_compras
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `cupom_descontos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cupom_descontos` ;

CREATE TABLE IF NOT EXISTS `cupom_descontos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NULL DEFAULT NULL,
  `localizador` VARCHAR(255) NULL DEFAULT NULL,
  `desconto` DECIMAL(6,2) NULL DEFAULT NULL,
  `modo_desconto` VARCHAR(10) NULL DEFAULT NULL,
  `limite` DECIMAL(6,2) NULL DEFAULT NULL,
  `modo_limite` ENUM('valor', 'qtd') NULL DEFAULT NULL,
  `dthr_validade` DATETIME NULL DEFAULT NULL,
  `ativo` ENUM('S', 'N') NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `password_resets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `password_resets` ;

CREATE TABLE IF NOT EXISTS `password_resets` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `token` VARCHAR(255) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `produtos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `produtos` ;

CREATE TABLE IF NOT EXISTS `produtos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NULL DEFAULT NULL,
  `descricao` TEXT NULL DEFAULT NULL,
  `valor` DECIMAL(6,2) NULL DEFAULT NULL,
  `imagem` VARCHAR(255) NULL DEFAULT NULL,
  `ativo` ENUM('S', 'N') NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `users` ;

CREATE TABLE IF NOT EXISTS `users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL COMMENT '\\n',
  `remember_token` VARCHAR(100) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `type` VARCHAR(45) NULL DEFAULT 'default',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pedidos` ;

CREATE TABLE IF NOT EXISTS `pedidos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(10) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pedidos_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_pedidos_users_idx` ON `pedidos` (`user_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `pedido_produtos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pedido_produtos` ;

CREATE TABLE IF NOT EXISTS `pedido_produtos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(10) NULL DEFAULT NULL,
  `valor` DECIMAL(6,2) NULL DEFAULT NULL,
  `desconto` DECIMAL(6,2) NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `produto_id` INT(11) NOT NULL,
  `pedido_id` INT(11) NOT NULL,
  `cupom_descontos_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_pedido_produtos_produtos1`
    FOREIGN KEY (`produto_id`)
    REFERENCES `produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_produtos_pedidos1`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `pedidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 41
DEFAULT CHARACTER SET = latin1;

CREATE INDEX `fk_pedido_produtos_produtos1_idx` ON `pedido_produtos` (`produto_id` ASC) VISIBLE;

CREATE INDEX `fk_pedido_produtos_pedidos1_idx` ON `pedido_produtos` (`pedido_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `categorias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `categorias` ;

CREATE TABLE IF NOT EXISTS `categorias` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `categoria` VARCHAR(255) NULL,
  `descricao` TEXT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `categorias_has_produtos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `categorias_has_produtos` ;

CREATE TABLE IF NOT EXISTS `categorias_has_produtos` (
  `categorias_id` INT(11) NOT NULL,
  `produtos_id` INT(11) NOT NULL,
  PRIMARY KEY (`categorias_id`, `produtos_id`),
  CONSTRAINT `fk_categorias_has_produtos_categorias1`
    FOREIGN KEY (`categorias_id`)
    REFERENCES `categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categorias_has_produtos_produtos1`
    FOREIGN KEY (`produtos_id`)
    REFERENCES `produtos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_categorias_has_produtos_produtos1_idx` ON `categorias_has_produtos` (`produtos_id` ASC) VISIBLE;

CREATE INDEX `fk_categorias_has_produtos_categorias1_idx` ON `categorias_has_produtos` (`categorias_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;