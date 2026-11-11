
USE macroeconomics_db;

INSERT INTO countries (country_id, country_name, iso_code) VALUES
    (1, 'Poland', 'PL');

INSERT INTO sources (source_id, source_name) VALUES
    (1, 'GUS'),
    (2, 'NBP');

INSERT INTO indicators (indicator_id, indicator_name, unit, source_id) VALUES
    (1, 'Inflacja', '%', 1),
    (2, 'PKB', '%', 1),
    (3, 'Stopa bezrobocia', '%', 1),
    (4, 'EUR/PLN', 'PLN', 2),
    (5, 'USD/PLN', 'PLN', 2),
    (6, 'Stopa referencyjna NBP', '%', 2);

-- 88 quarterly periods, from 2004 Q1 through 2025 Q4.
-- The chronological insertion order keeps period_id aligned with the supplied CSV.
INSERT INTO periods (period_id, year, quarter) VALUES
    (1, 2004, 1),
    (2, 2004, 2),
    (3, 2004, 3),
    (4, 2004, 4),
    (5, 2005, 1),
    (6, 2005, 2),
    (7, 2005, 3),
    (8, 2005, 4),
    (9, 2006, 1),
    (10, 2006, 2),
    (11, 2006, 3),
    (12, 2006, 4),
    (13, 2007, 1),
    (14, 2007, 2),
    (15, 2007, 3),
    (16, 2007, 4),
    (17, 2008, 1),
    (18, 2008, 2),
    (19, 2008, 3),
    (20, 2008, 4),
    (21, 2009, 1),
    (22, 2009, 2),
    (23, 2009, 3),
    (24, 2009, 4),
    (25, 2010, 1),
    (26, 2010, 2),
    (27, 2010, 3),
    (28, 2010, 4),
    (29, 2011, 1),
    (30, 2011, 2),
    (31, 2011, 3),
    (32, 2011, 4),
    (33, 2012, 1),
    (34, 2012, 2),
    (35, 2012, 3),
    (36, 2012, 4),
    (37, 2013, 1),
    (38, 2013, 2),
    (39, 2013, 3),
    (40, 2013, 4),
    (41, 2014, 1),
    (42, 2014, 2),
    (43, 2014, 3),
    (44, 2014, 4),
    (45, 2015, 1),
    (46, 2015, 2),
    (47, 2015, 3),
    (48, 2015, 4),
    (49, 2016, 1),
    (50, 2016, 2),
    (51, 2016, 3),
    (52, 2016, 4),
    (53, 2017, 1),
    (54, 2017, 2),
    (55, 2017, 3),
    (56, 2017, 4),
    (57, 2018, 1),
    (58, 2018, 2),
    (59, 2018, 3),
    (60, 2018, 4),
    (61, 2019, 1),
    (62, 2019, 2),
    (63, 2019, 3),
    (64, 2019, 4),
    (65, 2020, 1),
    (66, 2020, 2),
    (67, 2020, 3),
    (68, 2020, 4),
    (69, 2021, 1),
    (70, 2021, 2),
    (71, 2021, 3),
    (72, 2021, 4),
    (73, 2022, 1),
    (74, 2022, 2),
    (75, 2022, 3),
    (76, 2022, 4),
    (77, 2023, 1),
    (78, 2023, 2),
    (79, 2023, 3),
    (80, 2023, 4),
    (81, 2024, 1),
    (82, 2024, 2),
    (83, 2024, 3),
    (84, 2024, 4),
    (85, 2025, 1),
    (86, 2025, 2),
    (87, 2025, 3),
    (88, 2025, 4);

-- Verify the reference data and the period-ID mapping.
SELECT * FROM countries;
SELECT * FROM sources;
SELECT * FROM indicators ORDER BY indicator_id;
SELECT * FROM periods ORDER BY period_id LIMIT 5;
SELECT * FROM periods ORDER BY period_id DESC LIMIT 5;
