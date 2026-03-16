USE bike_sales;
GO

--5. USA sales analysis for 2015

SELECT
  DENSE_RANK() OVER(PARTITION BY Date ORDER BY Profit DESC) AS Rank_By_Profit_Per_Day,
  Date,
  Product_Category,
  Sub_Category,
  Product,
  Order_Quantity,
  ROUND(Order_Quantity *100.0 / SUM(Order_Quantity) OVER(PARTITION BY Date),1) AS Percent_Ord_Per_Day,
  Profit,
  NULLIF(MAX(Profit) OVER(PARTITION BY Date) - Profit,0) AS Maxx_Diff_For_Profit_Per_Day
FROM
  Sales
WHERE
  Country = 'United States' AND Date >= '2015-01-01' AND Date < '2016-01-01'
ORDER BY
  Date;