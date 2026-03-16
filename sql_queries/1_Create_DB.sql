DROP DATABASE IF EXISTS bike_sales;
GO

CREATE DATABASE bike_sales;
GO


USE bike_sales;
GO

DROP TABLE IF EXISTS sales;


-- table establishment
CREATE TABLE Sales 
(
    Date DATE,
    Day INT,
    Month NVARCHAR(20),
    Year INT,
    Age INT,
    Age_Group NVARCHAR(20),
    Gender NVARCHAR(1),
    Country NVARCHAR(50),
    State NVARCHAR(50),
    Product_Category NVARCHAR(50),
    Sub_Category NVARCHAR(50),
    Product NVARCHAR(100),
    Order_Quantity INT,
    Unit_Cost INT,
    Unit_Price INT,
    Profit INT,
    Cost INT,
    Revenue INT
);


-- inserting data from csv file
-- UPDATE THE PATH

BULK INSERT Sales
FROM 'C:\Users\Mateusz\Desktop\ZBIORCZE\TECH\ANALIZA DANYCH\SQL\Projekty MB\SQL Analysis of Bike Sales\Sales.csv' -- UPDATE THIS PATH!
WITH 
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);


-- OVERVIEW OF THE DATA
SELECT TOP 10 * FROM sales;
GO