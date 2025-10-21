-- TaskTogether MySQL schema
CREATE TABLE IF NOT EXISTS `groups` (
  `id` VARCHAR(36) PRIMARY KEY,
  `name` VARCHAR(255) NOT NULL,
  `owner_id` VARCHAR(36) NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `projects` (
  `id` VARCHAR(36) PRIMARY KEY,
  `group_id` VARCHAR(36) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  CONSTRAINT `fk_projects_group` FOREIGN KEY (`group_id`) REFERENCES `groups`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `tasks` (
  `id` VARCHAR(36) PRIMARY KEY,
  `group_id` VARCHAR(36) NOT NULL,
  `project_id` VARCHAR(36) NULL,
  `name` VARCHAR(255) NOT NULL,
  `description` TEXT NULL,
  `assignee_id` VARCHAR(36) NULL,
  `status` ENUM('todo','progress','done') NOT NULL DEFAULT 'todo',
  `due_date` DATE NULL,
  CONSTRAINT `fk_tasks_group` FOREIGN KEY (`group_id`) REFERENCES `groups`(`id`) ON DELETE CASCADE,
  INDEX `idx_tasks_group` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
