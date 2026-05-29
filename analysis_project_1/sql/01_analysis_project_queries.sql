-- Week 4 – Day 2: Core Aggregations
-- Source table: mart.nyc_311_final
-- Goal: Build clean foundational queries that answer business questions from the project plan.

-- Q1: Which complaint types generate the highest and lowest request volumes?

SELECT complaint_type, COUNT(*) total_complaints
FROM mart.nyc_311_final
GROUP BY complaint_type
ORDER BY total_complaints DESC;

-- Q2: Which borough has the highest complaint volume?

SELECT
    borough,
    COUNT(*) AS total_complaints,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS percentage_of_total
FROM mart.nyc_311_final
WHERE borough IS NOT NULL
  AND BTRIM(borough) <> ''
GROUP BY borough
ORDER BY total_complaints DESC;

-- Q3: How did complaint volume change day by day during the selected period?

SELECT
   DATE_TRUNC('day', created_ts) AS day,
   COUNT(*) AS total_complaints
FROM mart.nyc_311_final
GROUP BY day
ORDER BY day;

-- Q4: Which complaint types take the longest to resolve on average?

SELECT
    complaint_type,
    AVG(EXTRACT(EPOCH FROM (closed_ts - created_ts)) / 3600.0)
        FILTER (WHERE created_ts IS NOT NULL
        AND closed_ts IS NOT NULL
        AND closed_ts >= created_ts)
    AS avg_resolution_hours
FROM mart.nyc_311_final
WHERE complaint_type IS NOT NULL
  AND BTRIM(complaint_type) <> ''
GROUP BY complaint_type
HAVING AVG(EXTRACT(EPOCH FROM (closed_ts - created_ts)) / 3600.0)
       FILTER (WHERE created_ts IS NOT NULL
       AND closed_ts IS NOT NULL
       AND closed_ts >= created_ts) IS NOT NULL
ORDER BY avg_resolution_hours DESC;

-- Q5: What percentage of complaints are still unresolved?
SELECT
    COUNT(CASE WHEN status = 'Open' THEN 1 END) * 100.0 / COUNT(*) AS unresolved_percentage
FROM mart.nyc_311_final;

-- ==========================================================================================================
-- Week 4 – Day 3: Advanced Analysis
-- Source table: mart.nyc_311_final
-- Goal: Add deeper analytical insights using window functions, ranking, and CTEs.
-- ==========================================================================================================

-- Q6: Which complaint types contribute the largest share of total requests?
SELECT
    complaint_type,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS pct_of_total
FROM mart.nyc_311_final
GROUP BY complaint_type
ORDER BY pct_of_total DESC;

-- Q7: What is the most common complaint in each borough?
WITH complaints_total AS (
    SELECT
        borough,
        complaint_type,
        COUNT(*) total_complaints
    FROM mart.nyc_311_final
    GROUP BY borough, complaint_type
    ORDER BY total_complaints DESC
)
SELECT
    borough,
    complaint_type,
    DENSE_RANK() OVER (
        PARTITION BY borough
        ORDER BY total_complaints DESC
    ) AS borough_rank
FROM complaints_total;

-- Q8: How did complaint volume change day-to-day?

WITH complaints_by_day AS (
    SELECT
        EXTRACT(DAY FROM created_ts)::int AS day,
        COUNT(*) AS complaints
    FROM mart.nyc_311_final
    GROUP BY day
)
SELECT
    day,
    complaints,
    LAG(complaints) OVER (ORDER BY day) AS prev_day,
    ROUND(
        (complaints - LAG(complaints) OVER (ORDER BY day)) * 100.0
        / LAG(complaints) OVER (ORDER BY day),
        2
    ) AS pct_change
FROM complaints_by_day
ORDER BY day;