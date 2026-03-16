USE bike_sales;
GO

SELECT TOP 5 * FROM sales;

-- 1. Average profit of each season for every country

WITH Month_Extracted AS --extracting months
(
  SELECT
    Country,
    MONTH(Date) AS Month,
    Profit
  FROM
    Sales
), Seasons AS --seasons case statement
(
  SELECT
    Country,
    CASE
      WHEN Month BETWEEN 6 AND 8 THEN 'Summer'
      WHEN Month BETWEEN 9 AND 11 THEN 'Autumn'
      WHEN Month = 12 OR Month BETWEEN 1 AND 2 THEN 'Winter'
      WHEN Month BETWEEN 3 AND 5 THEN 'Spring'
    END AS Season,
    Profit
  FROM
    Month_Extracted
) -- final query
SELECT
  Country,
  ROUND(AVG(Profit),2) AS Avg_Profit_Overall,
  ROUND(AVG(CASE WHEN Season = 'Spring' THEN Profit END),2) AS Spring_avg,
  ROUND(AVG(CASE WHEN Season = 'Summer' THEN Profit END),2) AS Summer_avg,
  ROUND(AVG(CASE WHEN Season = 'Autumn' THEN Profit END),2) AS Autumn_avg,
  ROUND(AVG(CASE WHEN Season = 'Winter' THEN Profit END),2) AS Winter_avg
FROM
  Seasons
GROUP BY
  Country
ORDER BY
  Country;

-- 2. Number of orders for every country for each season

WITH Month_Extracted AS 
(
  SELECT
    Country,
    MONTH(Date) AS Month
  FROM 
    Sales
), 
Seasons AS 
(
  SELECT
    Country,
    CASE
      WHEN Month BETWEEN 6 AND 8 THEN 'Summer'
      WHEN Month BETWEEN 9 AND 11 THEN 'Autumn'
      WHEN Month = 12 OR Month BETWEEN 1 AND 2 THEN 'Winter'
      WHEN Month BETWEEN 3 AND 5 THEN 'Spring'
    END AS Season
  FROM 
    Month_Extracted
), 
Pre_Query AS 
(
  SELECT
    Country,
    COUNT(CASE WHEN Season = 'Spring' THEN 1 END) AS Spring_Ord,
    COUNT(CASE WHEN Season = 'Summer' THEN 1 END) AS Summer_Ord,
    COUNT(CASE WHEN Season = 'Autumn' THEN 1 END) AS Autumn_Ord,
    COUNT(CASE WHEN Season = 'Winter' THEN 1 END) AS Winter_Ord
  FROM 
    Seasons
  GROUP BY 
    Country
)
-- country stats (INT to VARCHAR for the Union)
SELECT
  CAST(Country AS VARCHAR(100)) AS Country,
  CAST(Spring_Ord AS VARCHAR(20)) AS Spring_Ord,
  CAST(Summer_Ord AS VARCHAR(20)) AS Summer_Ord,
  CAST(Autumn_Ord AS VARCHAR(20)) AS Autumn_Ord,
  CAST(Winter_Ord AS VARCHAR(20)) AS Winter_Ord,
  CONCAT(ROUND(SUM(Spring_Ord + Summer_Ord + Autumn_Ord + Winter_Ord) OVER(PARTITION BY Country)*100.0 / 
              SUM(Spring_Ord + Summer_Ord + Autumn_Ord + Winter_Ord) OVER(), 2), '%') AS Country_Percent
FROM Pre_Query

UNION ALL

-- seasonal percentage 
SELECT DISTINCT 
  'Percent_by_Season',
  CONCAT(ROUND(SUM(Spring_Ord) OVER()*100.0 / SUM(Spring_Ord + Summer_Ord + Autumn_Ord + Winter_Ord) OVER(), 2), '%'),
  CONCAT(ROUND(SUM(Summer_Ord) OVER()*100.0 / SUM(Spring_Ord + Summer_Ord + Autumn_Ord + Winter_Ord) OVER(), 2), '%'),
  CONCAT(ROUND(SUM(Autumn_Ord) OVER()*100.0 / SUM(Spring_Ord + Summer_Ord + Autumn_Ord + Winter_Ord) OVER(), 2), '%'),
  CONCAT(ROUND(SUM(Winter_Ord) OVER()*100.0 / SUM(Spring_Ord + Summer_Ord + Autumn_Ord + Winter_Ord) OVER(), 2), '%'),
  '--'
FROM Pre_Query;