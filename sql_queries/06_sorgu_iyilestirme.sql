-- ADIM 6: Sorgu İyileştirme
-- BLM4522 - Proje 1: Performans Optimizasyonu

USE AdventureWorks2019;

-- =============================================
-- 1. KÖTÜ SORGU: SELECT * kullanımı
-- =============================================
-- Kötü: Tüm sütunları çekiyor, gereksiz veri
SELECT * FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2013-01-01' AND '2013-12-31';

-- İyi: Sadece gerekli sütunları çek
SELECT 
    SalesOrderID,
    OrderDate,
    TotalDue,
    Status
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2013-01-01' AND '2013-12-31';

-- =============================================
-- 2. KÖTÜ SORGU: Fonksiyon kullanımı WHERE'de
-- =============================================
-- Kötü: WHERE'de fonksiyon kullanmak indeksi devre dışı bırakır
SELECT 
    SalesOrderID,
    OrderDate,
    TotalDue
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2013;

-- İyi: BETWEEN kullan, indeks çalışır
SELECT 
    SalesOrderID,
    OrderDate,
    TotalDue
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2013-01-01' AND '2013-12-31';

-- =============================================
-- 3. KÖTÜ SORGU: Subquery yerine JOIN kullan
-- =============================================
-- Kötü: Her satır için ayrı subquery çalışır
SELECT 
    SalesOrderID,
    TotalDue,
    (SELECT COUNT(*) FROM Sales.SalesOrderDetail sod 
     WHERE sod.SalesOrderID = soh.SalesOrderID) AS UrunSayisi
FROM Sales.SalesOrderHeader soh
WHERE TotalDue > 1000;

-- İyi: JOIN ile tek seferde çek
SELECT 
    soh.SalesOrderID,
    soh.TotalDue,
    COUNT(sod.SalesOrderDetailID) AS UrunSayisi
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
WHERE soh.TotalDue > 1000
GROUP BY soh.SalesOrderID, soh.TotalDue;