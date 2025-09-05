CREATE TABLE materials (
  material_id TEXT PRIMARY KEY,
  name TEXT,
  type TEXT,
  co2_per_ton REAL,
  strength_MPa REAL,
  cost_per_ton REAL,
  durability_years REAL
);

-- Average CO2 by type
SELECT type, AVG(co2_per_ton) AS avg_co2 FROM materials GROUP BY type;

-- % CO2 reduction (traditional vs biocement)
WITH agg AS (
  SELECT type, AVG(co2_per_ton) avg_co2 FROM materials GROUP BY type
)
SELECT t1.avg_co2 as trad_co2, t2.avg_co2 as bio_co2,
ROUND((t1.avg_co2 - t2.avg_co2)/t1.avg_co2*100,2) AS pct_reduction
FROM agg t1 JOIN agg t2 ON t1.type <> t2.type
WHERE t1.type='traditional' AND t2.type='biocement';

-- Cost-to-strength ratio
SELECT name, cost_per_ton/strength_MPa AS cost_strength FROM materials ORDER BY cost_strength ASC;
