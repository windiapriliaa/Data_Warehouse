# STUDI KASUS TERARAH UNIT 1.3
## Business Requirement to Data Requirement
### UADW v1.0

**Case ID:** UADW-ACAD-01  
**Fokus:** Academic Performance & On-Time Graduation  
**Tujuan:** Membantu mahasiswa menyelesaikan Unit 1.3 dengan satu kasus terintegrasi yang dapat ditelusuri dari masalah bisnis sampai kebutuhan data dan source UADW v1.0.

---

# 1. Skenario Kasus

Universitas Digital Nusantara menemukan bahwa evaluasi akademik masih banyak dilakukan secara terpisah oleh program studi. Kaprodi dapat melihat nilai mahasiswa, tetapi belum memiliki informasi terintegrasi untuk menjawab pertanyaan seperti: mata kuliah mana yang paling sering menjadi hambatan, kelompok mahasiswa mana yang perlu mendapat intervensi lebih awal, apakah aktivitas pembelajaran di LMS berkaitan dengan performa nilai, dan pola apa yang muncul pada mahasiswa yang lulus tidak tepat waktu.

Wakil Rektor Bidang Akademik meminta tim Data Warehouse menyiapkan dasar kebutuhan analitik untuk mendukung **program peningkatan keberhasilan studi dan kelulusan tepat waktu**. Tim belum diminta membangun Star Schema atau ETL. Tugas pada Unit 1.3 adalah menerjemahkan masalah tersebut menjadi kebutuhan informasi dan kebutuhan data yang dapat ditelusuri ke dataset UADW v1.0.

Keputusan yang akan didukung antara lain:

- menentukan mata kuliah yang perlu mendapat evaluasi atau program remedial;
- menentukan kelompok mahasiswa yang perlu mendapat pendampingan akademik lebih awal;
- menentukan periode/angkatan/prodi yang menunjukkan penurunan performa;
- menilai apakah aktivitas LMS dapat menjadi indikator pendukung risiko akademik;
- mengevaluasi pola yang berkaitan dengan kelulusan tepat waktu.

> **Batas kasus:** fokus utama adalah keberhasilan akademik dan kelulusan tepat waktu. Data pembayaran boleh digunakan sebagai pengayaan, tetapi tidak wajib.

---

# 2. Stakeholder Utama

Mahasiswa diminta menggunakan minimal tiga stakeholder berikut sebagai titik awal, lalu memperbaiki kebutuhan informasinya berdasarkan reasoning kelompok.

| Stakeholder | Peran dalam Kasus | Contoh Keputusan |
|---|---|---|
| Wakil Rektor Bidang Akademik | Melihat performa akademik lintas prodi | Menentukan prioritas program peningkatan keberhasilan studi |
| Ketua Program Studi | Memantau mata kuliah, cohort, dan performa mahasiswa | Menentukan mata kuliah yang perlu evaluasi/intervensi |
| Dosen Wali/Pembimbing Akademik | Mendampingi mahasiswa | Menentukan mahasiswa yang perlu konseling atau rencana perbaikan studi |

Mahasiswa boleh menambahkan stakeholder lain jika dapat menjelaskan decision supported-nya.

---

# 3. Dataset UADW yang Digunakan

Gunakan RAW DATA sebagai **read-only**. Jangan melakukan cleansing atau ETL pada Unit 1.3.

| Dataset | Kolom Kunci yang Relevan | Peran dalam Kasus |
|---|---|---|
| `mahasiswa.csv` | `nim`, `kode_prodi_raw`, `prodi_raw`, `angkatan`, `status_raw`, `kota_asal_raw` | Profil dan konteks mahasiswa |
| `krs.csv` | `krs_id`, `nim`, `kode_mk`, `semester_id`, `status_krs` | Riwayat pengambilan mata kuliah |
| `nilai.csv` | `nim`, `kode_mk`, `semester_id`, `nilai_angka`, `nilai_huruf`, `status_lulus` | Performa akademik |
| `mata_kuliah.csv` | `kode_mk`, `nama_mk`, `kode_prodi`, `sks`, `kategori` | Konteks mata kuliah |
| `semester.csv` | `semester_id`, `tahun_akademik`, `term` | Konteks waktu akademik |
| `kelulusan.csv` | `nim`, `tanggal_lulus_raw`, `ipk_final`, `masa_studi_bulan`, `status_tepat_waktu` | Outcome akhir studi |
| `aktivitas_lms.csv` | `nim`, `kode_mk`, `semester_id`, `waktu_event`, `tipe_event`, `durasi_menit`, `skor_kuis` | Aktivitas pembelajaran |

