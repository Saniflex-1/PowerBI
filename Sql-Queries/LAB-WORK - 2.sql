--IN PERSON DAY ONE LAB WORK

--CHALLENGE ONE
--1 Initially, you need to produce a list of all of you customers' locations. 
--Write a Transact-SQL query that queries the Address table and 
--retrieves all values for City and StateProvince, removing duplicates.
SELECT City, StateProvince FROM SalesLT.Address --This list all location
SELECT DISTINCT City, StateProvince --This removes duplication
FROM SalesLT.Address ORDER BY City; 

--2 Transportation costs are increasing and you need to identify 
--the heaviest products. Retrieve the names of the top ten percent of products by weight.
SELECT TOP 10 PERCENT Name, Weight
FROM SalesLT.Product
ORDER BY Weight DESC;



--3 The heaviest ten products are transported by a specialist 
--carrier, therefore you need to modify the previous query to 
--list the heaviest 100 products not including the heaviest ten.
SELECT Name, Weight
FROM SalesLT.Product
WHERE Weight NOT IN (SELECT TOP 10 Weight FROM SalesLT.Product ORDER BY Weight DESC)
ORDER BY Weight DESC
OFFSET 0 ROWS FETCH NEXT 100 ROWS ONLY;
----same
SELECT Name, weight from SalesLT.Product
order by Weight desc offset 10 rows fetch next 100 rows only


--CHALLENGE 2
--1 you need to find the names, colors, and sizes of the products with a productmodelID1.
SELECT * FROM SalesLT.Product;
SELECT ProductModelID, Name, Color, Size 
FROM SalesLT.Product
WHERE ProductModelID = 1;

--2 Retrieve the product number and name of the products that have a 
--color of 'black', 'red', or 'white' and a size of 'S' or 'M'.
SELECT Name, ProductNumber, Color, Size 
FROM SalesLT.Product
WHERE Color IN ('black', 'red', 'white') --OR Color IN ('white')
AND Size IN ('s', 'm') order by color --OR size IN ('m');

--3 Retrieve the product number, name, and list price of products 
--whose product number begins 'BK-' LIKE use to perform pattern matching
--and help 

SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-%';

--4
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-[^R]%-__';
--Alternative
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-[^R]%';
--Alternative
SELECT ProductNumber, name, ListPrice 
FROM SalesLT.Product
WHERE ProductNumber NOT LIKE 'BK-R%' 
and ProductNumber like 'BK%-__';

