-- Run inside psql after connecting to the db:
-- \c nyc_311

TRUNCATE TABLE raw.stg_nyc_311;

\copy raw.stg_nyc_311
FROM 'C:/Users/Administrator/Documents/OneDrive - Personal (copied May 13 2026)/Data Analysis 2026/sql-postgresql-career-prep/3_etl_real_world_data/data/raw/311_Dec_2025_subset.csv'
WITH (FORMAT csv, HEADER true);

-- Quick verification
SELECT COUNT(*) AS row_count FROM raw.stg_nyc_311;

SELECT
  COUNT(*) FILTER (WHERE unique_key IS NULL OR unique_key = '')   AS missing_unique_key,
  COUNT(*) FILTER (WHERE created_date IS NULL OR created_date = '') AS missing_created_date
FROM raw.stg_nyc_311;
