# Week 4 — Analysis Project #1 (NYC 311)

## Project Overview

This project analyzes NYC 311 service requests to identify patterns in complaint volume, geographic distribution, operational workload, and resolution performance.

Dataset: `mart.nyc_311_final`  
Source: NYC Open Data (subset used for learning)

---

## Key Business Questions & Metrics

### 1 Which complaint types generate the highest and lowest request volumes?

- **Metric:** Total complaint count
- **Grouping Level:** complaint_type
- **Time Granularity:** Entire selected period

---

### 2 Which borough accounts for the largest share of total complaints?

- **Metric:** Total complaints + % of total
- **Grouping Level:** borough
- **Time Granularity:** Entire selected period

---

### 3 At what time of day do complaint submissions peak?

- **Metric:** Complaint count
- **Grouping Level:** Hour of day (EXTRACT(HOUR))
- **Time Granularity:** Hourly

---

### 4 Which complaint types have the longest average resolution time?

- **Metric:** Average resolution time (hours)
- **Grouping Level:** complaint_type
- **Time Granularity:** Entire selected period

---

### 5 Are resolution times improving over time?

- **Metric:** Average resolution time (hours)
- **Grouping Level:** Month
- **Time Granularity:** Monthly trend

---

## Expected Output

- SQL queries for each question
- Clean result tables
- Visual screenshots
- Short written insights for each analysis
