# Advanced Analysis

## Goal
Enhance the analysis with more advanced SQL techniques including window functions, ranking, and time-based comparisons.

---

## Tools Used
- PostgreSQL (local)
- `psql` command line
- SQL script file

---

## Source Data
- **Schema:** `mart`
- **Table:** `mart.nyc_311_final`
- **Dataset:** NYC 311 service requests (cleaned subset)

---

## Advanced Analytical Queries

### Q6 — Complaint share of total requests
Calculated the percentage contribution of each complaint type using window functions.

Key SQL features:
- `GROUP BY`
- `SUM() OVER()`
- percentage calculations

Purpose:
Identify which complaint categories dominate service request volume.

---

### Q7 — Most common complaint type per borough
Determined the top complaint category in each borough using ranking.

Key SQL features:
- CTE
- `DENSE_RANK()`
- `PARTITION BY`

Purpose:
Understand local service priorities across boroughs.

---

### Q8 — Peak complaint submission hour
Analyzed hourly complaint submission patterns.

Key SQL features:
- `EXTRACT(HOUR)`
- `GROUP BY`
- aggregation

Purpose:
Identify operational demand patterns during the day.

---

### Q9 — Day-to-day complaint volume change
Calculated daily complaint counts and percentage change using lagged values.

Key SQL features:
- CTE
- `LAG()`
- window functions
- percentage change calculation

Purpose:
Analyze short-term fluctuations in complaint volume.

---

## Key Observations

- A small number of complaint categories generate a large share of service requests.
- Complaint priorities vary by borough, reflecting local infrastructure and housing conditions.
- Complaint submissions peak during morning hours.
- Complaint volumes fluctuate throughout the month with noticeable drops during holidays.

---

## Outcome

Implemented advanced analytical SQL queries that demonstrate practical use of:

- window functions
- ranking
- time-series analysis
- CTE-based query structuring

These queries add analytical depth to the project and make the SQL portfolio more representative of real-world analytics workflows.

2️⃣ Update Week 4 README
Add this section at the bottom of your existing README.
## Analytical Queries Implemented

### Core Aggregations (Day 2)

1. Complaint volume by complaint type
2. Complaint volume by borough
3. Daily complaint trend
4. Average resolution time by complaint type
5. Percentage of unresolved complaints

### Advanced Analysis (Day 3)

6. Complaint share of total requests (window functions)
7. Most common complaint type per borough (ranking)
8. Peak complaint submission hour
9. Day-to-day complaint volume change (LAG)
Top of Form

Bottom of Form

