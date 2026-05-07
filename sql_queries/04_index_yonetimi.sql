USE AdventureWorks2019;

-- 1. ÖNCE: İndeks olmadan çalıştır, Execution Plan'a bak
SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    soh.ShipDate
FROM Sales.SalesOrderHeader soh
WHERE soh.OrderDate BETWEEN '2013-01-01' AND '2013-12-31'
ORDER BY soh.TotalDue DESC;

-- 2. İndeksi ekle
CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_OrderDate
ON Sales.SalesOrderHeader (OrderDate)
INCLUDE (TotalDue, ShipDate);

-- 3. SONRA: Aynı sorguyu tekrar çalıştır, Execution Plan'a bak
SELECT 
    soh.SalesOrderID,
    soh.OrderDate,
    soh.TotalDue,
    soh.ShipDate
FROM Sales.SalesOrderHeader soh
WHERE soh.OrderDate BETWEEN '2013-01-01' AND '2013-12-31'
ORDER BY soh.TotalDue DESC;