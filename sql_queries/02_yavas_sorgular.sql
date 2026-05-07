-- ADIM 2: Yavaş Sorguların Tespiti
-- BLM4522 - Proje 1: Performans Optimizasyonu

USE AdventureWorks2019;

-- 1. Tüm siparişleri ve müşteri bilgilerini getir (kasıtlı yavaş sorgu)
SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    p.FirstName,
    p.LastName,
    a.City,
    a.PostalCode
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN Person.BusinessEntityAddress bea ON p.BusinessEntityID = bea.BusinessEntityID
JOIN Person.Address a ON bea.AddressID = a.AddressID
ORDER BY soh.TotalDue DESC;

-- 2. Her şehirdeki toplam satış tutarı
SELECT 
    a.City AS Sehir,
    COUNT(soh.SalesOrderID) AS ToplamSiparis,
    SUM(soh.TotalDue) AS ToplamTutar,
    AVG(soh.TotalDue) AS OrtalamaFiyat
FROM Sales.SalesOrderHeader soh
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.BusinessEntityAddress bea ON c.PersonID = bea.BusinessEntityID
JOIN Person.Address a ON bea.AddressID = a.AddressID
GROUP BY a.City
ORDER BY ToplamTutar DESC;

-- 3. En çok satan ürünler
SELECT TOP 20
    p.Name AS UrunAdi,
    pc.Name AS Kategori,
    SUM(sod.OrderQty) AS ToplamSatis,
    SUM(sod.LineTotal) AS ToplamGelir
FROM Sales.SalesOrderDetail sod
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductCategory pc ON ps.ProductCategoryID = pc.ProductCategoryID
GROUP BY p.Name, pc.Name
ORDER BY ToplamSatis DESC;