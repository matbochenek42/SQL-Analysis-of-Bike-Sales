USE bike_sales;
GO

-- 1. Number of Orders - age distribution by gender

WITH Age_Segmentation AS --Age segmentation
(
  SELECT
    Age,
    Gender,
    CASE
      WHEN Age < 18 THEN '1. UnderAge (below 18)' --in most countries mentioned in the data, the Age of majority is 18 (with some exceptions in certain parts of the USA and Canada)
      WHEN Age >= 18 AND Age < 25 THEN '2. Young Adults (18-24)'
      WHEN Age >= 25 AND Age < 35 THEN '3. Young Professionals (25-34)'
      WHEN Age >= 35 AND Age < 45 THEN '4. Early Adults (35-44)'
      WHEN Age >= 45 AND Age < 55 THEN '5. Middle Adults (45-54)'
      WHEN Age >= 55 AND Age < 65 THEN '6. Older Adults (55-64)'
      WHEN Age >= 65 THEN '7. Seniors'
    END AS Age_Group
  FROM 
    Sales
)
SELECT --Age segmentation by gender
 Age_Group,
 COUNT(Age) AS Total_Count_of_Orders,
 ROUND(100.0 * COUNT(CASE WHEN Gender = 'M' THEN 1 END) / COUNT(Age),2) AS Men_Percent_Distribution,
 ROUND(100.0 * COUNT(CASE WHEN Gender = 'F' THEN 1 END) / COUNT(Age),2) AS Women_Percent_Distribution,
 CAST(AVG(Age) AS INTEGER) AS Avg_Age_in_Age_Groups
FROM
  Age_Segmentation
GROUP BY
  Age_Group
ORDER BY
  Age_Group;

-- 2. Number of Orders (including quantity of each order) - age distribution by gender

WITH Age_Segmentation AS --Age segmentation
(
  SELECT
    Age,
    Gender,
    CASE
      WHEN Age < 18 THEN '1. UnderAge (below 18)' --in most countries mentioned in the data, the Age of majority is 18 (with some exceptions in certain parts of the USA and Canada)
      WHEN Age >= 18 AND Age < 25 THEN '2. Young Adults (18-24)'
      WHEN Age >= 25 AND Age < 35 THEN '3. Young Professionals (25-34)'
      WHEN Age >= 35 AND Age < 45 THEN '4. Early Adults (35-44)'
      WHEN Age >= 45 AND Age < 55 THEN '5. Middle Adults (45-54)'
      WHEN Age >= 55 AND Age < 65 THEN '6. Older Adults (55-64)'
      WHEN Age >= 65 THEN '7. Seniors'
    END AS Age_Group,
    Order_Quantity
  FROM
    Sales
), Cte2 AS
(
  SELECT --Age segmentation by gender
    Age_Group,
    SUM(Order_Quantity) AS Total_Sum_of_Orders,
    SUM(CASE WHEN Gender = 'F' THEN Order_Quantity END) Female_Orders,
    SUM(CASE WHEN Gender = 'M' THEN Order_Quantity END) Male_Orders
  FROM
    Age_Segmentation
  GROUP BY
    Age_Group
)
SELECT
  *,
  CONCAT(ROUND((SUM(Male_Orders + Female_Orders) OVER(PARTITION BY Age_Group)) * 100.0 / (SUM(Total_Sum_of_Orders) OVER()),2), '%') AS Group_Percentage --age group / all groups ratio
FROM
  Cte2

UNION ALL

SELECT -- select with sums of total sum, female/male orders
  '--Total Sum--' AS Age_Group,
  SUM(Total_Sum_of_Orders),
  SUM(Female_Orders),
  SUM(Male_Orders),
  '--' AS Group_Percentage
FROM 
    Cte2;

-- 3. Bike category sales by age groups

WITH Age_Segmentation AS --Age segmentation
(
  SELECT
    CASE
      WHEN Age < 18 THEN '1. UnderAge (below 18)' --in most countries mentioned in the data, the Age of majority is 18 (with some exceptions in certain parts of the USA and Canada)
      WHEN Age >= 18 AND Age < 25 THEN '2. Young Adults (18-24)'
      WHEN Age >= 25 AND Age < 35 THEN '3. Young Professionals (25-34)'
      WHEN Age >= 35 AND Age < 45 THEN '4. Early Adults (35-44)'
      WHEN Age >= 45 AND Age < 55 THEN '5. Middle Adults (45-54)'
      WHEN Age >= 55 AND Age < 65 THEN '6. Older Adults (55-64)'
      WHEN Age >= 65 THEN '7. Seniors'
    END AS Age_Group,
    Sub_Category,
    Order_Quantity
  FROM
    Sales
  WHERE
    Product_Category = 'Bikes'
)
SELECT --Age segmentation by gender
 Age_Group,
 ROUND(100.0 * SUM(CASE WHEN Sub_Category = 'Mountain Bikes' THEN Order_Quantity END) / SUM(Order_Quantity),2) AS Mountaint_Bikes_Orders,
 ROUND(100.0 * SUM(CASE WHEN Sub_Category = 'Road Bikes' THEN Order_Quantity END) / SUM(Order_Quantity),2) AS Road_Bikes_Orders,
 ROUND(100.0 * SUM(CASE WHEN Sub_Category = 'Touring Bikes' THEN Order_Quantity END) / SUM(Order_Quantity),2) AS Touring_Bikes_Orders
FROM
  Age_Segmentation
GROUP BY
  Age_Group
ORDER BY
  Age_Group;


-- 4. Average spending - age distribution

WITH Age_Segmentation AS --Age segmentation
(
  SELECT
    CASE
      WHEN Age < 18 THEN '1. UnderAge (below 18)' --in most countries mentioned in the data, the Age of majority is 18 (with some exceptions in certain parts of the USA and Canada)
      WHEN Age >= 18 AND Age < 25 THEN '2. Young Adults (18-24)'
      WHEN Age >= 25 AND Age < 35 THEN '3. Young Professionals (25-34)'
      WHEN Age >= 35 AND Age < 45 THEN '4. Early Adults (35-44)'
      WHEN Age >= 45 AND Age < 55 THEN '5. Middle Adults (45-54)'
      WHEN Age >= 55 AND Age < 65 THEN '6. Older Adults (55-64)'
      WHEN Age >= 65 THEN '7. Seniors'
    END AS Age_Group,
    Order_Quantity * Unit_price AS Order_Sum,
    Order_Quantity
  FROM
    Sales
  WHERE
    Product_Category = 'Bikes'
)
SELECT --Age segmentation by gender
 Age_Group,
 ROUND(AVG(Order_Sum),2) AS Avg_Spending
FROM
  Age_Segmentation
GROUP BY
  Age_Group
ORDER BY
  Age_Group;
