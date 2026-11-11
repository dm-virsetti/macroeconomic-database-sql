
USE macroeconomics_db;

LOAD DATA LOCAL INFILE 'C:/path/to/macro_values_import.csv'
INTO TABLE macro_values
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(country_id, indicator_id, period_id, @raw_value)
SET value = NULLIF(REPLACE(TRIM(@raw_value), ',', '.'), '');

-- The supplied file contains 528 observations, including blank values
-- that are imported as SQL NULLs. Do not replace missing values with zero.
SELECT COUNT(*) AS imported_rows,
       SUM(value IS NULL) AS missing_values
FROM macro_values;
