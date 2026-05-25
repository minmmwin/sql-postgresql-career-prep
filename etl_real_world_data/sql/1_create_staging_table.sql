CREATE SCHEMA IF NOT EXISTS raw;

DROP TABLE IF EXISTS raw.stg_nyc_311;

CREATE TABLE raw.stg_nyc_311 (
  unique_key      text,
  created_date    text,
  closed_date     text,
  agency          text,
  agency_name     text,
  complaint_type  text,
  descriptor      text,
  status          text,
  borough         text,
  incident_zip    text,
  latitude        text,
  longitude       text
);
