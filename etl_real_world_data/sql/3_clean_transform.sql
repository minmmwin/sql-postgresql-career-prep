-- Week 3 Day 3 — Clean transform
-- Source: raw.stg_nyc_311 (all TEXT)
-- Target: clean.nyc_311_clean (typed + standardized)

CREATE SCHEMA IF NOT EXISTS clean;

DROP TABLE IF EXISTS clean.nyc_311_clean;

CREATE TABLE clean.nyc_311_clean AS
WITH src AS (
  SELECT
    -- turn empty strings into NULL early
    NULLIF(BTRIM(unique_key), '')      AS unique_key_txt,
    NULLIF(BTRIM(created_date), '')    AS created_date_txt,
    NULLIF(BTRIM(closed_date), '')     AS closed_date_txt,
    NULLIF(BTRIM(agency), '')          AS agency,
    NULLIF(BTRIM(agency_name), '')     AS agency_name,
    NULLIF(BTRIM(complaint_type), '')  AS complaint_type,
    NULLIF(BTRIM(descriptor), '')      AS descriptor,
    NULLIF(BTRIM(status), '')          AS status,
    NULLIF(BTRIM(borough), '')         AS borough,
    NULLIF(BTRIM(incident_zip), '')    AS incident_zip,
    NULLIF(BTRIM(latitude), '')        AS latitude_txt,
    NULLIF(BTRIM(longitude), '')       AS longitude_txt
  FROM raw.stg_nyc_311
),
typed AS (
  SELECT
    -- ID
    CASE
      WHEN unique_key_txt ~ '^\d+$' THEN unique_key_txt::BIGINT
      ELSE NULL
    END AS unique_key,

    -- created_ts: handle BOTH formats:
    -- 1) "01/01/2026 11:59:52 PM"
    -- 2) "1/1/2026 23:59" (24h, no seconds)
    COALESCE(
      CASE
        WHEN created_date_txt ~ '^\d{1,2}/\d{1,2}/\d{4} \d{1,2}:\d{2}:\d{2} (AM|PM)$'
          THEN to_timestamp(created_date_txt, 'MM/DD/YYYY HH12:MI:SS AM')
      END,
      CASE
        WHEN created_date_txt ~ '^\d{1,2}/\d{1,2}/\d{4} \d{1,2}:\d{2}:\d{2}$'
          THEN to_timestamp(created_date_txt, 'MM/DD/YYYY HH24:MI:SS')
      END,
      CASE
        WHEN created_date_txt ~ '^\d{1,2}/\d{1,2}/\d{4} \d{1,2}:\d{2}$'
          THEN to_timestamp(created_date_txt, 'MM/DD/YYYY HH24:MI')
      END
    ) AS created_ts,

    COALESCE(
      CASE
        WHEN closed_date_txt ~ '^\d{1,2}/\d{1,2}/\d{4} \d{1,2}:\d{2}:\d{2} (AM|PM)$'
          THEN to_timestamp(closed_date_txt, 'MM/DD/YYYY HH12:MI:SS AM')
      END,
      CASE
        WHEN closed_date_txt ~ '^\d{1,2}/\d{1,2}/\d{4} \d{1,2}:\d{2}:\d{2}$'
          THEN to_timestamp(closed_date_txt, 'MM/DD/YYYY HH24:MI:SS')
      END,
      CASE
        WHEN closed_date_txt ~ '^\d{1,2}/\d{1,2}/\d{4} \d{1,2}:\d{2}$'
          THEN to_timestamp(closed_date_txt, 'MM/DD/YYYY HH24:MI')
      END
    ) AS closed_ts,

    -- text normalization (keep it simple + consistent)
    UPPER(agency) AS agency,
    NULLIF(BTRIM(agency_name), '') AS agency_name,
    NULLIF(BTRIM(complaint_type), '') AS complaint_type,
    NULLIF(BTRIM(descriptor), '') AS descriptor,

    INITCAP(LOWER(status))  AS status,
    INITCAP(LOWER(borough)) AS borough,

    -- zip: keep 5-digit only (NYC has many 5-digit zips)
    CASE
      WHEN incident_zip ~ '^\d{5}$' THEN incident_zip
      ELSE NULL
    END AS incident_zip,

    -- lat/long numeric if valid-ish
    CASE
      WHEN latitude_txt ~ '^-?\d+(\.\d+)?$' THEN latitude_txt::NUMERIC(10,6)
      ELSE NULL
    END AS latitude,

    CASE
      WHEN longitude_txt ~ '^-?\d+(\.\d+)?$' THEN longitude_txt::NUMERIC(10,6)
      ELSE NULL
    END AS longitude

  FROM src
)
SELECT *
FROM typed
WHERE unique_key IS NOT NULL
  AND created_ts IS NOT NULL;


-- row counts
SELECT COUNT(*) AS staging_rows FROM raw.stg_nyc_311;
SELECT COUNT(*) AS clean_rows   FROM clean.nyc_311_clean;

-- how many got dropped (missing key/created_ts)
SELECT
  COUNT(*) FILTER (WHERE NULLIF(BTRIM(unique_key), '') IS NULL) AS missing_unique_key_txt,
  COUNT(*) FILTER (WHERE NULLIF(BTRIM(created_date), '') IS NULL) AS missing_created_date_txt
FROM raw.stg_nyc_311;

-- sanity: invalid lat/long range (optional)
SELECT COUNT(*) AS bad_geo
FROM clean.nyc_311_clean
WHERE latitude  NOT BETWEEN  -90 AND  90
   OR longitude NOT BETWEEN -180 AND 180;
