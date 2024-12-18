--IN PERSON DAY 5 LAB WORK --Lab 7

SELECT * FROM SalesLT.vProductModelCatalogDescription vp
join  SalesLT.Product as p on vp.ProductModelID = p.ProductModelID

SELECT ProductID, p.Name, ProductNumber, vp.Name, vp.Summary 
FROM SalesLT.Product as p
join SalesLT.vProductModelCatalogDescription  as vp on p.ProductModelID 
= vp.ProductModelID
----1
SELECT P.ProductID, 
       P.Name AS ProductName, 
       VPM.Name AS ProductModelName, 
       VPM.Summary AS ProductModelSummary
FROM SalesLT.Product P
JOIN SalesLT.vProductModelCatalogDescription VPM 
ON P.ProductModelID = VPM.ProductModelID;

--2. Function to return disticnt colors
CREATE FUNCTION fn_GetDistinctColors()
RETURNS TABLE
AS
RETURN (
	SELECT DISTINCT Color
    FROM SalesLT.Product
    WHERE Color IS NOT NULL
);
--Variable table with funtion
DECLARE @DistinctColors TABLE (Color NVARCHAR(15));
INSERT INTO @DistinctColors (Color)
SELECT Color
from fn_GetDistinctColors();

SELECT ProductID, Name, Color
FROM SalesLT.Product
WHERE Color IN (SELECT Color FROM @DistinctColors);

--without fuction

DECLARE @DistinctColor TABLE (Color NVARCHAR(15));
INSERT INTO @DistinctColor (Color)
SELECT DISTINCT Color
FROM SalesLT.Product
WHERE Color IS NOT NULL;

SELECT ProductID, Name, Color
FROM SalesLT.Product
WHERE Color IN (SELECT Color FROM @DistinctColor);
--Clean the table when you are done
DROP TABLE Distinctcolors;

--USING COMMON TABLE EXPRESSION CTE
-- Use a CTE to retrieve distinct colors and filter the product query
WITH DistinctColors AS (
    SELECT Color 
    FROM fn_GetDistinctColors()
)
SELECT ProductID, Name, Color
FROM SalesLT.Product
WHERE Color IN (SELECT Color FROM DistinctColors);

----3 list of parants categories
SELECT P.ProductID, 
       P.Name AS ProductName, 
       gac.ParentProductCategoryName AS ParentCategory, 
       gac.ProductCategoryName AS Category 
FROM SalesLT.Product as p
JOIN  ufnGetAllCategories() as GAC ON 
p.ProductCategoryID = gac.ProductCategoryID

--cross apply
SELECT P.ProductID, 
       P.Name AS ProductName, 
       PC.ParentProductCategoryName AS ParentCategory, 
       PC.ProductCategoryName AS Category
FROM SalesLT.Product P
CROSS APPLY dbo.ufnGetAllCategories() AS PC;

--CHALLENGE TWO
WITH CustomerSales AS (
    SELECT C.CustomerID CID,
           C.CompanyName + ' (' + C.FirstName + ' ' + C.LastName + ')' 
		   AS CustomerContact,
           SUM(SOH.TotalDue) AS TotalRevenue
    FROM SalesLT.Customer C
    JOIN SalesLT.SalesOrderHeader SOH ON C.CustomerID = SOH.CustomerID
    GROUP BY C.CustomerID, C.CompanyName, C.FirstName, C.LastName
)
SELECT CID, CustomerContact, TotalRevenue
FROM CustomerSales
ORDER BY TotalRevenue DESC;
