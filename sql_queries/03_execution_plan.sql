-- ADIM 3: Execution Plan Analizi
-- BLM4522 - Proje 1: Performans Optimizasyonu

USE AdventureWorks2019;

--Execution Plan, sorgumuzun arka planda nasıl çalıştığını gösterir. Hangi adımların yavaş olduğunu buradan anlarız

-- Test Sorgusu 1: Yüksek maliyetli JOIN sorgusu
SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    p.FirstName,
    p.LastName,
    a.City
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN Person.BusinessEntityAddress bea ON p.BusinessEntityID = bea.BusinessEntityID
JOIN Person.Address a ON bea.AddressID = a.AddressID
ORDER BY soh.TotalDue DESC;

-- Test Sorgusu 2: WHERE filtresi olmadan tüm tabloyu tara
SELECT * FROM Production.Product;

-- Test Sorgusu 3: WHERE ile filtreli versiyon (karşılaştır)
SELECT * FROM Production.Product
WHERE ListPrice > 1000
AND Color = 'Red';
