# Core Aggregations

## Goal
Build foundational analytical queries that answer key business questions from the project plan using the cleaned dataset.

---

## Tools Used
- PostgreSQL (local)
- `psql` (command line)
- SQL script file (batch run)

---

## Input / Output

### Source (final dataset)
- **Schema:** `mart`
- **Table:** `mart.nyc_311_final`
- **Data type:** cleaned and structured records from NYC 311 service requests

### Target
- Analytical SQL queries stored in:
- `sql/01_analysis_project_queries.sql`

---

## Analytical Queries Implemented

### Q1 — Complaint volume by type
Measure total request counts for each complaint category to identify the highest and lowest volume issues.

### Q2 — Complaint volume by borough
Determine which borough generates the largest share of total service requests.

### Q3 — Daily complaint trend
Analyze how complaint volume changes day-by-day during the selected dataset period.

### Q4 — Average resolution time by complaint type
Calculate average resolution time (in hours) using the difference between `created_ts` and `closed_ts`.

### Q5 — Percentage of unresolved complaints
Measure the share of requests still marked as `Open` relative to the total number of complaints.

---

## Key Observations

- Complaint volume varies significantly by category, with a few types accounting for the majority of requests.
- Borough distribution shows concentration of requests in several high-population areas.
- Daily complaint counts fluctuate during the month, with noticeable drops around holidays.
- Some complaint types require substantially longer resolution times due to regulatory or operational complexity.
- Approximately **5% of complaints remain unresolved** in the dataset snapshot.

---

## Outcome
Created a set of reusable aggregation queries that support exploratory analysis and will serve as the foundation for deeper insights and visualizations in the next stages of the project.
