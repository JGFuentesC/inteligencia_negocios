  /*Conteo de registros por mes*/
SELECT
  DATE_TRUNC(trip_start_timestamp,month),
  COUNT(*) AS registros
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`
GROUP BY
  1
ORDER BY
  1; 
  
  /*Extracción de datos públicos a un dataset propio*/
CREATE OR REPLACE TABLE
  taxi.trips AS
SELECT
  taxi_id,
  trip_start_timestamp,
  trip_end_timestamp,
  trip_seconds,
  trip_miles,
  fare,
  tips,
  tolls,
  extras,
  trip_total,
  payment_type,
  company,
  pickup_latitude,
  pickup_longitude,
  dropoff_latitude,
  dropoff_longitude
FROM
  `bigquery-public-data.chicago_taxi_trips.taxi_trips`
WHERE
  trip_start_timestamp>='2022-01-01'; 
  /*Creación de tabla particionada*/
CREATE OR REPLACE TABLE
  taxi.partitioned_trips
PARTITION BY
  DATE_TRUNC(trip_start_timestamp,month) AS
SELECT
  *
FROM
  taxi.trips ;

SELECT
  payment_type,
  # Dimensión
  SUM(trip_total) AS total,
  # Hechos
  COUNT(trip_total) AS num_viajes,
  AVG(trip_total) AS avg_viaje,
  MIN(trip_total) AS min_viaje,
  MAX(trip_total) AS max_viaje
FROM
  `anahuac-bi.taxi.partitioned_trips`
GROUP BY
  payment_type
ORDER BY
  payment_type;


select 
cast(date_trunc(trip_start_timestamp,month) as date) as mes,
sum(case when payment_type='Credit Card' then trip_total else 0 end) as credit_card,
sum(case when payment_type='Cash' then trip_total else 0 end) as cash,
sum(case when payment_type='Mobile' then trip_total else 0 end) as mobile,
from `anahuac-bi.taxi.partitioned_trips`
where payment_type in ('Credit Card','Mobile','Cash')
group by 1
order by 1 ;


SELECT
  tipo,
  (dic23-dic22)/dic22 AS pct_cambio
FROM (
  SELECT
    *
  FROM ((
      SELECT
        'cash' AS tipo,
        SUM(trip_total) dic22
      FROM
        `anahuac-bi.taxi.partitioned_trips`
      WHERE
        payment_type ='Cash'
        AND DATE_TRUNC(trip_start_timestamp,month)='2022-12-01')
    UNION ALL (
      SELECT
        'cc' AS tipo,
        SUM(trip_total) dic22
      FROM
        `anahuac-bi.taxi.partitioned_trips`
      WHERE
        payment_type ='Credit Card'
        AND DATE_TRUNC(trip_start_timestamp,month)='2022-12-01')) A
  INNER JOIN ((
      SELECT
        'cash' AS tipo,
        SUM(trip_total) dic23
      FROM
        `anahuac-bi.taxi.partitioned_trips`
      WHERE
        payment_type ='Cash'
        AND DATE_TRUNC(trip_start_timestamp,month)='2023-12-01')
    UNION ALL (
      SELECT
        'cc' AS tipo,
        SUM(trip_total) dic23
      FROM
        `anahuac-bi.taxi.partitioned_trips`
      WHERE
        payment_type ='Credit Card'
        AND DATE_TRUNC(trip_start_timestamp,month)='2023-12-01')) B
  USING
    (tipo)) C;

WITH
  dic22 AS (
  SELECT
    taxi_id,
    SUM(trip_total) AS total_22
  FROM
    `anahuac-bi.taxi.partitioned_trips`
  WHERE
    DATE_TRUNC(trip_start_timestamp,month)='2022-12-01'
  GROUP BY
    1 ),
  dic23 AS (
  SELECT
    taxi_id,
    SUM(trip_total) AS total_23
  FROM
    `anahuac-bi.taxi.partitioned_trips`
  WHERE
    DATE_TRUNC(trip_start_timestamp,month)='2023-12-01'
  GROUP BY
    1 )
SELECT
  *
FROM
  dic23
LEFT JOIN
  dic22
USING
  (taxi_id);


with agrupMes as (
  select cast(date_trunc(trip_start_timestamp,month) as date) mes,
  count(*) as num_viajes
  from `anahuac-bi.taxi.partitioned_trips`
  group by 1
)
select *,
row_number() over (order by mes) as rn,
LAG(num_viajes,1) over (order by mes) as mes_ant,
Lead(num_viajes,1) over (order by mes) as mes_pos,
sum(num_viajes) over (order by mes) as total_viajes
from agrupMes
order by mes
;

WITH
  baseTable AS (
  SELECT
    taxi_id,
    CAST(DATE_TRUNC(trip_start_timestamp,month) AS date) AS mes,
    SUM(trip_total) AS total,
    COUNT(*) AS num_viajes
  FROM
    `anahuac-bi.taxi.partitioned_trips`
  GROUP BY
    ALL
  ORDER BY
    taxi_id,
    mes)
SELECT
  taxi_id,
  mes,
  total,
  num_viajes,
  ROW_NUMBER() OVER (PARTITION BY taxi_id ORDER BY mes) AS rn,
  (SUM(total) OVER (PARTITION BY taxi_id ORDER BY mes ROWS BETWEEN 5 PRECEDING AND 0 FOLLOWING))/(SUM(num_viajes) OVER (PARTITION BY taxi_id ORDER BY mes ROWS BETWEEN 5 PRECEDING AND 0 FOLLOWING)) ticket_promedio_ult6m
FROM
  baseTable
order by taxi_id,mes;