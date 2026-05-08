# BLM4522 - Proje 1: Veritabanı Performans Optimizasyonu ve İzleme

## Proje Hakkında
Bu proje, AdventureWorks2019 veritabanı üzerinde performans analizi ve 
optimizasyon tekniklerinin uygulanmasını kapsamaktadır.

## Kullanılan Teknolojiler
- Microsoft SQL Server (MSSQL)
- SQL Server Management Studio (SSMS)
- SQL Server Profiler
- AdventureWorks2019 örnek veritabanı

## Yapılan Çalışmalar

### Adım 1: Veritabanı Kurulumu
- AdventureWorks2019 veritabanı MSSQL'e restore edildi

### Adım 2: Veritabanı Tanıma ve DMV Sorguları
- Tablo boyutları incelendi
- Dynamic Management Views (DMV) ile aktif sorgular izlendi

### Adım 3: Yavaş Sorguların Tespiti
- Müşteri ve sipariş bilgilerini birleştiren karmaşık sorgular yazıldı
- Şehir bazlı satış analizleri yapıldı
- En çok satan ürünler listelendi

### Adım 4: Execution Plan Analizi
- CTRL+M ile Actual Execution Plan aktif edildi
- Hash Match, Index Scan, Clustered Index Scan operasyonları incelendi
- Missing Index uyarıları tespit edildi

### Adım 5: İndeks Ekleme ve Performans Karşılaştırması
- OrderDate sütununa NONCLUSTERED INDEX eklendi
- İndeks öncesi ve sonrası Execution Plan karşılaştırıldı
- Clustered Index Scan → Index Seek dönüşümü gözlemlendi

### Adım 6: Gereksiz İndeksleri Bulma ve Kaldırma
- Kullanılmayan indeksler DMV ile tespit edildi
- Test indeksi oluşturulup kaldırıldı

### Adım 7: Sorgu İyileştirme
- SELECT * yerine spesifik sütun seçimi
- WHERE'de fonksiyon kullanımından kaçınma
- Subquery yerine JOIN kullanımı

### Adım 8: Veri Yöneticisi Rolleri
- 3 farklı kullanıcı oluşturuldu (ReadOnly, Analyst, Admin)
- 3 farklı rol oluşturuldu (SatisRaporlama, VeriAnalisti, DBYonetici)
- Roller için şema bazlı yetkiler atandı

### Adım 9: SQL Profiler ile İzleme
- SQL Server Profiler ile trace başlatıldı
- Sorguların CPU, Reads, Duration değerleri izlendi

## Dosya Yapısı
├── adim2_dmv_sorgulari.sql
├── adim3_yavas_sorgular.sql
├── adim4_execution_plan.sql
├── adim5_index_yonetimi.sql
├── adim6_gereksiz_index.sql
├── adim7_sorgu_iyilestirme.sql
├── adim8_roller.sql
├── adim9_profiler_sorgulari.sql
└── README.md

## Sonuçlar
- İndeks eklenerek sorgu maliyeti %35 azaltıldı
- Gereksiz indeksler tespit edilip kaldırıldı
- Farklı yetki seviyelerinde kullanıcı rolleri oluşturuldu
- SQL Profiler ile sorgu performansı izlendi
