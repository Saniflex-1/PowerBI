--IN PERSON DAY THREE
--CHOOSE
SELECT Name, Color, Size, ProductCategoryID,
CHOOSE(productcategoryid, 'bike', 'clothing', 'hardware', 'graphics design',
'Software', 'AI')
AS ProductCategory
from SalesLT.Product ORDER BY ProductCategoryID;

--RANK()
SELECT Name, ListPrice,
RANK() OVER(ORDER BY ListPrice DESC) AS POSITION
FROM SalesLT.Product ORDER BY ListPrice DESC;

--GROUP BY
SELECT COUNT(*) from SalesLT.SalesOrderHeader
WHERE CustomerID = 29485;

SELECT CustomerID, Count(*) AS Total_Order 
FROM SalesLT.SalesOrderHeader GROUP BY CustomerID;

SELECT name, ProductCategoryID, COUNT(*) AS TOTAL_COUNT ,
DATENAME(MONTH, SellSTARTDATE)
FROM SalesLT.Product GROUP BY ProductCategoryID, name, SellStartDate;

SELECT ProductCategoryID, COUNT(*) Product_Left
from SalesLT.Product
GROUP BY ProductCategoryID 
HAVING COUNT(*) < 5
ORDER BY COUNT(*);


--JOIN
--INNER-JOIN
--RIGHT, LEFT- OUTER
--Full


select * from SalesLT.Product;
select * from SalesLT.SalesOrderDetail;

SELECT * FROM SalesLT.SalesOrderDetail as SOD 
JOIN SalesLT.Product as p
ON SOD.ProductID = p.ProductID;

--INNER JOIN
SELECT SOD.SalesOrderDetailID, P.Name, p.color, p.ProductNumber, sod.UnitPrice, sod.OrderQty, sod.LineTotal 
FROM SalesLT.SalesOrderDetail as SOD 
JOIN SalesLT.Product as p
ON SOD.ProductID = p.ProductID ORDER BY sod.OrderQty;

--RIGHT JOIN
SELECT SOD.SalesOrderDetailID, P.Name, p.color, p.ProductNumber, sod.UnitPrice, sod.OrderQty, sod.LineTotal 
FROM SalesLT.SalesOrderDetail as SOD 
RIGHT JOIN SalesLT.Product as p
ON SOD.ProductID = p.ProductID ORDER BY sod.OrderQty;

--FULL JOIN
SELECT SOD.SalesOrderDetailID, P.Name, p.color, p.ProductNumber, sod.UnitPrice, sod.OrderQty, sod.LineTotal 
FROM SalesLT.SalesOrderDetail as SOD 
FULL JOIN SalesLT.Product as p
ON SOD.ProductID = p.ProductID ORDER BY sod.OrderQty;

