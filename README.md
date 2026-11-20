# HealthOne Medical Database System

Repositori ini berisi rancangan basis data (Conceptual/Logical ERD, Relational Model, dan DDL SQL) untuk studi kasus **HealthOne Medical Database** sebagai bagian dari tugas **UAS Bayangan — Sistem Basis Data** (Oracle Academy Database Design Project).

## Identitas Mahasiswa
* **Nama:** [Isi Nama Lengkap]
* **NIM:** [Isi NIM]
* **Kelas:** [Isi Kelas]
* **Mata Kuliah:** Sistem Basis Data
* **Dosen Pengampu:** Rizal Broer Bahaweres

## Isi Repositori
* `healthone-medical.dmd` & folder `healthone-medical/` — File proyek asli hasil pemodelan menggunakan **Oracle SQL Developer Data Modeler** (Logical Model & Relational Model).
* `healthone-medical.sql` — Script *Data Definition Language* (DDL) Oracle Database untuk membangun skema tabel fisik.
* `laporan-healthone-medical.pdf` *(atau `.docx`)* — Dokumentasi lengkap perancangan basis data mulai dari analisis kebutuhan bisnis, aturan dan asumsi, normalisasi 1NF–3NF, ERD, hingga pemetaan tabel relasional beserta *screenshot* pengerjaan.

## Fitur Utama Rancangan Basis Data
* **Normalisasi 3NF:** Pemisahan entitas master seperti `INSURANCE_COMPANY` (3NF) dan `DRUG` (2NF) untuk menghindari redundansi data.
* **Supertype & Subtype (`OFFICE_VISIT`):** Mengakomodasi kunjungan keluhan baru (`NEW_ISSUE_VISIT`), kunjungan lanjutan (`FOLLOW_UP_VISIT`), dan pemeriksaan rutin (`ROUTINE_CHECKUP`) yang diimplementasikan dengan metode *Single-Table Implementation*.
* **Exclusive Arc (`PRESCRIPTION`):** Memisahkan kategori resep dapat diisi ulang (`REFILLABLE_RX`) dan tidak dapat diisi ulang (`NON_REFILLABLE_RX`).
* **Recursive Relationship (`PATIENT`):** Melacak pemegang polis asuransi utama dalam satu tanggungan keluarga.
* **Historical Data (`PCP_HISTORY`):** Mencatat riwayat pergantian dokter layanan utama (*Primary Care Physician*) setiap pasien beserta rentang tanggalnya.
