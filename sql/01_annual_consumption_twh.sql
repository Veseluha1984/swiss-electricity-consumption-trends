SELECT
  year,
  ROUND(SUM(tj_sum) / 3600.0, 3) AS electricity_twh
FROM workspace.default.gold_energy_annual
WHERE energy_carrier = 'electricity'
GROUP BY year
ORDER BY year;
