-- UADW v1.0 - Modul Praktikum 01
CREATE SCHEMA IF NOT EXISTS src;
DROP TABLE IF EXISTS src.program_studi;
CREATE TABLE src.program_studi (kode_prodi TEXT,nama_prodi TEXT,fakultas TEXT,departemen TEXT,status TEXT);
DROP TABLE IF EXISTS src.semester;
CREATE TABLE src.semester (semester_id TEXT,tahun_akademik TEXT,term TEXT,urutan_tahun TEXT,tanggal_mulai TEXT,tanggal_selesai TEXT);
DROP TABLE IF EXISTS src.mahasiswa;
CREATE TABLE src.mahasiswa (nim TEXT,nama TEXT,jk_raw TEXT,tanggal_lahir_raw TEXT,kota_asal_raw TEXT,kode_prodi_raw TEXT,prodi_raw TEXT,angkatan TEXT,tanggal_masuk_raw TEXT,status_raw TEXT,email_kampus TEXT);
DROP TABLE IF EXISTS src.dosen;
CREATE TABLE src.dosen (nidn TEXT,nama_dosen TEXT,jk_raw TEXT,unit_prodi_raw TEXT,jabatan_akademik TEXT,tanggal_masuk_raw TEXT,status TEXT);
DROP TABLE IF EXISTS src.mata_kuliah;
CREATE TABLE src.mata_kuliah (kode_mk TEXT,nama_mk TEXT,kode_prodi TEXT,sks TEXT,semester_rekomendasi TEXT,kategori TEXT,aktif TEXT);

-- Menjalankan excercise C -Membuat data inventory
SELECT 'program_studi' AS tabel, COUNT(*) AS jumlah_baris
FROM src.program_studi
UNION ALL
SELECT 'semester', COUNT(*) FROM src.semester
UNION ALL
SELECT 'mahasiswa', COUNT(*) FROM src.mahasiswa
UNION ALL
SELECT 'dosen', COUNT(*) FROM src.dosen
UNION ALL
SELECT 'mata_kuliah', COUNT(*) FROM src.mata_kuliah;


-- NOMOR 1: Jumlah baris masing-masing tabel sumber
SELECT 'program_studi' AS tabel, COUNT(*) AS jumlah_baris FROM src.program_studi
UNION ALL
SELECT 'semester', COUNT(*) FROM src.semester
UNION ALL
SELECT 'mahasiswa', COUNT(*) FROM src.mahasiswa
UNION ALL
SELECT 'dosen', COUNT(*) FROM src.dosen
UNION ALL
SELECT 'mata_kuliah', COUNT(*) FROM src.mata_kuliah;

-- NOMOR 2: Jumlah NIM unik & bandingkan dengan total baris
SELECT
  COUNT(*) AS total_baris,
  COUNT(DISTINCT nim) AS jumlah_nim_unik,
  CASE
    WHEN COUNT(*) = COUNT(DISTINCT nim) THEN 'SAMA'
    ELSE 'TIDAK SAMA'
  END AS status_kesesuaian
FROM src.mahasiswa;

-- NOMOR 3: Jumlah baris duplikat (NIM = natural key)
SELECT
  COUNT(*) - COUNT(DISTINCT nim) AS jumlah_baris_duplikat
FROM src.mahasiswa;

-- Lihat NIM yang berulang
SELECT nim, COUNT(*) AS kemunculan
FROM src.mahasiswa
GROUP BY nim
HAVING COUNT(*) > 1
ORDER BY kemunculan DESC;

-- NOMOR 4: Rentang angkatan
SELECT
  MIN(SUBSTRING(nim FROM 1 FOR 4)) AS angkatan_terlama,
  MAX(SUBSTRING(nim FROM 1 FOR 4)) AS angkatan_terbaru
FROM src.mahasiswa;

-- NOMOR 5: Mahasiswa dengan kota_asal_raw kosong
SELECT COUNT(*) AS jumlah_kota_asal_kosong
FROM src.mahasiswa
WHERE kota_asal_raw IS NULL
   OR kota_asal_raw = ''
   OR TRIM(kota_asal_raw) = '';

-- NOMOR 6: Label prodi_raw vs program studi canonical
SELECT COUNT(DISTINCT prodi_raw) AS jumlah_label_prodi_raw FROM src.mahasiswa;

SELECT COUNT(*) AS jumlah_program_studi_resmi FROM src.program_studi;

SELECT DISTINCT prodi_raw
FROM src.mahasiswa
ORDER BY prodi_raw;

-- NOMOR 7: Tiga pola data belum siap masuk Dimension Table
-- Pola 1 -Duplikasi NIM
SELECT COUNT(*) - COUNT(DISTINCT nim) AS duplikat_nim FROM src.mahasiswa;

-- Pola 2 -Format tanggal masih teks
SELECT DISTINCT tanggal_lahir_raw
FROM src.mahasiswa
WHERE tanggal_lahir_raw IS NOT NULL
LIMIT 10;

-- Pola 3 -Kode prodi tidak terhubung
SELECT COUNT(DISTINCT kode_prodi_raw) AS kode_tidak_terdaftar
FROM src.mahasiswa m
WHERE NOT EXISTS (
  SELECT 1 FROM src.program_studi p WHERE p.kode_prodi = m.kode_prodi_raw
);



