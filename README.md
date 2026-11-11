# Relational Database for Macroeconomic Data Analysis in Poland

## Overview

This project documents a relational MySQL database designed and implemented as part of a bachelor's thesis. It organises selected macroeconomic indicators for Poland and supports comparisons across indicators and quarterly periods.

The repository contains the thesis and its defence presentation, the supplied import dataset, a recreated entity–relationship diagram, and SQL scripts organised for easier review and reproduction.

## Database structure

The database contains five related tables:

| Table | Purpose |
|---|---|
| `countries` | Country identifiers and ISO codes. |
| `sources` | Institutions publishing the statistical data. |
| `indicators` | Indicator names, units, and their data sources. |
| `periods` | Quarterly time periods represented by year and quarter. |
| `macro_values` | Fact table containing indicator values and foreign keys to country, indicator, and period. |

The relationships are one-to-many: `sources` → `indicators`; and `countries`, `indicators`, and `periods` → `macro_values`. The fact table has a unique constraint on `(country_id, indicator_id, period_id)` to prevent duplicate observations.

![Entity–Relationship Diagram](diagrams/er_diagram.png)

The diagram is a clean redraw of the schema documented in the thesis.

## Data coverage

The thesis describes six indicators for Poland over 88 quarterly periods from 2004 Q1 to 2025 Q4 (528 indicator-period records):

- Inflation (`Inflacja`)
- GDP (`PKB`)
- Unemployment rate (`Stopa bezrobocia`)
- EUR/PLN exchange rate
- USD/PLN exchange rate
- NBP reference rate (`Stopa referencyjna NBP`)

The data sources are Statistics Poland (`GUS`) and the National Bank of Poland (`NBP`). The supplied CSV contains 528 rows, including 64 blank `value` fields. Blank values are retained as missing values and imported as SQL `NULL`, not converted to zero.

## SQL topics demonstrated

- Relational schema design, primary keys, foreign keys, and unique constraints
- CSV data import
- `JOIN`, `GROUP BY`, aggregate functions, and conditional aggregation with `CASE`
- Window functions with `LAG()` for quarter-to-quarter comparisons
- Summary statistics and selected-period comparisons

## Repository structure

```text
macroeconomic-database-sql/
├── README.md
├── data/
│   └── macro_values_import.csv
├── diagrams/
│   ├── er_diagram.png
│   ├── er_diagram.svg
│   └── er_diagram.dot
├── docs/
│   ├── bachelor_thesis.pdf
│   └── thesis_defense_presentation.pdf
└── sql/
    ├── 01_create_schema.sql
    ├── 02_insert_reference_data.sql
    ├── 03_import_macro_values.sql
    └── 04_analysis_queries.sql
```

## How to run

The scripts target MySQL 8.0 or later.

1. Run `sql/01_create_schema.sql` to create the database and tables.
2. Run `sql/02_insert_reference_data.sql` on the newly created, empty database. This inserts Poland, the two data sources, six indicators, and the 88 quarters. Explicit IDs are used because the supplied CSV refers to these IDs.
3. Open `sql/03_import_macro_values.sql`, replace the example file path with the location of `data/macro_values_import.csv` on your computer, and run the script. The import statement uses a semicolon delimiter and converts decimal commas to decimal points; blank values become `NULL`.
4. Run `sql/04_analysis_queries.sql` to explore the documented analytical queries.

`LOAD DATA LOCAL INFILE` may be disabled by the local MySQL or Workbench configuration. If the import statement is rejected, use MySQL Workbench's **Table Data Import Wizard** for `data/macro_values_import.csv`, map the four columns to `country_id`, `indicator_id`, `period_id`, and `value`, and make sure decimal commas are interpreted as decimal points. Do not run the import twice, because the fact table has a unique constraint on each country–indicator–period combination.

## Source and reproducibility note

The schema definitions and analytical query logic are reconstructed and organised from the SQL examples documented in the bachelor's thesis. They are provided as separate, readable scripts for portfolio review; they are not represented as the original exported MySQL Workbench project files. The thesis and defence presentation are in Polish.
