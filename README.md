# LITA_SalesData_Project
This repository contains detailed information about the Sales data Analysis

## INTRODUCTION
For this project, I analyzed the sales performance of a retail store. The aim of this project is to gather insights about top-selling products, regional performance, monthly sales trends and give results for better decision making. The dataset contains detailed information about orders, customer demographics, and sales.

## DATA EXPLORATION
### How was the data collected?
The data was provided by the sales team. It contains summarized customer information and sales details from 2023 to 2024. 

## TOOLS USED
### For Data cleaning: 
Microsoft Excel

### For Analysis:
Microsoft Excel and SQL 

### For Visualization: 
PowerBI

## FEATURES IDENTIFIED FOR ANALYSIS
- Total sales by product, region, and month  
- Average sales per product
- Total units sold by product, region and month

## METHODOLOGY 
The dataset was loaded into Microsoft Excel. It was cleaned by addressing the blanks, removing duplicates, and ensuring consistent formats across the cells. Data was summarized by total sales, region, months using the Pivot tables. This gives us summarized information about the dataset. Further, the cleaned dataset was imported into SQL server to perform more analysis by querying the dataset. After obtaining satisfied results, the created views were imported into PowerBI for visualization.

## SCREENSHOTS OF SUMMARIZATION USING PIVOT TABLES
	

## QUERIES FOR THE ANALYSIS
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



## FINDINGS
It is discovered that Shoe product has the highest number of sales at $613,380, while Socks product has the lowest number of sales at $180,785. This makes Shoe the top-selling product and Socks the bottom-selling product Although Shoe product has the highest sales, it does not have the highest number of units sold. The product with the highest number of units sold is Hat at 15,929 units.
February has the highest sales at $546,300 and the highest number of units sold at 9,930 while September has the lowest sales at $34,720.
Southern region beats other regions with the highest sales at $927,820 and also the region with the highest number of units sold at 24,298. The Western region has the lowest sales at $300,345 and lowest number of units sold at 11,400.

