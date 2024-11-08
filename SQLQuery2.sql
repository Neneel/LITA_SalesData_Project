----- Total sales of Products
CREATE VIEW ProductSales AS 
SELECT Product, SUM(TotalSales) as Total_sales
FROM dbo.[SalesData]
GROUP BY Product;


----- Number of transactions for each regions
CREATE VIEW RegionTransactions AS
SELECT Region, COUNT(OrderID) AS No_of_transactions
FROM dbo.[SalesData]
GROUP BY Region;


----- Products with the Maximum sales
SELECT Product,MAX(Total_sales) AS Highest_sales_value
FROM dbo.ProductSales
GROUP BY Product 
ORDER BY Highest_sales_value DESC

----- Monthly sales for the current year
CREATE VIEW MontlySales AS
SELECT YEAR(Orderdate) AS Year, 
MONTH(Orderdate) AS Month,SUM(TotalSales) 
AS Total_Sales
FROM  [dbo].[SalesData]
GROUP BY YEAR(Orderdate), MONTH(Orderdate)

SELECT *
FROM MontlySales
WHERE Year= 2024

----- Top 5 custombers by total purchase amount
SELECT TOP(5) CustomerId, SUM(TotalSales) AS Amount_of_purchase
FROM [dbo].[SalesData]
Group by CustomerId
ORDER BY Amount_of_purchase DESC

----- Percentage of region sales
CREATE VIEW RegionSales AS
SELECT DISTINCT Region,SUM(TotalSales) AS GrandTotal, (SUM(TotalSales)/(SELECT SUM(TotalSales) FROM [dbo].[SalesData])*100)as percentage
FROM [dbo].[SalesData]
GROUP BY Region;

----- Products with no sales in the last quarter
SELECT DISTINCT Product
FROM [dbo].[SalesData]
WHERE OrderDate >= DATEADD(day, -90, GETDATE())
