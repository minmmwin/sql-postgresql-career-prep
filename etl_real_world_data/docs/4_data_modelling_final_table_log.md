# Week 3 – Day 4: Data Modeling & Keys

## Goal
Design a simple analytical model from the clean layer by: 
- creating a final schema
- building a final reporting table
- defining a primary key for reliability and faster queries 

---

## Tools Used
- PostgreSQL (local)
- `psql` (command line)
- SQL script file (batch run)

---

## Input / Output

### Source (clean layer)
- **Schema** `clean`
- **Table:** `clean.nyc_311_clean`
- **Data type:** typed & standardized

### Target (final mart)
- **Schema:** `mart`
- **Table:** `mart.nyc_311_final`

---

## Steps Completed
- Created `mart` schema for final analytics layer
- Created final table from clean layer `clean.nyc_311_clean`
- Copied all rows into `mart.nyc_311_final`
- Set `unique_key` as PRIMARY KEY
- Prepared table for downstream queries (Week 4 aggregations) 
