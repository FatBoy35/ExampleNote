CREATE DATABASE IF NOT EXISTS java_note CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE java_note;

CREATE TABLE IF NOT EXISTS languages (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) NOT NULL,
    description LONGTEXT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    enabled TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_languages_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS modules (
    id BIGINT NOT NULL AUTO_INCREMENT,
    language_id BIGINT NOT NULL,
    name VARCHAR(150) NOT NULL,
    slug VARCHAR(150) NOT NULL,
    description LONGTEXT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    enabled TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_modules_slug (slug),
    KEY idx_modules_language_id (language_id),
    KEY idx_modules_sort_order (sort_order),
    CONSTRAINT fk_modules_language FOREIGN KEY (language_id) REFERENCES languages (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS tags (
    id BIGINT NOT NULL AUTO_INCREMENT,
    name VARCHAR(80) NOT NULL,
    slug VARCHAR(80) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_tags_slug (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS knowledge_points (
    id BIGINT NOT NULL AUTO_INCREMENT,
    module_id BIGINT NOT NULL,
    title VARCHAR(200) NOT NULL,
    summary VARCHAR(500) NULL,
    content_markdown LONGTEXT NULL,
    difficulty VARCHAR(30) NOT NULL DEFAULT 'BEGINNER',
    sort_order INT NOT NULL DEFAULT 0,
    enabled TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_knowledge_module_id (module_id),
    KEY idx_knowledge_sort_order (sort_order),
    CONSTRAINT fk_knowledge_module FOREIGN KEY (module_id) REFERENCES modules (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS knowledge_point_tags (
    knowledge_point_id BIGINT NOT NULL,
    tag_id BIGINT NOT NULL,
    PRIMARY KEY (knowledge_point_id, tag_id),
    KEY idx_kptag_tag_id (tag_id),
    CONSTRAINT fk_kptag_point FOREIGN KEY (knowledge_point_id) REFERENCES knowledge_points (id) ON DELETE CASCADE,
    CONSTRAINT fk_kptag_tag FOREIGN KEY (tag_id) REFERENCES tags (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS code_examples (
    id BIGINT NOT NULL AUTO_INCREMENT,
    knowledge_point_id BIGINT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description LONGTEXT NULL,
    code LONGTEXT NOT NULL,
    language VARCHAR(50) NOT NULL DEFAULT 'Java',
    expected_output LONGTEXT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    enabled TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_examples_point_id (knowledge_point_id),
    CONSTRAINT fk_examples_point FOREIGN KEY (knowledge_point_id) REFERENCES knowledge_points (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS admin_users (
    id BIGINT NOT NULL AUTO_INCREMENT,
    username VARCHAR(80) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    nickname VARCHAR(80) NOT NULL,
    role VARCHAR(30) NOT NULL DEFAULT 'ADMIN',
    enabled TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_admin_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS run_logs (
    id BIGINT NOT NULL AUTO_INCREMENT,
    example_id BIGINT NULL,
    user_name VARCHAR(80) NULL DEFAULT 'guest',
    code_hash VARCHAR(128) NULL,
    success TINYINT(1) NOT NULL DEFAULT 0,
    output LONGTEXT NULL,
    error_message LONGTEXT NULL,
    execution_time_ms BIGINT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_run_logs_example_id (example_id),
    CONSTRAINT fk_run_logs_example FOREIGN KEY (example_id) REFERENCES code_examples (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
