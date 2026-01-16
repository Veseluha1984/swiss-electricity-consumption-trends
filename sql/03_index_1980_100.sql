WITH annual AS (
  SELECT
    year,
    SUM(tj_sum) / 3600.0 AS electricity_twh
  FROM workspace.default.gold_energy_annual
  WHERE energy_carrier = 'electricity'
  GROUP BY year
),
base AS (
  SELECT electricity_twh AS base_twh
  FROM annual
  WHERE year = 1980
)
SELECT
  a.year,
  ROUND(100.0 * a.electricity_twh / b.base_twh, 2) AS idx_1980_100
FROM annual a
CROSS JOIN base b
ORDER BY a.year;
