USE bike_sales;
GO

SELECT TOP 5 * FROM sales;

-- 1. Accessories

WITH Avg_Accessories AS --avg by year
(
  SELECT
    YEAR(Date) AS Year,
    ROUND(AVG(Unit_cost * Order_Quantity),2) AS Avg_Acc_Cost
  FROM
    Sales
  WHERE
    Product_Category = 'Accessories'
  GROUP BY
    YEAR(Date)
), Pre_Query AS --adding lag function
(
  SELECT
    Year,
    Avg_Acc_Cost,
    COALESCE(ROUND(Avg_Acc_Cost - LAG(Avg_Acc_Cost) OVER(ORDER BY Year),2),0) AS Change_Over_Year --previous year change diff
  FROM
    Avg_Accessories
)
SELECT --additional case statement
  Year,
  Avg_Acc_Cost,
  CASE
    WHEN Change_Over_Year > 0 THEN CONCAT('+', Change_Over_Year)
    ELSE Change_Over_Year
  END AS Change_Over_Year
FROM
  Pre_Query
ORDER BY
    Year


-- 2. Clothing

WITH Avg_Clothing AS --avg by year
(
  SELECT
    YEAR(Date) AS Year,
    ROUND(AVG(Unit_cost * Order_Quantity),2) AS Avg_Acc_Cost
  FROM
    Sales
  WHERE
    Product_Category = 'Clothing'
  GROUP BY
    YEAR(Date)
), Pre_Query AS --adding lag function
(
  SELECT
    Year,
    Avg_Acc_Cost,
    COALESCE(ROUND(Avg_Acc_Cost - LAG(Avg_Acc_Cost) OVER(ORDER BY Year),2),0) AS Change_Over_Year --previous year change diff
  FROM
    Avg_Clothing 
)
SELECT --additional case statement
  Year,
  Avg_Acc_Cost AS Avg_Clothes_Cost,
  CASE
    WHEN Change_Over_Year > 0 THEN CONCAT('+', Change_Over_Year)
    ELSE Change_Over_Year
  END AS Change_Over_Year
FROM
  Pre_Query
ORDER BY
  Year


-- 3. Bikes

WITH Avg_Bikes AS --avg by year
(
  SELECT
    YEAR(Date) AS Year,
    ROUND(AVG(Unit_cost * Order_Quantity),2) AS Avg_Acc_Cost
  FROM
    Sales
  WHERE
    Product_Category = 'Bikes'
  GROUP BY
    YEAR(Date)
), Pre_Query AS --adding lag function
(
  SELECT
    Year,
    Avg_Acc_Cost,
    COALESCE(ROUND(Avg_Acc_Cost - LAG(Avg_Acc_Cost) OVER(ORDER BY Year),2),0) AS Change_Over_Year --previous year change diff
  FROM
    Avg_Bikes
)
SELECT --additional case statement
  Year,
  Avg_Acc_Cost AS Avg_Bikes_Cost,
  CASE
    WHEN Change_Over_Year > 0 THEN CONCAT('+', Change_Over_Year)
    ELSE Change_Over_Year
  END AS Change_Over_Year
FROM
  Pre_Query
ORDER BY
  Year