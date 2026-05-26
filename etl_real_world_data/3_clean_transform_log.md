# Week 3 – Day 3: Data Cleaning & Type Conversion

## Goal
Transform raw staging data (all TEXT) into a clean, typed table for analysis:
- convert dates → TIMESTAMP
- convert IDs/zip → numeric types (where possible)
- trim/standardize text
- filter out obviously invalid rows

---

## Tools Used
- PostgreSQL (local)
- `psql` (command line)
- SQL script file (batch run)

---

## Input / Output

### Source (raw staging)
- **Table:** `raw.stg_nyc_311`
- **Data type:** all columns are `TEXT`

### Target (clean table)
- **Schema:** `clean`
- **Table:** `clean.nyc_311_clean`

---

## Steps Completed

### Clean Schema Setup
- Ensured the `clean` schema exists to separate typed, analysis-ready tables from raw staging data.

### Transform Rules Applied
- Converted date strings to `TIMESTAMP`:
  - `created_date` → `created_ts`
  - `closed_date` → `closed_ts`
- Converted numeric fields where valid:
  - `unique_key` → `BIGINT`
  - `incident_zip` → `INTEGER`
  - `latitude`, `longitude` → `NUMERIC`
- Normalized text fields:
  - Trimmed leading/trailing whitespace
  - Converted empty strings (`''`) to `NULL`
- Standardized casing for categorical fields where applicable

### Filtering Logic
- Excluded rows where:
  - `unique_key` is missing or empty
  - `created_ts` could not be parsed into a valid timestamp

### Filtering Logic
- Excluded rows where:
  - `unique_key` is missing or empty
  - `created_ts` could not be parsed into a valid timestamp

These filters ensure each row represents a valid, traceable service request.

### Verification & Data Quality Checks
- Row count comparison:
  - `raw.stg_nyc_311` vs `clean.nyc_311_clean`
- Missing key checks:
  - Count of rows with missing `unique_key`
  - Count of rows with missing `created_ts`
- Geographic sanity checks:
  - Latitude must be between `-90` and `90`
  - Longitude must be between `-180` and `180`

Verification queries are included at the bottom of  
`sql/03_clean_transform.sql`.

### Result
- Clean table created: `clean.nyc_311_clean`
- Data is fully typed, normalized, and ready for analytical queries
- Clean table will be used as the source for Day 4 aggregations

### Notes / Limitations
- ZIP codes are stored as integers; leading zeros may be lost
- Date parsing assumes consistent NYC Open Data timestamp format
- Further normalization (agency dimension, complaint categories) deferred to later stages

