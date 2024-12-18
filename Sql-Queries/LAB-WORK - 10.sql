--LAB WORK 10
-- Insert a new order header
INSERT INTO SalesLT.SalesOrderHeader (OrderDate, DueDate, CustomerID, ShipMethod)
VALUES (GETDATE(), DATEADD(DAY, 7, GETDATE()), 1, 'CARGO TRANSPORT 5');

-- Verify the inserted row
SELECT * 
FROM SalesLT.SalesOrderHeader 
WHERE SalesOrderID = (SELECT MAX(SalesOrderID) FROM SalesLT.SalesOrderHeader);

--2
-- Insert an order detail without using variables
INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, ProductID, OrderQty, UnitPrice)
SELECT MAX(SalesOrderID),  -- Use the latest SalesOrderID
       760,                -- Replace with desired ProductID
       1,                  -- Order quantity
       782.99              -- Unit price
FROM SalesLT.SalesOrderHeader;

-- Verify the inserted order detail
SELECT * 
FROM SalesLT.SalesOrderDetail 
WHERE SalesOrderID = (SELECT MAX(SalesOrderID) FROM SalesLT.SalesOrderHeader);

--Challenge 2
-- Update bike prices without variables, using direct checks in the WHILE loop
WHILE (SELECT AVG(ListPrice) FROM SalesLT.Product AS P
       JOIN SalesLT.vGetAllCategories AS VC ON P.ProductCategoryID = VC.ProductCategoryID
       WHERE VC.ParentProductCategoryName = 'Bikes') < 2000.00
AND (SELECT MAX(ListPrice) FROM SalesLT.Product AS P
     JOIN SalesLT.vGetAllCategories AS VC ON P.ProductCategoryID = VC.ProductCategoryID
     WHERE VC.ParentProductCategoryName = 'Bikes') < 5000.00
BEGIN
    -- Update the list price of all bike products by 10%
    UPDATE P
    SET ListPrice = ListPrice * 1.10
    FROM SalesLT.Product AS P
    JOIN SalesLT.vGetAllCategories AS VC ON P.ProductCategoryID = VC.ProductCategoryID
    WHERE VC.ParentProductCategoryName = 'Bikes';
END;

-- Verify the final average and maximum prices
SELECT AVG(ListPrice) AS FinalAveragePrice, 
       MAX(ListPrice) AS FinalMaxPrice
FROM SalesLT.Product AS P
JOIN SalesLT.vGetAllCategories AS VC ON P.ProductCategoryID = VC.ProductCategoryID
WHERE VC.ParentProductCategoryName = 'Bikes';

