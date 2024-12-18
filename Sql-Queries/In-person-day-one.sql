--Customer Table
SELECT * FROM SalesLT.Customer;
SELECT Title, LastName FROM SalesLT.Customer;

--USE TO REMOVE DUPLICATE ROWS
SELECT DISTINCT Color FROM SalesLT.Product;
SELECT DISTINCT Title FROM SalesLT.Customer;
SELECT DISTINCT CompanyName FROM SalesLT.Customer;

--ORDER BY USE TO DISPLAY ROWS IN EITHER ASCENDING(ASC) OR DESCENDING(DESC) ORDER
SELECT Name, ProductNumber, color, ListPrice AS Price FROM SalesLT.Product
ORDER BY Price DESC;

--SalesOrderDetails This display all attribute queried in descending order
SELECT SalesOrderDetailID, OrderQty, UnitPrice, LineTotal AS LT 
FROM SalesLT.SalesOrderDetail ORDER BY LT DESC;

--The Below Query Display the most sold products alongside with its details
--SELECT MAX(LineTotal) FROM SalesLT.SalesOrderDetail;
SELECT * FROM SalesLT.SalesOrderDetail
WHERE LineTotal = (SELECT MAX(LineTotal) FROM SalesLT.SalesOrderDetail);
 
 --QUERY TO DISPLAY LAST NAME IN ALPHABETICAL ORDER
 SELECT Title, LastName, FirstName FROM SalesLT.Customer 
 WHERE Title = 'Mr.' order by LastName asc;

 --QUERY TO DISPLAY THE TOP MOST 10 LINES OF ROWS
 SELECT TOP 10 CustomerID, TotalDue 
 FROM SalesLT.SalesOrderHeader ORDER BY TotalDue DESC;

 --QUERY TO SKIP TO SKIP A SPECIFIED NUUMBER OF ROWS BEFORE STARTING TO RETURN A ROW
 SELECT CustomerID, TotalDue 
 FROM SalesLT.SalesOrderHeader ORDER BY TotalDue DESC OFFSET 5 ROWS;

 --Using the
 SELECT Color FROM SalesLT.Product
 WHERE Color <> 'red';

 SELECT color FROM SalesLT.Product
 WHERE Color NOT IN ('red', 'black');

  SELECT color FROM SalesLT.Product
 WHERE Color = 'black';

 SELECT LineTotal FROM SalesLT.SalesOrderDetail
 WHERE LineTotal BETWEEN 5000 AND 6000;