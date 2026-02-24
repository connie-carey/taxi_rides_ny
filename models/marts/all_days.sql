{{ config(materialized='table') }}

WITH bounds AS (
  SELECT
    DATE(MIN(pickup_datetime)) AS min_date,
    DATE(MAX(pickup_datetime)) AS max_date
  FROM {{ ref('int_trips') }}
)

SELECT
  day AS date_day
FROM bounds,
UNNEST(
  GENERATE_DATE_ARRAY(min_date, max_date, INTERVAL 1 DAY)
) AS day