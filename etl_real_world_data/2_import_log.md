# Staging Table + Raw Import (NYC 311)

## Dataset
- Source: NYC Open Data — 311 Service Requests
- File: `data/raw/311_Dec_2025_subset.csv`
- Date range: Dec 2025
- Rows imported: 340,394

## What I did
- Created database: `nyc_311`
- Created schema: `raw`
- Created staging table: `raw.stg_nyc_311` (all TEXT)
- Imported CSV using `psql \copy`
- Verified import with row count + missing checks

## Quick checks
- `missing_unique_key = 0`
- `missing_created_date = 0`

## Files added
- `sql/01_create_staging_table.sql`
- `sql/02_import_raw_data.sql`
- `python/subset_csv.py`
