-- 1. Compare indicators: Q4 2025 vs Q4 2024
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
    ) AS change
FROM macro_values m
JOIN indicators i ON m.indicator_id = i.indicator_id
JOIN periods p ON m.period_id = p.period_id
WHERE (p.year = 2024 AND p.quarter = 4)
   OR (p.year = 2025 AND p.quarter = 4)
GROUP BY i.indicator_name;


-- 2. Average values of indicators
SELECT
    i.indicator_name AS indicator,
    CONCAT(ROUND(AVG(m.value), 2), ' ', i.unit) AS average_value
FROM macro_values m
JOIN indicators i ON m.indicator_id = i.indicator_id
GROUP BY i.indicator_name, i.unit;


-- 3. GDP changes, 2021–2023
SELECT
    p.year AS year,
    p.quarter AS quarter,
    CONCAT(m.value, ' ', i.unit) AS gdp_value,
    ROUND(m.value - LAG(m.value) OVER (ORDER BY p.year, p.quarter), 2)
        AS change_from_previous_quarter
FROM macro_values m
JOIN indicators i ON m.indicator_id = i.indicator_id
JOIN periods p ON m.period_id = p.period_id
WHERE i.indicator_name = 'PKB'
  AND p.year BETWEEN 2021 AND 2023
ORDER BY p.year, p.quarter;


-- 4. Inflation changes, 2021–2025
SELECT
    p.year AS year,
    p.quarter AS quarter,
    CONCAT(m.value, ' ', i.unit) AS inflation,
    ROUND(m.value - LAG(m.value) OVER (ORDER BY p.year, p.quarter), 2)
        AS change_from_previous_quarter
FROM macro_values m
JOIN indicators i ON m.indicator_id = i.indicator_id
JOIN periods p ON m.period_id = p.period_id
WHERE i.indicator_name = 'Inflacja'
  AND p.year BETWEEN 2021 AND 2025
ORDER BY p.year, p.quarter;


-- 5. Selected macroeconomic indicators across key periods
SELECT
    p.year AS year,
    p.quarter AS quarter,
    ROUND(AVG(CASE WHEN i.indicator_name = 'Inflacja' THEN m.value END), 2) AS inflation,
    ROUND(AVG(CASE WHEN i.indicator_name = 'PKB' THEN m.value END), 2) AS GDP,
    ROUND(AVG(CASE WHEN i.indicator_name = 'Stopa bezrobocia' THEN m.value END), 2) AS unemployment,
    ROUND(AVG(CASE WHEN i.indicator_name = 'EUR/PLN' THEN m.value END), 2) AS EUR_PLN,
    ROUND(AVG(CASE WHEN i.indicator_name = 'USD/PLN' THEN m.value END), 2) AS USD_PLN,
    ROUND(AVG(CASE WHEN i.indicator_name = 'Stopa referencyjna NBP' THEN m.value END), 2) AS NBP_rate
FROM macro_values m
JOIN indicators i ON m.indicator_id = i.indicator_id
JOIN periods p ON m.period_id = p.period_id
WHERE (p.year = 2021 AND p.quarter = 1)
   OR (p.year = 2022 AND p.quarter = 4)
   OR (p.year = 2023 AND p.quarter = 2)
   OR (p.year = 2024 AND p.quarter = 4)
   OR (p.year = 2025 AND p.quarter = 4)
GROUP BY p.year, p.quarter
ORDER BY p.year, p.quarter;
