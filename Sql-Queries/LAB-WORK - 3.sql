--Lab Work two IN PERSON
--Challenge 1: Retrieve Product Information

--1 Write a query to return the product ID of each product, together with the 
--product name formatted as upper case and a column named ApproxWeight 
--with the weight of each product rounded to the nearest whole unit.


SELECT ProductID, name,
UPPER(Name) AS ProductName, ROUND(weight, 0) AS ApproxWeight 
FROM SalesLT.Product;

--2 Extend your query to include columns named SellStartYear and SellStartMonth 
--containing the year and month in which Adventure Works started selling each product. 
--The month should be displayed as the month name (for example, ‘January’).
SELECT ProductID,
	UPPER(NAME) AS ProductName,
	ROUND(Weight, 0) AS ApproxWeight,
	YEAR(SellStartDate) as SellStartYear,
	DATENAME(MONTH, SellStartDate) as SellStartMonth
FROM SalesLT.Product SellStartDate;

--3 Extend your query to include a column named ProductType that contains 
--the leftmost two characters from the product number.
SELECT ProductID,
	UPPER(NAME) AS ProductName,
	ROUND(Weight, 0) AS ApproxWeight,
	YEAR(SellStartDate) as SellStartYear,
	DATENAME(MONTH, SellStartDate) as SellStartMonth,
	LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product SellStartDate;

--4 Extend your query to filter the product returned so that only 
--products with a numeric size are included.

SELECT ProductID,
	UPPER(NAME) AS ProductName,
	ROUND(Weight, 0) AS ApproxWeight,
	YEAR(SellStartDate) as SellStartYear,
	DATENAME(MONTH, SellStartDate) as SellStartMonth,
	LEFT(ProductNumber, 2) AS ProductType, Size
	--ISNUMERIC(Size)
FROM SalesLT.Product --SellStartDate;
WHERE ISNUMERIC(Size) = 1 order by size asc;

SELECT * FROM SalesLT.Product;


--Helping a friend
SELECT ProductCategoryID AS PCID, Name, ProductNumber
FROM SalesLT.Product 
WHERE ProductCategoryID IN (16, 18, 7)
AND ProductNumber LIKE 'FR%52';



--Challenge 2: Rank Customers by Revenue
--Write a query that returns a list of company names with a ranking
--of their place in a list of highest TotalDue values from the SalesOrderHeader table.
SELECT * FROM SalesLT.SalesOrderHeader
SELECT * FROM SalesLT.Customer

SELECT CompanyName, TotalDue,
RANK() OVER(ORDER BY TotalDue DESC) AS SalesRank 
FROM SalesLT.Customer
JOIN SalesLT.SalesOrderHeader on SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID;



--Challenge 3: Aggregate Product Sales
--Write a query to retrieve a list of the product names and the total revenue calculated 
--as the sum of the LineTotal from the SalesLT.SalesOrderDetail table, with the results 
--sorted in descending order of total revenue.
SELECT * FROM SalesLT.SalesOrderDetail;
SELECT P.Name AS ProductName, 
       SUM(SOD.LineTotal) AS TotalSales
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P ON SOD.ProductID = P.ProductID
GROUP BY P.Name
ORDER BY TotalSales DESC;


--4 
SELECT P.Name AS ProductName, 
       SUM(SOD.LineTotal) AS TotalSales
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P ON SOD.ProductID = P.ProductID
WHERE P.ListPrice > 1000
GROUP BY P.Name
HAVING SUM(SOD.LineTotal) > 20000
ORDER BY TotalSales DESC;
