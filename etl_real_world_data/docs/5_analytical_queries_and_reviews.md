# Week 3 — Day 5: Analytical Queries & Review

## Goal
Validate that the cleaned and modeled dataset is usable for analysis by writing aggregation queries and extracting business insights.

---

## Tools Used
- PostgreSQL (local)
- `psql` (command line)
- SQL script file (`05_analysis_queries.sql`)

---

## Dataset Used
- **Schema:** `mart`
- **Table:** `mart.nyc_311_final`
- Cleaned and typed data from Week 3 ETL pipeline
- Primary Key: `unique_key`

---

## Queries & Observations

### 1 Top 10 Complaint Types
- Identified most frequent service requests.
- **Observation:** Heat/Hot Water and Noise complaints dominate the dataset.
- Indicates housing and quality-of-life issues are primary drivers.

---

### 2 Complaint Distribution by Borough
- Calculated total complaints and % contribution per borough.
- **Observation:** Bronx and Brooklyn account for the highest share.
- Suggests higher population density and urban activity impact complaint volume.

---

### 3 Average Resolution Time (Hours) by Complaint Type
- Calculated average hours between `created_ts` and `closed_ts`.
- Filtered out invalid or incomplete timestamps.
- **Observation:** Some complaint types (e.g., Tunnel Condition, Cannabis Retailer) show extremely high resolution times.
- May indicate backlog, complexity, or small sample sizes.

---

### 4 Data Quality Notes
- Some complaint types have no valid resolution timestamps.
- Blank averages indicate zero valid completed records.
- Data modeling and filtering successfully prevented incorrect duration calculations.

---

## Week 3 Summary

This week implemented a simplified ETL workflow:

1. Imported raw CSV data into staging tables
2. Cleaned and standardized data types
3. Built a final analytics schema (`mart`)
4. Defined primary key for integrity
5. Wrote analytical queries to validate usability

The dataset is now analysis-ready for advanced SQL topics (aggregations, joins, window functions in Week 4).
