USE AdventureWorks2019;

-- Profiler bu sorguları yakalayacak
SELECT TOP 100
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    p.FirstName,
    p.LastName
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
ORDER BY soh.TotalDue DESC;

SELECT 
    a.City,
    COUNT(*) AS SiparisSayisi,
    SUM(soh.TotalDue) AS ToplamTutar
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.BusinessEntityAddress bea ON c.PersonID = bea.BusinessEntityID
JOIN Person.Address a ON bea.AddressID = a.AddressID
GROUP BY a.City
ORDER BY ToplamTutar DESC;