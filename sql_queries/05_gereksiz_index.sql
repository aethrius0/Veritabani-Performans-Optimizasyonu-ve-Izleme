-- ADIM 5: Gereksiz İndeksleri Bulma ve Kaldırma
-- BLM4522 - Proje 1: Performans Optimizasyonu

USE AdventureWorks2019;

-- 1. Hiç kullanılmayan indeksleri bul
SELECT 
    t.name AS TabloAdi,
    i.name AS IndexAdi,
    i.type_desc AS IndexTipi,
    ISNULL(ius.user_seeks, 0) AS Seeks,
    ISNULL(ius.user_scans, 0) AS Scans,
    ISNULL(ius.user_lookups, 0) AS Lookups,
    ISNULL(ius.user_updates, 0) AS Updates
FROM sys.indexes i
JOIN sys.tables t ON i.object_id = t.object_id
LEFT JOIN sys.dm_db_index_usage_stats ius 
    ON i.object_id = ius.object_id 
    AND i.index_id = ius.index_id
    AND ius.database_id = DB_ID()
WHERE i.name IS NOT NULL
    AND ISNULL(ius.user_seeks, 0) = 0
    AND ISNULL(ius.user_scans, 0) = 0
    AND ISNULL(ius.user_lookups, 0) = 0
ORDER BY ISNULL(ius.user_updates, 0) DESC;

-- 2. Test amaçlı gereksiz bir indeks oluştur
CREATE NONCLUSTERED INDEX IX_Test_Gereksiz
ON Sales.SalesOrderHeader (ShipDate);

-- 3. Oluşturduğumuz gereksiz indeksi kaldır
DROP INDEX IX_Test_Gereksiz ON Sales.SalesOrderHeader;

-- 4. İndeks kaldırıldı mı kontrol et
SELECT 
    i.name AS IndexAdi,
    t.name AS TabloAdi
FROM sys.indexes i
JOIN sys.tables t ON i.object_id = t.object_id
WHERE t.name = 'SalesOrderHeader'
    AND i.name IS NOT NULL
ORDER BY i.name;
