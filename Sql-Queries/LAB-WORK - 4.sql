--Challenge 1: Generate Invoice Reports
--As an initial step towards generating the invoice report, write a query that returns 
--the company name from the SalesLT.Customer table, and the sales order ID and total due 
--from the SalesLT.SalesOrderHeader table.

SELECT c.CompanyName, soh.SalesOrderID  
FROM SalesLT.Customer AS c
JOIN  SalesLT.SalesOrderHeader AS SOH ON c.CustomerID = soh.CustomerID;

SELECT CompanyName from SalesLT.Customer
WHERE CustomerID = (SELECT salesorderID from SalesLT.SalesOrderHeader)

--2 Extend your customer orders query to include the Main Office address for each 
--customer, including the full street address, city, state or province, postal code, 
--and country or region
CREATE VIEW SalesLT.vInvoice AS
SELECT c.LastName, c.FirstName, CompanyName, soh.SalesOrderID,CONCAT(a.AddressLine1, a.City, 
a.StateProvince, a.PostalCode, a.CountryRegion) as Main_Office, totalDue
FROM SalesLT.Customer AS c
JOIN SalesLT.SalesOrderHeader as SOH on c.CustomerID = soh.CustomerID
JOIN SalesLT.CustomerAddress as CA on c.CustomerID = ca.CustomerID
JOIN SalesLT.Address as A on ca.AddressID = a.AddressID
--WHERE AddressType = 'Main Office';

SELECT MIN(Totaldue) as TotalDue from SalesLT.vInvoice;

drop view SalesLT.vInvoice







SELECT * FROM SalesLT.CustomerAddress;
SELECT * FROM SalesLT.Address;