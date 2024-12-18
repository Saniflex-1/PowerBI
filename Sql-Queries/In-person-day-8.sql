--IN PERSON DAY 8

--Variablles

DECLARE @color VARCHAR(15) = 'Black', @Size VARCHAR(5) = 'L';
SELECT * FROM SalesLT.Product where color = @color 
	and size = @Size

-- IF ELSE, CONDITIONAL QUERY
DECLARE @color VARCHAR(20) = 'BLack';
IF @color = 'Black'
	select * FROM SalesLT.Product 
	where color = @color
Else 
	SELECT * FROM SalesLT.Product;

--------another
DECLARE @customerid INT = 1
	WHILE @customerid <= 5
	BEGIN 
	PRINT @customerid;
	SET @customerid +=1;
END;

--
CREATE PROCEDURE SalesLT.getproductcategoryid (@categoryid int = null)
AS
IF @categoryid IS NULL
	SELECT * FROM SalesLT.Product;
ELSE 
	SELECT * FROM SalesLT.Product
	where ProductCategoryID = @categoryid;

EXECUTE SalesLT.getproductcategoryid 5;