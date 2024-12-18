--IN PERSON DAY 6 LAB WORK
SELECT a.CountryRegion, 
       a.StateProvince, 
       SUM(soh.TotalDue) AS Revenue
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca ON a.AddressID = ca.AddressID
JOIN SalesLT.Customer AS c ON ca.CustomerID = c.CustomerID
JOIN SalesLT.SalesOrderHeader AS soh ON c.CustomerID = soh.CustomerID
GROUP BY GROUPING SETS (
    (a.CountryRegion, a.StateProvince),  -- Country/Region and State/Province level
    (a.CountryRegion),                    -- Country/Region subtotal
    ()                                    -- Grand total
)
ORDER BY a.CountryRegion, a.StateProvince;
