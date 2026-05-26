CREATE SCHEMA IF NOT EXISTS mart;
DROP TABLE IF EXISTS mart.nyc_311_final;
CREATE TABLE mart.nyc_311_final AS
SELECT *
FROM clean.nyc_311_clean;
ALTER TABLE mart.nyc_311_final
ADD PRIMARY KEY (unique_key);