**Pengayaan opsional:** `pembayaran.csv` jika kelompok ingin menguji apakah status pembayaran relevan terhadap kebutuhan keputusan yang dipilih.

---

# 4. Problem Statement yang Harus Dibangun

Gunakan format:

> **Current condition → Problem → Impact → Analytical need**

## Contoh kerangka (bukan jawaban final)

**Current condition:** data nilai, KRS, LMS, dan kelulusan tersedia pada sumber yang berbeda.  
**Problem:** pimpinan belum memiliki analisis terintegrasi untuk mengenali mata kuliah dan kelompok mahasiswa yang berisiko menghambat keberhasilan studi.  
**Impact:** intervensi akademik cenderung reaktif dan evaluasi mata kuliah tidak selalu berbasis tren historis.  
**Analytical need:** diperlukan analisis historis dan komparatif yang menghubungkan performa nilai, riwayat pengambilan mata kuliah, aktivitas LMS, profil mahasiswa, dan outcome kelulusan.

**Tugas mahasiswa:** tulis ulang problem statement dengan bahasa kelompok sendiri dan pastikan dapat ditelusuri ke minimal tiga stakeholder.

---

# 5. Business Process yang Relevan

Mulailah dari proses bisnis, bukan nama tabel.

Kandidat proses bisnis dalam kasus ini:

1. **Pengambilan mata kuliah/KRS** – mahasiswa mengambil mata kuliah pada semester tertentu.
2. **Penilaian mahasiswa** – mahasiswa memperoleh nilai akhir untuk mata kuliah tertentu.
3. **Aktivitas pembelajaran di LMS** – mahasiswa melakukan aktivitas pembelajaran digital.
4. **Kelulusan** – mahasiswa menyelesaikan studi dan memperoleh outcome kelulusan.

**Tugas mahasiswa:** pilih minimal tiga proses dan jelaskan kaitannya dengan keputusan stakeholder.

---

# 6. Business Objectives dan Decision Requirements

## Contoh Business Objectives

Gunakan contoh berikut sebagai pemantik, lalu perbaiki/rumuskan sendiri minimal tiga objective:

- meningkatkan kemampuan program studi mengidentifikasi mata kuliah berisiko;
- mendukung intervensi akademik lebih awal untuk mahasiswa yang menunjukkan pola performa rendah;
- meningkatkan evaluasi terhadap faktor yang berkaitan dengan kelulusan tepat waktu.

## Contoh Decision Requirements

Mahasiswa harus menghasilkan minimal lima decision requirements. Contoh:

1. Kaprodi perlu menentukan mata kuliah yang memiliki ketidaklulusan tinggi secara konsisten.
2. Kaprodi perlu menentukan angkatan atau kelompok mahasiswa yang mengalami penurunan performa.
3. Dosen wali perlu mengetahui mahasiswa dengan pola gagal/ulang mata kuliah yang berulang.
4. Pimpinan akademik perlu membandingkan performa antar-prodi dan antar-semester.
5. Kaprodi perlu menilai apakah aktivitas LMS dapat digunakan sebagai informasi pendukung ketika merancang intervensi akademik.

---

# 7. Panduan Mengisi `01_Stakeholder`

## Contoh satu baris

| Stakeholder | Kebutuhan Informasi | Decision Supported | Priority |
|---|---|---|---|
| Kaprodi | Tren ketidaklulusan per mata kuliah dan semester | Menentukan mata kuliah prioritas evaluasi | High |

**Tugas mahasiswa:** lengkapi minimal tiga stakeholder. Jangan hanya menulis jabatan; jelaskan kebutuhan informasi dan keputusan yang benar-benar didukung.

---

# 8. Panduan Mengisi `02_Analytical_Questions`

Analytical Question harus spesifik, dapat diukur, dan mengarah pada analisis historis/agregatif/komparatif.

## Seed questions

