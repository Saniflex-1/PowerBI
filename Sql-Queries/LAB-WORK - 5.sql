--IN PERSON LAB WORK DAY 4
--Challenge 1: Retrieve Product Price Information
use AdventureWorksLT2022;
SELECT * FROM SalesLT.Product 
WHERE ListPrice > (SELECT * 
FROM SalesLT.SalesOrderDetail ) order by ListPrice asc; --can also be AVG()

--2Retrieve the product ID, name, and list price for each product where 
--the list price is $100 or more, and the product has been sold for 
--less than $100.
SELECT ProductID, Name, ListPrice FROM SalesLT.Product
where ListPrice >= 100 and ProductID in (SELECT ProductID 
FROM SalesLT.SalesOrderDetail 
WHERE UnitPrice <100);

--3
SELECT P.ProductID, P.Name, P.StandardCost, P.ListPrice,
    (SELECT AVG(UnitPrice)
     FROM SalesLT.SalesOrderDetail SOD
     WHERE SOD.ProductID = P.ProductID) AS AvgSellingPrice
FROM SalesLT.Product P;

--4
SELECT P.ProductID, P.Name, P.StandardCost, P.ListPrice,
    (SELECT AVG(UnitPrice)
     FROM SalesLT.SalesOrderDetail SOD
     WHERE SOD.ProductID = P.ProductID) AS AvgSellingPrice
FROM SalesLT.Product P
HAVING P.StandardCost > (
    SELECT AVG(UnitPrice)
    FROM SalesLT.SalesOrderDetail SOD
    WHERE SOD.ProductID = P.ProductID
);
