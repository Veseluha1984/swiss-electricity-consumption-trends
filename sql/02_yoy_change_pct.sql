WITH annual AS (
  SELECT
    year,
    SUM(tj_sum) / 3600.0 AS electricity_twh
  FROM workspace.default.gold_energy_annual
  WHERE energy_carrier = 'electricity'
  GROUP BY year
),
yoy AS (
  SELECT
    year,
    electricity_twh,
    LAG(electricity_twh) OVER (ORDER BY year) AS prev_twh
  FROM annual
)
SELECT
  year,
  ROUND(100.0 * (electricity_twh - prev_twh) / prev_twh, 2) AS yoy_pct
FROM yoy
WHERE prev_twh IS NOT NULL
ORDER BY year;
