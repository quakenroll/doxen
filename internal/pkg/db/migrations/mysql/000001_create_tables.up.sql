/*CREATE TABLE `failed_jobs`(
    `id` BIGINT NOT NULL,
    `connection` TEXT NOT NULL,
    `queue` TEXT NOT NULL,
    `payload` LONGTEXT NOT NULL,
    `exception` LONGTEXT NOT NULL,
    `failed_at` TIMESTAMP NOT NULL
);
ALTER TABLE
    `failed_jobs` ADD PRIMARY KEY `failed_jobs_id_primary`(`id`);
CREATE TABLE `article_likes`(
    `id` INT NOT NULL,
    `user_id` INT NOT NULL,
    `article_id` INT NOT NULL,
    `likeable_type` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NULL,
    `updated_at` TIMESTAMP NULL
);
ALTER TABLE
    `article_likes` ADD PRIMARY KEY `article_likes_id_primary`(`id`);
CREATE TABLE `migrations`(
    `id` INT NOT NULL,
    `migration` VARCHAR(255) NOT NULL,
    `batch` INT NOT NULL
);
ALTER TABLE
    `migrations` ADD PRIMARY KEY `migrations_id_primary`(`id`);
CREATE TABLE `notifications`(
    `id` CHAR(255) NOT NULL,
    `type` VARCHAR(255) NOT NULL,
    `notifiable_type` VARCHAR(255) NOT NULL,
    `notifiable_id` INT NOT NULL,
    `data` TEXT NOT NULL,
    `read_at` TIMESTAMP NULL,
    `created_at` TIMESTAMP NULL,
    `updated_at` TIMESTAMP NULL
);
ALTER TABLE
    `notifications` ADD INDEX `notifications_notifiable_type_notifiable_id_index`(`notifiable_type`, `notifiable_id`);
ALTER TABLE
    `notifications` ADD PRIMARY KEY `notifications_id_primary`(`id`);
CREATE TABLE `password_resets`(
    `email` VARCHAR(255) NOT NULL,
    `token` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NULL
);
ALTER TABLE
    `password_resets` ADD INDEX `password_resets_email_index`(`email`);
CREATE TABLE `comments`(
    `id` INT NOT NULL,
    `body` TEXT NOT NULL,
    `author_id` INT NOT NULL,
    `created_at` DATETIME NULL,
    `updated_at` DATETIME NULL,
    `thread_id` INT NOT NULL
);
ALTER TABLE
    `comments` ADD PRIMARY KEY `comments_id_primary`(`id`);
ALTER TABLE
    `comments` ADD INDEX `comments_author_id_index`(`author_id`);
ALTER TABLE
    `comments` ADD INDEX `comments_thread_id_index`(`thread_id`);
CREATE TABLE `subscriptions`(
    `uuid` CHAR(255) NOT NULL,
    `user_id` INT NOT NULL,
    `subscriptionable_id` INT NOT NULL,
    `subscriptionable_type` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NULL,
    `updated_at` TIMESTAMP NULL
);
ALTER TABLE
    `subscriptions` ADD UNIQUE `subscriptions_unique_keys`(
        `user_id`,
        `subscriptionable_id`,
        `subscriptionable_type`
    );
ALTER TABLE
    `subscriptions` ADD PRIMARY KEY `subscriptions_uuid_primary`(`uuid`);
ALTER TABLE
    `subscriptions` ADD INDEX `subscriptions_user_id_index`(`user_id`);
CREATE TABLE `taggables`(
    `id` INT NOT NULL,
    `taggable_id` INT NOT NULL,
    `tag_id` INT NOT NULL,
    `created_at` DATETIME NULL,
    `updated_at` DATETIME NULL,
    `taggable_type` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `taggables` ADD PRIMARY KEY `taggables_id_primary`(`id`);
ALTER TABLE
    `taggables` ADD INDEX `taggables_taggable_id_index`(`taggable_id`);
ALTER TABLE
    `taggables` ADD INDEX `taggables_tag_id_index`(`tag_id`);
CREATE TABLE `tags`(
    `id` INT NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `slug` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `tags` ADD PRIMARY KEY `tags_id_primary`(`id`);
ALTER TABLE
    `tags` ADD UNIQUE `tags_name_unique`(`name`);
ALTER TABLE
    `tags` ADD UNIQUE `tags_slug_unique`(`slug`);
CREATE TABLE `article`(
    `id` INT NOT NULL,
    `author_id` INT NOT NULL,
    `subject` VARCHAR(255) NOT NULL,
    `body` TEXT NOT NULL,
    `slug` VARCHAR(255) NOT NULL,
    `created_at` DATETIME NULL,
    `updated_at` DATETIME NULL
);
ALTER TABLE
    `article` ADD PRIMARY KEY `article_id_primary`(`id`);
ALTER TABLE
    `article` ADD INDEX `article_author_id_index`(`author_id`);
ALTER TABLE
    `article` ADD UNIQUE `article_slug_unique`(`slug`);
CREATE TABLE `users`(
    `id` INT NOT NULL,
    `github_id` VARCHAR(255) NOT NULL,
    `github_username` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `created_at` DATETIME NULL,
    `updated_at` DATETIME NULL,
    `remember_token` VARCHAR(255) NOT NULL,
    `confirmed` TINYINT NOT NULL,
    `confirmation_code` VARCHAR(255) NULL,
    `username` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `type` SMALLINT NOT NULL,
    `bio` VARCHAR(255) NOT NULL,
    `banned_at` DATETIME NULL
);
ALTER TABLE
    `users` ADD PRIMARY KEY `users_id_primary`(`id`);
ALTER TABLE
    `users` ADD UNIQUE `users_email_unique`(`email`);
ALTER TABLE
    `users` ADD UNIQUE `users_username_unique`(`username`);
CREATE TABLE `comment_likes`(
    `id` INT NOT NULL,
    `user_id` INT NOT NULL,
    `comment_id` INT NOT NULL,
    `likeable_type` VARCHAR(255) NOT NULL,
    `created_at` DATETIME NOT NULL,
    `updated_at` DATETIME NOT NULL
);
ALTER TABLE
    `comment_likes` ADD PRIMARY KEY `comment_likes_id_primary`(`id`);
ALTER TABLE
    `article_likes` ADD CONSTRAINT `article_likes_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `comments` ADD CONSTRAINT `comments_author_id_foreign` FOREIGN KEY(`author_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `comments` ADD CONSTRAINT `comments_thread_id_foreign` FOREIGN KEY(`thread_id`) REFERENCES `article`(`id`);
ALTER TABLE
    `subscriptions` ADD CONSTRAINT `subscriptions_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `taggables` ADD CONSTRAINT `taggables_tag_id_foreign` FOREIGN KEY(`tag_id`) REFERENCES `tags`(`id`);
ALTER TABLE
    `article_likes` ADD CONSTRAINT `article_likes_article_id_foreign` FOREIGN KEY(`article_id`) REFERENCES `article`(`id`);
ALTER TABLE
    `taggables` ADD CONSTRAINT `taggables_taggable_id_foreign` FOREIGN KEY(`taggable_id`) REFERENCES `article`(`id`);
ALTER TABLE
    `article` ADD CONSTRAINT `article_author_id_foreign` FOREIGN KEY(`author_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `notifications` ADD CONSTRAINT `notifications_notifiable_id_foreign` FOREIGN KEY(`notifiable_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `comment_likes` ADD CONSTRAINT `comment_likes_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `comment_likes` ADD CONSTRAINT `comment_likes_comment_id_foreign` FOREIGN KEY(`comment_id`) REFERENCES `comments`(`id`);
    */

    -- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema doxen
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema doxen
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `doxen` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `doxen` ;

