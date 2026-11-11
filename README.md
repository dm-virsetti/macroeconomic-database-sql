# Relational Database for Macroeconomic Data Analysis in Poland

## Overview

Bachelor thesis project focused on designing and implementing a relational database in MySQL to organise and analyse selected macroeconomic indicators for Poland. The accompanying thesis-defence presentation is also included. Both source documents are in Polish.

## Database design

The database is organised into five related tables:

- `countries`
- `sources`
- `indicators`
- `periods`
- `macro_values`

The fact table stores indicator values and links to the country, indicator, and time-period dimensions through foreign keys. A unique constraint on the country–indicator–period combination helps prevent duplicate observations. The thesis describes the relational structure and its normalisation.

## Data coverage

The implementation described in the thesis contains six indicators for Poland across 88 quarterly periods from 2004 to 2025, giving 528 indicator-period records. The indicators include GDP, inflation, unemployment, EUR/PLN, USD/PLN, and the NBP reference rate. Data sources include Statistics Poland (GUS) and the National Bank of Poland (NBP).

## SQL topics demonstrated

The thesis documents table creation, primary and foreign keys, CSV import, joins, aggregation, grouping, conditional logic, and time-based comparisons.

## Files

- [`docs/bachelor_thesis.pdf`](docs/bachelor_thesis.pdf) — full bachelor thesis (Polish).
- [`docs/thesis_defense_presentation.pdf`](docs/thesis_defense_presentation.pdf) — thesis-defence presentation (Polish).

## Source-code note

The SQL statements and query examples are included in the thesis document. A separate original `.sql` script was not among the files supplied for this package, so no standalone SQL script has been fabricated. If the original Workbench scripts are available locally, add them under a new `sql/` folder.
