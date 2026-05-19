# ETL & Real-World Data Import (PostgreSQL)

## Overview
This week focuses on working with **real-world datasets** and applying SQL in an
ETL (Extract, Transform, Load) workflow. The goal is to practice importing,
cleaning, modeling, and analyzing messy production-style data using PostgreSQL.

Dataset used for this week:
- **NYC 311 Service Requests (Open Data)**

---

## Objectives
- Import large CSV datasets into PostgreSQL
- Design staging tables for raw data
- Clean and standardize real-world fields using SQL
- Identify primary keys, foreign keys, and normalization opportunities
- Write analytical queries on cleaned data

---

## Dataset
**Source:** NYC Open Data  
**Dataset:** 311 Service Requests  
**Time range used:** _TBD (subset for performance & clarity)_

Notes:
- Dataset is intentionally large and messy
- Only a filtered date range is used for learning and performance reasons

---

## Folder Structure

```text
data/
├── raw/        # Original CSV files (filtered subset)
├── cleaned/    # Optional cleaned exports

python/
├── subset_csv    # Generate filtered Dec 2025 CSV subset from NYC 311 dataset

sql/
├── 01_create_staging_table.sql    # CREATE TABLE statements
├── 02_import_data.sql             # import data
├── 03_analysis_queries.sql        # Aggregations & insights
├── 04_create_final_tables.sql     # Model data and & final table
├── 05_analysis_queries.sql        # Analyss queries & review 
