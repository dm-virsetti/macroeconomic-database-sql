# Relational Database for Macroeconomic Data Analysis in Poland

A MySQL database project developed as part of a bachelor's thesis at SGH. It stores selected macroeconomic indicators for Poland and supports comparisons across indicators and quarterly periods.

## Database structure

The database contains five related tables: `countries`, `sources`, `indicators`, `periods`, and `macro_values`. The schema uses primary keys, foreign keys, unique constraints, and a fact table for indicator values.

## Data

The database contains six indicators across 88 quarterly periods from 2004 Q1 to 2025 Q4 (528 indicator-period records). Sources include Statistics Poland (GUS) and the National Bank of Poland (NBP). Missing values are kept as `NULL`.

## SQL files

- [`sql/01_database_schema_and_data.sql`](sql/01_database_schema_and_data.sql) — clean SQL version of the MySQL Workbench export, including table definitions and the original records.
- [`sql/02_analysis_queries.sql`](sql/02_analysis_queries.sql) — analytical queries based on the examples presented in the thesis.

## Documentation

- [`docs/bachelor_thesis.pdf`](docs/bachelor_thesis.pdf) — full bachelor's thesis (Polish).
- [`docs/thesis_defense_presentation.pdf`](docs/thesis_defense_presentation.pdf) — thesis-defence presentation (Polish).
- [`diagrams/er_diagram.png`](diagrams/er_diagram.png) — entity-relationship diagram.

## Tools

MySQL 8.0 and MySQL Workbench.
