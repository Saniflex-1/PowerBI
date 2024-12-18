--LAB WORK 9
--Challenge 1
SELECT * FROM SalesLT.Product where ProductCategoryID = 37;
--Inserting into product table
INSERT INTO SalesLT.Product
(Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES ('LED Lights', 'LT-L123', 2.56, 12.99, 37, GETDATE());
--run a query to view the row for the product in the SalesLT.Product table.
SELECT * FROM SalesLT.Product 
WHERE ProductNumber = 'lt-l123';

--2. Insert a new category with two products
-- Insert the new category
INSERT INTO SalesLT.ProductCategory (ParentProductCategoryID, Name)
VALUES (4, 'Bells and Horns');

SELECT * FROM SalesLT.ProductCategory
INSERT INTO SalesLT.Product 
(Name, ProductNumber, StandardCost, ListPrice, ProductCategoryID, SellStartDate)
VALUES ('Bicycle Bell', 'BB-RING', 2.47, 4.99, 4, GETDATE()),
		('Bicycle Horn', 'BB-PARP', 1.29, 3.75, 4, GETDATE());
--
SELECT * FROM SalesLT.Product WHERE ProductCategoryID =4;

--CHAENGE 2
--1
-- Increase the ListPrice by 10% for all products in Bells and Horns category
UPDATE SalesLT.Product
SET ListPrice = ListPrice * 1.10
WHERE ProductCategoryID = 4;

-- Verify the updated prices
SELECT ProductID, Name, ListPrice 
FROM SalesLT.Product 
WHERE ProductCategoryID = 4;

--2
-- Set DiscontinuedDate to today for all products in the Lights category 
--except the new LED Lights product
UPDATE SalesLT.Product
SET DiscontinuedDate = GETDATE()
WHERE ProductCategoryID = 37 
AND ProductNumber <> 'LT-L123';

-- Verify discontinued products
SELECT ProductID, Name, DiscontinuedDate 
FROM SalesLT.Product 
WHERE ProductCategoryID = 37;

--CHALLENGE 3
-- Delete products in the Bells and Horns category
DELETE FROM SalesLT.Product 
WHERE ProductCategoryID = 4;

-- Delete the Bells and Horns category itself
DELETE FROM SalesLT.ProductCategory 
WHERE ParentProductCategoryID = 4;

-- Verify deletion
SELECT * 
FROM SalesLT.Product 
WHERE ProductCategoryID = 4;
SELECT * 
FROM SalesLT.ProductCategory 
WHERE ProductCategoryID = 4;





