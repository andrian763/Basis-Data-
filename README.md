# Sistem Basis Data Apotek Digital

Proyek ini merupakan sistem basis data untuk apotek digital yang mencakup fitur pembelian obat, konsultasi dokter, serta pengelolaan saldo dan top-up pengguna. Sistem ini dikembangkan menggunakan PostgreSQL dan disusun sebagai tugas besar mata kuliah **Basis Data**.

---

## 🧱 Struktur Sistem

Sistem terdiri dari beberapa entitas utama yang saling berelasi, antara lain:
- `users` – menyimpan data pengguna
- `dokter` – daftar dokter yang tersedia
- `obat` – informasi obat yang dijual
- `pesanan` – data transaksi pembelian obat
- `detailpesanan` – rincian setiap item dalam pesanan
- `konsultasi` – data konsultasi antara dokter dan pasien
- `saldo` & `topup` – pencatatan saldo dan top-up oleh pengguna

Diagram ERD dan hasil normalisasi telah dilampirkan untuk mendukung struktur basis data.

---

## 🔧 Tools & Teknologi

- **Database**: PostgreSQL
- **Bahasa SQL**: DDL, DML, dan Stored Procedure
- **Perangkat Tambahan**: 
  - PGAdmin (opsional)
  - DB Designer untuk ERD
  - Spreadsheet untuk dokumentasi normalisasi

---