Gunakan lima pertanyaan berikut sebagai titik awal. Mahasiswa harus **memperbaiki rumusan bila diperlukan dan menambah pertanyaan hingga minimal 10 AQ**.

1. Mata kuliah apa yang memiliki tingkat ketidaklulusan tertinggi per semester selama periode data yang tersedia?
2. Bagaimana tren rata-rata nilai mahasiswa berdasarkan program studi, angkatan, dan semester?
3. Mahasiswa mana yang mengambil mata kuliah yang sama lebih dari satu kali dan bagaimana hasil akhirnya?
4. Apakah mahasiswa dengan aktivitas LMS yang lebih rendah cenderung memiliki performa nilai yang lebih rendah pada mata kuliah yang sama?
5. Bagaimana pola performa akademik mahasiswa yang lulus tepat waktu dibandingkan dengan yang tidak tepat waktu?

## Empat arah pengembangan AQ

Untuk mencapai minimal 10 AQ, kembangkan pertanyaan dari:

- **Trend:** apa yang berubah dari semester ke semester?
- **Comparison:** kelompok mana yang berbeda?
- **Ranking:** siapa/apa yang tertinggi atau terendah?
- **Relationship:** pola apa yang muncul antara dua indikator?

> Hindari AQ seperti “Berapa jumlah mahasiswa?” jika tidak dikaitkan dengan keputusan tertentu.

---

# 9. Panduan Mengisi `03_KPI_Dictionary`

Mahasiswa wajib mendefinisikan minimal lima metric/KPI secara konseptual.

## Contoh KPI 1 – Course Failure Rate

**Definisi:** persentase record nilai valid yang berstatus tidak lulus untuk suatu mata kuliah dalam periode tertentu.  
**Formula konseptual:** `Failed Grade Records / Valid Grade Records × 100%`  
**Digunakan untuk:** mengidentifikasi mata kuliah prioritas evaluasi.

## Contoh KPI 2 – On-Time Graduation Rate

**Definisi:** proporsi lulusan yang berstatus tepat waktu terhadap seluruh lulusan dalam kelompok analisis.  
**Formula konseptual:** `On-Time Graduates / Total Graduates × 100%`

## KPI lain yang dapat dievaluasi mahasiswa

- Average Final Grade;
- Repeat Course Rate;
- LMS Engagement Level;
- Average Study Duration;
- At-Risk Student Count.

Mahasiswa tetap harus menuliskan **definisi, formula konseptual, grain/konteks, dan caveat** untuk KPI yang dipilih.

---

# 10. Panduan Mengisi `04_Data_Requirements`

Setiap AQ harus didekomposisi menjadi:

- **measure**;
- **context/dimension**;
- **time**;
- **filter/comparison**;
- **required data elements**.

## Contoh untuk AQ-01

**AQ-01:** Mata kuliah apa yang memiliki tingkat ketidaklulusan tertinggi per semester?

| Komponen | Kebutuhan |
|---|---|
| Measure | jumlah gagal, jumlah record nilai valid, failure rate |
| Context | mata kuliah, program studi |
| Time | semester / tahun akademik |
| Filter/Comparison | per mata kuliah; antar-semester |
| Required Data | `nim`, `kode_mk`, `semester_id`, `nilai_angka`/`status_lulus` |

**Tugas mahasiswa:** lakukan dekomposisi untuk seluruh AQ terpilih.

---

# 11. Panduan Mengisi `05_Source_Mapping`

Setiap data element harus memiliki sumber yang jelas.

## Contoh mapping

| Required Data Element | Dataset | Column | Role |
|---|---|---|---|
| mahasiswa | `nilai.csv` | `nim` | menghubungkan nilai dengan mahasiswa |
| mata kuliah | `nilai.csv` / `mata_kuliah.csv` | `kode_mk` | analytical context |
| semester | `nilai.csv` / `semester.csv` | `semester_id` | time context |
| nilai akhir | `nilai.csv` | `nilai_angka` | measure/source KPI |
| status lulus | `nilai.csv` | `status_lulus` | klasifikasi lulus/gagal |

**Tugas mahasiswa:** mapping harus sampai tingkat **dataset + column**, bukan hanya nama dataset.

---

# 12. Panduan Mengisi `06_Data_Fitness`