-- -----------------------------------------------------
-- Table `doxen`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doxen`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `github_id` VARCHAR(255) NOT NULL,
  `github_username` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `remember_token` VARCHAR(255) NOT NULL,
  `confirmed` TINYINT NOT NULL,
  `confirmation_code` VARCHAR(255) NULL DEFAULT NULL,
  `username` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `type` SMALLINT NOT NULL,
  `bio` VARCHAR(255) NOT NULL,
  `banned_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `users_email_unique` (`email` ASC) VISIBLE,
  UNIQUE INDEX `users_username_unique` (`username` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doxen`.`article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doxen`.`article` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `author_id` INT NOT NULL,
  `subject` VARCHAR(255) NOT NULL,
  `body` TEXT NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `article_slug_unique` (`slug` ASC) VISIBLE,
  INDEX `article_author_id_index` (`author_id` ASC) VISIBLE,
  CONSTRAINT `article_author_id_foreign`
    FOREIGN KEY (`author_id`)
    REFERENCES `doxen`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doxen`.`article_likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doxen`.`article_likes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `article_id` INT NOT NULL,
  `likeable_type` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `article_likes_user_id_foreign` (`user_id` ASC) VISIBLE,
  INDEX `article_likes_article_id_foreign` (`article_id` ASC) VISIBLE,
  CONSTRAINT `article_likes_article_id_foreign`
    FOREIGN KEY (`article_id`)
    REFERENCES `doxen`.`article` (`id`),
  CONSTRAINT `article_likes_user_id_foreign`
    FOREIGN KEY (`user_id`)
    REFERENCES `doxen`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doxen`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doxen`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `body` TEXT NOT NULL,
  `author_id` INT NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `thread_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `comments_author_id_index` (`author_id` ASC) VISIBLE,
  INDEX `comments_thread_id_index` (`thread_id` ASC) VISIBLE,
  CONSTRAINT `comments_author_id_foreign`
    FOREIGN KEY (`author_id`)
    REFERENCES `doxen`.`users` (`id`),
  CONSTRAINT `comments_thread_id_foreign`
    FOREIGN KEY (`thread_id`)
    REFERENCES `doxen`.`article` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doxen`.`comment_likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doxen`.`comment_likes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `comment_id` INT NOT NULL,
  `likeable_type` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `comment_likes_user_id_foreign` (`user_id` ASC) VISIBLE,
  INDEX `comment_likes_comment_id_foreign` (`comment_id` ASC) VISIBLE,
  CONSTRAINT `comment_likes_comment_id_foreign`
    FOREIGN KEY (`comment_id`)
    REFERENCES `doxen`.`comments` (`id`),
  CONSTRAINT `comment_likes_user_id_foreign`
    FOREIGN KEY (`user_id`)
    REFERENCES `doxen`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doxen`.`failed_jobs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doxen`.`failed_jobs` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `connection` TEXT NOT NULL,
  `queue` TEXT NOT NULL,
  `payload` LONGTEXT NOT NULL,
  `exception` LONGTEXT NOT NULL,
  `failed_at` TIMESTAMP NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doxen`.`migrations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doxen`.`migrations` (
  `id` INT NOT NULL,
  `migration` VARCHAR(255) NOT NULL,
  `batch` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doxen`.`notifications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doxen`.`notifications` (
  `id` CHAR(255) NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `notifiable_type` VARCHAR(255) NOT NULL,
  `notifiable_id` INT NOT NULL,
  `data` TEXT NOT NULL,
  `read_at` TIMESTAMP NULL DEFAULT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `notifications_notifiable_type_notifiable_id_index` (`notifiable_type` ASC, `notifiable_id` ASC) VISIBLE,
  INDEX `notifications_notifiable_id_foreign` (`notifiable_id` ASC) VISIBLE,
  CONSTRAINT `notifications_notifiable_id_foreign`
    FOREIGN KEY (`notifiable_id`)
    REFERENCES `doxen`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doxen`.`password_resets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doxen`.`password_resets` (
  `email` VARCHAR(255) NOT NULL,
  `token` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  INDEX `password_resets_email_index` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doxen`.`schema_migrations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doxen`.`schema_migrations` (
  `version` BIGINT NOT NULL,
  `dirty` TINYINT(1) NOT NULL,
  PRIMARY KEY (`version`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doxen`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doxen`.`subscriptions` (
  `uuid` CHAR(255) NOT NULL,
  `user_id` INT NOT NULL,
  `subscriptionable_id` INT NOT NULL,
  `subscriptionable_type` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT NULL,
  `updated_at` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`uuid`),
  UNIQUE INDEX `subscriptions_unique_keys` (`user_id` ASC, `subscriptionable_id` ASC, `subscriptionable_type` ASC) VISIBLE,
  INDEX `subscriptions_user_id_index` (`user_id` ASC) VISIBLE,
  CONSTRAINT `subscriptions_user_id_foreign`
    FOREIGN KEY (`user_id`)
    REFERENCES `doxen`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doxen`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doxen`.`tags` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `tags_name_unique` (`name` ASC) VISIBLE,
  UNIQUE INDEX `tags_slug_unique` (`slug` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `doxen`.`taggables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `doxen`.`taggables` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `taggable_id` INT NOT NULL,
  `tag_id` INT NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `taggable_type` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `taggables_taggable_id_index` (`taggable_id` ASC) VISIBLE,
  INDEX `taggables_tag_id_index` (`tag_id` ASC) VISIBLE,
  CONSTRAINT `taggables_tag_id_foreign`
    FOREIGN KEY (`tag_id`)
    REFERENCES `doxen`.`tags` (`id`),
  CONSTRAINT `taggables_taggable_id_foreign`
    FOREIGN KEY (`taggable_id`)
    REFERENCES `doxen`.`article` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;