SELECT * FROM SalesLT.Customer


SELECT SalesOrderID, soh.CustomerID,firstname, lastname, TotalDue
from SalesLT.SalesOrderHeader as SOH
cross apply dbo.ufnGetCustomerInformation(soh.CustomerID);

SELECT SalesOrderID, soh.CustomerID, lastname, firstname, addressline1, city, TotalDue
from SalesLT.SalesOrderHeader as SOH
JOIN SalesLT.CustomerAddress ca on soh.CustomerID = ca.CustomerID
JOIN SalesLT.Address a on ca.AddressID = a.AddressID
cross apply dbo.ufnGetCustomerInformation(soh.CustomerID);


SELECT name, p.ProductID, p.ProductCategoryID
from SalesLT.Product as p
cross apply dbo.ufnGetAllCategories();

--CREATING A FUNCTION

--CREATING A FUNCTION
drop function fn_getorder
CREATE FUNCTION SalesLT.fn_getorder(@orderNumber as INTEGER)
RETURNS TABLE
AS
RETURN
(SELECT SalesOrderID, OrderDate, ShipDate, DueDate, PurchaseOrderNumber 
from SalesLT.SalesOrderHeader where SalesOrderID = @orderNumber);

SELECT * FROM SalesLT.fn_getorder(1774);