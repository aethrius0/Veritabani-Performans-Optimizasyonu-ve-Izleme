-- ADIM 1: Veritabanı Tanıma ve DMV Sorguları
-- BLM4522 - Proje 1: Performans Optimizasyonu

USE AdventureWorks2019;

-- 1. Veritabanındaki tabloları gör
SELECT TABLE_NAME, TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES
ORDER BY TABLE_NAME;

-- 2. En büyük tabloları bul
SELECT 
    t.NAME AS TableName,
    p.rows AS RowCounts,
    SUM(a.total_pages) * 8 AS TotalSpaceKB
FROM sys.tables t
JOIN sys.indexes i ON t.object_id = i.object_id
JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
JOIN sys.allocation_units a ON p.partition_id = a.container_id
GROUP BY t.NAME, p.rows
ORDER BY TotalSpaceKB DESC;

-- 3. Aktif sorguları gör (DMV)
SELECT 
    session_id,
    status,
    command,
    wait_type,
    wait_time,
    text_data = SUBSTRING(st.text, 1, 100)
FROM sys.dm_exec_requests r
CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) st
WHERE session_id > 50;