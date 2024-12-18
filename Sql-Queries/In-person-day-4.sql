--IN PERSON DAY 4
--SUB QUERIES -- NESTED

SELECT * FROM SalesLT.SalesOrderDetail
WHERE SalesOrderID = (SELECT Max(SalesOrderID) FROM SalesLT.SalesOrderDetail);
--eg2
SELECT * FROM SalesLT.SalesOrderDetail
WHERE SalesOrderID IN (SELECT TOP 5 SalesOrderID from SalesLT.SalesOrderDetail 
ORDER BY SalesOrderID desc);

SELECT top 1 * FROM SalesLT.Product as sp
JOIN SalesLT.SalesOrderDetail as sod on sp.ProductID = sod.ProductID
--order by LineTotal desc
where linetotal = (select max(linetotal) from SalesLT.SalesOrderDetail);

SELECT * FROM SalesLT.Product 
WHERE ProductID = (SELECT TOP 1 ProductID from SalesLT.SalesOrderDetail);

