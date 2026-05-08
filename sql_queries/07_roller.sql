-- ADIM 7: Veri Yöneticisi Rolleri ve Erişim Yönetimi
-- BLM4522 - Proje 1: Performans Optimizasyonu

USE AdventureWorks2019;

-- =============================================
-- 1. YENİ KULLANICILAR OLUŞTUR
-- =============================================

-- Önce login oluştur (sunucu seviyesi)
CREATE LOGIN ReadOnlyUser WITH PASSWORD = 'Readonly123!';
CREATE LOGIN DataAnalystUser WITH PASSWORD = 'Analyst123!';
CREATE LOGIN DBAdminUser WITH PASSWORD = 'Admin123!';

-- Sonra database kullanıcısı oluştur
CREATE USER ReadOnlyUser FOR LOGIN ReadOnlyUser;
CREATE USER DataAnalystUser FOR LOGIN DataAnalystUser;
CREATE USER DBAdminUser FOR LOGIN DBAdminUser;

-- =============================================
-- 2. ROLLER OLUŞTUR
-- =============================================

-- Sadece okuma yapabilen rol
CREATE ROLE SatisRaporlama;

-- Veri analisti rolü
CREATE ROLE VeriAnalisti;

-- Veritabanı yönetici rolü
CREATE ROLE DBYonetici;

-- =============================================
-- 3. ROLLERİN YETKİLERİNİ AYARLA
-- =============================================

-- SatisRaporlama: Sadece Sales tabloları okuyabilir
GRANT SELECT ON SCHEMA::Sales TO SatisRaporlama;

-- VeriAnalisti: Sales ve Production okuyabilir
GRANT SELECT ON SCHEMA::Sales TO VeriAnalisti;
GRANT SELECT ON SCHEMA::Production TO VeriAnalisti;

-- DBYonetici: Her şeyi yapabilir
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Sales TO DBYonetici;
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::Production TO DBYonetici;

-- =============================================
-- 4. KULLANICILARI ROLLERE EKLE
-- =============================================
ALTER ROLE SatisRaporlama ADD MEMBER ReadOnlyUser;
ALTER ROLE VeriAnalisti ADD MEMBER DataAnalystUser;
ALTER ROLE DBYonetici ADD MEMBER DBAdminUser;

-- =============================================
-- 5. ROLLERİ VE YETKİLERİ KONTROL ET
-- =============================================

-- Rolleri listele
SELECT 
    r.name AS RolAdi,
    m.name AS KullaniciAdi
FROM sys.database_role_members rm
JOIN sys.database_principals r ON rm.role_principal_id = r.principal_id
JOIN sys.database_principals m ON rm.member_principal_id = m.principal_id
ORDER BY r.name;

-- Yetkileri listele
SELECT 
    pr.name AS PrincipalAdi,
    pe.state_desc AS YetkiDurumu,
    pe.permission_name AS Yetki,
    ISNULL(o.name, pe.class_desc) AS Nesne
FROM sys.database_permissions pe
JOIN sys.database_principals pr ON pe.grantee_principal_id = pr.principal_id
LEFT JOIN sys.objects o ON pe.major_id = o.object_id
WHERE pr.name IN ('SatisRaporlama', 'VeriAnalisti', 'DBYonetici')
ORDER BY pr.name;