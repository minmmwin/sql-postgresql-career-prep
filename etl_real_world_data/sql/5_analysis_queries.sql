-- Week 3 – Day 5: Analytical Queries & Review
-- Source table: mart.nyc_311_final
-- Goal: Validate that cleaned and modeled data is usable for analysis

-- Q1: Total complaints per complaint type
SELECT
    complaint_type,
    COUNT(*) AS total_complaints
FROM mart.nyc_311_final
WHERE complaint_type IS NOT NULL
GROUP BY complaint_type
ORDER BY total_complaints DESC;

-- Q2: What are the top 10 complaint types in the dataset,
-- and what percent of total requests does each one represent?
SELECT
    complaint_type,
    COUNT(*) AS total_complaints,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS request_percentage
FROM mart.nyc_311_final
WHERE complaint_type IS NOT NULL
GROUP BY complaint_type
ORDER BY total_complaints DESC
LIMIT 10;

-- Q3: Which borough has the most complaints, and what % of total does each borough represent?
SELECT
    borough,
    COUNT(*) AS total_complaints,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() AS request_percentage
FROM mart.nyc_311_final
WHERE borough IS NOT NULL AND BTRIM(borough) <> ''
GROUP BY borough
ORDER BY total_complaints DESC;

-- Q4: What is the average resolution time (in hours) for each complaint type?
SELECT
    complaint_type,
    AVG(EXTRACT(EPOCH FROM (closed_ts - created_ts)) / 3600.0)
        FILTER (
            WHERE created_ts IS NOT NULL
              AND closed_ts IS NOT NULL
              AND closed_ts >= created_ts
        ) AS avg_resolution_hours
FROM mart.nyc_311_final
WHERE complaint_type IS NOT NULL
  AND BTRIM(complaint_type) <> ''
GROUP BY complaint_type
HAVING AVG(EXTRACT(EPOCH FROM (closed_ts - created_ts)) / 3600.0)
        FILTER (
            WHERE created_ts IS NOT NULL
              AND closed_ts IS NOT NULL
              AND closed_ts >= created_ts
        ) IS NOT NULL
ORDER BY avg_resolution_hours DESC;