Gunakan temuan profiling Unit 1.2. Jangan membuat status fitness hanya berdasarkan asumsi.

Status:

- **READY** – dapat digunakan tanpa isu material pada kebutuhan yang dipilih;
- **CONDITIONALLY READY** – dapat digunakan setelah aturan/perbaikan tertentu;
- **NOT READY** – belum layak digunakan untuk kebutuhan tersebut.

## Contoh satu temuan

**Data element:** `nilai_angka`  
**Potential issue:** nilai di luar domain atau missing harus diverifikasi dari hasil profiling kelompok.  
**Possible status:** CONDITIONALLY READY jika temuan tersebut terkonfirmasi.  
**Required action:** domain validation dan missing-value policy sebelum ETL.

## Temuan yang harus dicari kembali dari Unit 1.2

Mahasiswa harus menggunakan minimal lima temuan nyata, misalnya:

- duplicate pada identifier yang seharusnya unik;
- missing value;
- inconsistent program study labels;
- nilai di luar domain atau mismatch nilai/status;
- format tanggal yang tidak seragam;
- potensi duplikasi event LMS atau KRS.

> Jangan memperbaiki data pada Unit 1.3. Tugasnya adalah menilai kelayakan dan mendefinisikan required action.

---

# 13. Panduan Mengisi `07_Candidate_Model`

Pada Unit 1.3 mahasiswa baru membuat **candidate model**, bukan Star Schema final.

## Contoh Candidate Grain 1

> **Satu nilai akhir seorang mahasiswa untuk satu mata kuliah pada satu semester.**

Candidate dimensions:

- Mahasiswa;
- Mata Kuliah;
- Semester.

Candidate fact:

- Nilai/Penilaian.

Candidate measures:

- nilai_angka;
- indikator lulus/gagal.

## Tugas mahasiswa

Buat minimal **dua candidate grain**. Candidate grain kedua dapat berasal dari:

- aktivitas LMS;
- KRS;
- kelulusan.

Jangan membuat desain fisik atau final Star Schema.

---

# 14. Panduan Mengisi `08_Traceability`

Setiap baris harus dapat dibaca end-to-end:

```text
Business Problem
      ↓
Business Objective
      ↓
Decision Requirement
      ↓
Analytical Question
      ↓
KPI / Metric
      ↓
Required Data
      ↓
Source Dataset + Column
      ↓
Data Fitness
      ↓
Candidate Model
```

## Contoh satu traceability row

| Problem | Stakeholder | Objective | Decision | AQ | KPI | Data | Source | Fitness |
|---|---|---|---|---|---|---|---|---|
| Mata kuliah berisiko belum mudah diidentifikasi | Kaprodi | Memperkuat evaluasi mata kuliah | Menentukan mata kuliah prioritas evaluasi | Mata kuliah apa yang memiliki failure rate tertinggi per semester? | Course Failure Rate | `nim`, `kode_mk`, `semester_id`, `status_lulus` | `nilai.csv` + `mata_kuliah.csv` + `semester.csv` | Ditentukan dari profiling |

**Tugas mahasiswa:** bangun traceability untuk seluruh AQ yang dipilih.

---

# 15. Mini-Workflow Penyelesaian Kasus

Gunakan urutan berikut agar tidak tersesat:

```text
1. Baca narasi kasus
        ↓
2. Tentukan stakeholder dan keputusan
        ↓
3. Rumuskan business objectives
        ↓
4. Susun 10 analytical questions
        ↓
5. Definisikan minimal 5 KPI/metric
        ↓
6. Decompose AQ menjadi kebutuhan data
        ↓
7. Map data element ke dataset + column
        ↓
8. Ambil kembali temuan profiling Unit 1.2
        ↓
9. Nilai data fitness
        ↓
10. Tentukan candidate grain/fact/dimension/measure
        ↓
11. Bangun traceability end-to-end
```

---

# 16. Pembagian Kerja Kelompok yang Disarankan

Jika dikerjakan berkelompok 3–5 mahasiswa:

| Peran | Tanggung Jawab |
|---|---|
| Business Analyst | stakeholder, objective, decision requirement |
| Analytical Designer | analytical questions dan KPI |
| Data Analyst | data requirements dan source mapping |
| Data Quality Analyst | profiling findings dan data fitness |
| Integration Reviewer | candidate model dan traceability |

