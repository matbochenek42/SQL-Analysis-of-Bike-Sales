USE bike_sales;
GO


-- 1. Bike sales information (for orders with more than 1 bike)

WITH Bikes_Sales AS --Number of bikes for each type and number of orders by gender
(
  SELECT
    Sub_Category,
    COUNT(*) AS Num_of_Orders,
    COUNT(CASE WHEN Gender = 'M' THEN 1 END) AS Num_of_Male_Orders,
    COUNT(CASE WHEN Gender = 'F' THEN 1 END) AS Num_of_Female_Orders
  FROM
    Sales
  WHERE
    Sub_Category LIKE '%Bikes' AND Order_Quantity > 1 --only bikes > 1
  GROUP BY
    Sub_Category
), All_Bikes AS --Number of all bike orders
(
  SELECT
    COUNT(*) AS Num_of_Bikes
  FROM
    Sales
  WHERE
    Sub_Category LIKE '%Bikes' AND Order_Quantity > 1 --only bikes > 1
)
SELECT
  Sub_Category AS Bike_Type,
  Num_of_Orders,
  ROUND(Num_of_Orders * 100.0 / Num_of_Bikes, 2) AS Percent_of_Total_Orders, --%
  CASE
    WHEN Num_of_Male_Orders < Num_of_Female_Orders THEN 'Females'
    WHEN Num_of_Male_Orders > Num_of_Female_Orders THEN 'Males'
    ELSE 'Draw'
  END AS Who_Ordered_More
FROM
  Bikes_Sales
CROSS JOIN
  All_Bikes