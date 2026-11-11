
USE macroeconomics_db;

-- 1. Compare macroeconomic indicators: Q4 2025 vs Q4 2024.
SELECT
    i.indicator_name AS indicator,
    MAX(CASE WHEN p.year = 2025 AND p.quarter = 4
             THEN CONCAT(m.value, ' ', i.unit) END) AS Q4_2025,
    MAX(CASE WHEN p.year = 2024 AND p.quarter = 4
             THEN CONCAT(m.value, ' ', i.unit) END) AS Q4_2024,
    ROUND(
        MAX(CASE WHEN p.year = 2025 AND p.quarter = 4 THEN m.value END) -
        MAX(CASE WHEN p.year = 2024 AND p.quarter = 4 THEN m.value END),
        2
    ) AS absolute_change
FROM macro_values AS m
JOIN indicators AS i ON m.indicator_id = i.indicator_id
JOIN periods AS p ON m.period_id = p.period_id
WHERE (p.year = 2024 AND p.quarter = 4)
   OR (p.year = 2025 AND p.quarter = 4)
GROUP BY i.indicator_name
ORDER BY i.indicator_name;

-- 2. Average value of each indicator over the available observation period.
SELECT
    i.indicator_name AS indicator,
    CONCAT(ROUND(AVG(m.value), 2), ' ', i.unit) AS average_value
FROM macro_values AS m
JOIN indicators AS i ON m.indicator_id = i.indicator_id
GROUP BY i.indicator_name, i.unit
ORDER BY i.indicator_name;

-- 3. Quarterly GDP indicator changes from 2021 through 2023.
SELECT
    p.year,
    p.quarter,
    CONCAT(m.value, ' ', i.unit) AS gdp_indicator_value,
    ROUND(
        m.value - LAG(m.value) OVER (ORDER BY p.year, p.quarter),
        2
    ) AS change_from_previous_quarter
FROM macro_values AS m
JOIN indicators AS i ON m.indicator_id = i.indicator_id
JOIN periods AS p ON m.period_id = p.period_id
WHERE i.indicator_name = 'PKB'
  AND p.year BETWEEN 2021 AND 2023
ORDER BY p.year, p.quarter;

-- 4. Quarterly inflation indicator changes from 2021 through 2025.
SELECT
    p.year,
    p.quarter,
    CONCAT(m.value, ' ', i.unit) AS inflation_indicator_value,
    ROUND(
        m.value - LAG(m.value) OVER (ORDER BY p.year, p.quarter),
        2
    ) AS change_from_previous_quarter
FROM macro_values AS m
JOIN indicators AS i ON m.indicator_id = i.indicator_id
JOIN periods AS p ON m.period_id = p.period_id
WHERE i.indicator_name = 'Inflacja'
  AND p.year BETWEEN 2021 AND 2025
ORDER BY p.year, p.quarter;

-- 5. Compare selected macroeconomic indicators across selected quarters.
SELECT
    p.year,
    p.quarter,
    ROUND(AVG(CASE WHEN i.indicator_name = 'Inflacja' THEN m.value END), 2) AS inflation,
    ROUND(AVG(CASE WHEN i.indicator_name = 'PKB' THEN m.value END), 2) AS gdp,
    ROUND(AVG(CASE WHEN i.indicator_name = 'Stopa bezrobocia' THEN m.value END), 2) AS unemployment,
    ROUND(AVG(CASE WHEN i.indicator_name = 'EUR/PLN' THEN m.value END), 2) AS eur_pln,
    ROUND(AVG(CASE WHEN i.indicator_name = 'USD/PLN' THEN m.value END), 2) AS usd_pln,
    ROUND(AVG(CASE WHEN i.indicator_name = 'Stopa referencyjna NBP' THEN m.value END), 2) AS nbp_reference_rate
FROM macro_values AS m
JOIN indicators AS i ON m.indicator_id = i.indicator_id
JOIN periods AS p ON m.period_id = p.period_id
WHERE (p.year = 2021 AND p.quarter = 1)
   OR (p.year = 2022 AND p.quarter = 4)
   OR (p.year = 2023 AND p.quarter = 2)
   OR (p.year = 2024 AND p.quarter = 4)
   OR (p.year = 2025 AND p.quarter = 4)
GROUP BY p.year, p.quarter
ORDER BY p.year, p.quarter;

-- 6. Data-quality checks (additional repository checks).
SELECT COUNT(*) AS observation_rows,
       COUNT(DISTINCT country_id, indicator_id, period_id) AS unique_observations,
       SUM(value IS NULL) AS missing_values
FROM macro_values;

SELECT i.indicator_name, COUNT(*) AS rows_per_indicator,
       SUM(m.value IS NULL) AS missing_values
FROM macro_values AS m
JOIN indicators AS i ON m.indicator_id = i.indicator_id
GROUP BY i.indicator_name, i.indicator_id
ORDER BY i.indicator_id;