Semua anggota tetap harus memahami keseluruhan alur.

---

# 17. Target Minimum Unit 1.3 pada Kasus Ini

| Luaran | Minimum |
|---|---:|
| Problem Statement | 1 |
| Business Process | 3 |
| Stakeholder | 3 |
| Business Objective | 3 |
| Decision Requirement | 5 |
| Analytical Questions | 10 |
| Metric/KPI | 5 |
| Profiling findings reused | 5 |
| Candidate Grain | 2 |
| Requirement Traceability | seluruh AQ utama |

---

# 18. Bukti yang Harus Ditunjukkan Mahasiswa

Minimal evidence:

1. hasil profiling Unit 1.2 yang dirujuk;
2. dataset/column yang mendukung setiap data requirement;
3. alasan mengapa suatu data dinilai READY / CONDITIONALLY READY / NOT READY;
4. hubungan AQ dengan stakeholder dan decision supported;
5. hubungan KPI dengan data source;
6. reasoning candidate grain/fact/dimension/measure.

---

# 19. Checklist Mahasiswa Sebelum Submit

- [ ] Problem statement mengikuti Current Condition → Problem → Impact → Analytical Need.
- [ ] Minimal 3 stakeholder dan setiap stakeholder mempunyai keputusan yang jelas.
- [ ] Minimal 3 business objectives.
- [ ] Minimal 5 decision requirements.
- [ ] Minimal 10 analytical questions yang benar-benar analitik.
- [ ] Setiap AQ memiliki stakeholder/decision supported.
- [ ] Minimal 5 KPI/metric dengan definisi dan formula konseptual.
- [ ] Setiap AQ dipecah menjadi data requirements.
- [ ] Setiap data element dipetakan ke dataset + column UADW.
- [ ] Minimal 5 temuan profiling Unit 1.2 digunakan kembali.
- [ ] Data fitness memiliki alasan dan required action.
- [ ] Minimal 2 candidate grain.
- [ ] Candidate model belum menjadi Star Schema final.
- [ ] Traceability dapat dibaca end-to-end.
- [ ] RAW DATA tidak dimodifikasi.

---

# 20. Kriteria Jawaban yang Baik

Jawaban yang baik **bukan** yang paling panjang. Jawaban yang baik menunjukkan rantai reasoning yang konsisten.

Contoh:

> “Kaprodi perlu menentukan mata kuliah prioritas evaluasi. Karena itu AQ difokuskan pada failure rate per mata kuliah dan semester. KPI menggunakan Course Failure Rate. Data yang diperlukan adalah kode mata kuliah, semester, dan status/nilai akhir. Data berasal dari `nilai.csv`, `mata_kuliah.csv`, dan `semester.csv`. Hasil profiling digunakan untuk menentukan apakah nilai dan status lulus siap digunakan. Candidate grain adalah satu nilai akhir mahasiswa untuk satu mata kuliah pada satu semester.”

Jawaban yang lemah:

> “Kami menggunakan tabel nilai karena tabel tersebut berisi nilai mahasiswa.”

Alasannya lemah karena tidak menunjukkan hubungan bisnis → keputusan → AQ → KPI → data.

---

# 21. Tantangan Tambahan (Opsional)

Jika kelompok menyelesaikan kasus utama lebih cepat, pilih satu:

1. Tambahkan dimensi pembayaran sebagai faktor pendukung dan tentukan apakah benar-benar relevan terhadap keputusan akademik.
2. Rancang satu AQ yang membandingkan aktivitas LMS dan outcome kelulusan tanpa menyimpulkan hubungan sebab-akibat.
3. Identifikasi AQ yang **tidak dapat dijawab dengan baik** oleh UADW v1.0 dan jelaskan data tambahan yang dibutuhkan.

---

# 22. Prinsip Penutup

> **Jangan mulai dari tabel. Mulailah dari keputusan.**

> **Setiap analytical question harus mempunyai alasan bisnis.**

> **Setiap KPI harus dapat diturunkan menjadi kebutuhan data.**

> **Setiap kebutuhan data harus dapat ditelusuri ke source.**

> **Data fitness harus didukung bukti profiling, bukan asumsi.**
