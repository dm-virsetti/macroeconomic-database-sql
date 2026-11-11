

CREATE DATABASE IF NOT EXISTS macroeconomics_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE macroeconomics_db;

CREATE TABLE IF NOT EXISTS countries (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL,
    iso_code VARCHAR(5) NOT NULL UNIQUE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS sources (
    source_id INT AUTO_INCREMENT PRIMARY KEY,
    source_name VARCHAR(100) NOT NULL UNIQUE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS indicators (
    indicator_id INT AUTO_INCREMENT PRIMARY KEY,
    indicator_name VARCHAR(100) NOT NULL,
    unit VARCHAR(20) NOT NULL,
    source_id INT NOT NULL,
    CONSTRAINT fk_indicators_source
        FOREIGN KEY (source_id) REFERENCES sources(source_id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS periods (
    period_id INT AUTO_INCREMENT PRIMARY KEY,
    year INT NOT NULL,
    quarter TINYINT NOT NULL,
    CONSTRAINT chk_periods_quarter CHECK (quarter IN (1, 2, 3, 4)),
    CONSTRAINT uq_periods_year_quarter UNIQUE (year, quarter)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS macro_values (
    value_id INT AUTO_INCREMENT PRIMARY KEY,
    country_id INT NOT NULL,
    indicator_id INT NOT NULL,
    period_id INT NOT NULL,
    value DECIMAL(12,4),
    CONSTRAINT fk_macro_values_country
        FOREIGN KEY (country_id) REFERENCES countries(country_id),
    CONSTRAINT fk_macro_values_indicator
        FOREIGN KEY (indicator_id) REFERENCES indicators(indicator_id),
    CONSTRAINT fk_macro_values_period
        FOREIGN KEY (period_id) REFERENCES periods(period_id),
    CONSTRAINT uq_macro_values_observation
        UNIQUE (country_id, indicator_id, period_id)
) ENGINE = InnoDB;
