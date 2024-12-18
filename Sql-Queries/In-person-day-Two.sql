--In Person Day Two

--FUNCTION

--Working with COUNT, Count is a built in function use to return the total number of rows
SELECT * FROM SalesLT.Product;
SELECT COUNT(DISTINCT Color) as Color FROM SalesLT.Product;

SELECT ProductID FROM SalesLT.SalesOrderDetail where ProductID = 926;
SELECT  COUNT(ProductID) as PRODUCTID FROM SalesLT.SalesOrderDetail
where ProductID = 926;

--count the number of customer to give more than 2000
SELECT * FROM SalesLT.SalesOrderHeader;
SELECT COUNT(TotalDue) AS TOTAL_AMOUNT FROM SalesLT.SalesOrderHeader
WHERE TotalDue > 2000;
--ADDITION
SELECT SUM(TotalDue) AS TOTAL_AMOUNT FROM SalesLT.SalesOrderHeader
WHERE TotalDue > 2000;
--FINDING MAXIMUM
SELECT MAX(TotalDue) AS TOTAL_AMOUNT FROM SalesLT.SalesOrderHeader
WHERE TotalDue > 2000;
--FINDING MIN
SELECT MIN(TotalDue) AS TOTAL_AMOUNT FROM SalesLT.SalesOrderHeader
WHERE TotalDue > 2000;
--FINDING AVERAGE
SELECT AVG(TotalDue) AS TOTAL_AMOUNT FROM SalesLT.SalesOrderHeader
WHERE TotalDue > 2000;
--SUBSTRACTION
SELECT (TotalDue) AS TOTAL_AMOUNT FROM SalesLT.SalesOrderHeader
WHERE TotalDue > 2000;
--Concatenation
SELECT Concat(LastName,' ', FirstName) AS Full_Name FROM SalesLT.Customer
ORDER BY LastName ASC;
--REPLACE
SELECT REPLACE(Title, 'Mr.', 'Master') FROM SalesLT.Customer;

--If and Only IF
SELECT TotalDue, IIF(TotalDue > 5000, 'hello world', 'lowest') 
FROM SalesLT.SalesOrderHeader ORDER BY TotalDue ASC;