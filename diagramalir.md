# 📊 Diagram Alir Smart Contract `HakVotingSaham`

```
                        ┌─────────────────────────┐
                        │         MULAI           │  ← Terminal (Oval)
                        └────────────┬────────────┘
                                     │
                        ┌────────────▼────────────┐
                        │  Deploy Smart Contract  │  ← Proses (Persegi)
                        │  owner = msg.sender     │
                        └────────────┬────────────┘
                                     │
                   ┌─────────────────▼──────────────────┐
                   │  INPUT: Pilih Fungsi yang Dipanggil │  ← Input/Output (Jajaran Genjang)
                   └──┬──────────┬──────────┬───────────┘
                      │          │          │
         ─────────────┘          │          └─────────────
        │                        │                        │
        ▼                        ▼                        ▼
 ╔══════════════╗      ╔══════════════════╗      ╔══════════════════╗
 ║ ALUR 1:      ║      ║ ALUR 2:          ║      ║ ALUR 3:          ║
 ║ Tambah       ║      ║ Mulai & Proses   ║      ║ Lihat Hasil      ║
 ║ Pemegang     ║      ║ Voting           ║      ║ Voting           ║
 ║ Saham        ║      ║                  ║      ║                  ║
 ╚══════════════╝      ╚══════════════════╝      ╚══════════════════╝
```

---

## 🔷 ALUR 1 — Tambah Pemegang Saham

```
  ╱                           ╲
 ╱  INPUT: alamat, nama,       ╲   ← Input (Jajaran Genjang)
╲   jumlahSaham                ╱
 ╲                            ╱
              │
   ┌──────────▼──────────┐
   │  msg.sender == owner?│   ← Keputusan (Belah Ketupat)
   └──────┬──────┬────────┘
         YA     TIDAK
          │        │
          │    ╱        ╲
          │   ╱  OUTPUT:  ╲
          │  ╲  "Hanya    ╱
          │   ╲  owner"  ╱
          │        │
          │      STOP
          │
  ┌───────▼────────────────┐
  │ Simpan ke daftarSaham  │   ← Proses (Persegi)
  │ nama, jumlahSaham,     │
  │ terdaftar = true       │
  └───────┬────────────────┘
          │
   ╱               ╲
  ╱  OUTPUT:         ╲         ← Output (Jajaran Genjang)
  ╲  Data tersimpan  ╱
   ╲                ╱
          │
       [Kembali ke Menu]
```

---

## 🔷 ALUR 2 — Mulai Voting (Owner)

```
   ╱                    ╲
  ╱  INPUT: judul voting  ╲    ← Input (Jajaran Genjang)
  ╲                       ╱
   ╲                     ╱
              │
   ┌──────────▼──────────┐
   │  msg.sender == owner?│   ← Keputusan (Belah Ketupat)
   └──────┬──────┬────────┘
         YA     TIDAK → ERROR "Hanya owner"
          │
  ┌───────▼────────────────┐
  │  Buat sesi Voting baru │   ← Proses (Persegi)
  │  setuju=0,tidakSetuju=0│
  │  aktif = true          │
  └───────┬────────────────┘
          │
   ╱                    ╲
  ╱  OUTPUT: Voting aktif ╲   ← Output (Jajaran Genjang)
  ╲                       ╱
   ╲                     ╱
          │
          ▼
       [Lanjut ke Proses Voting]
```

---

## 🔷 ALUR 3 — Pemegang Saham Melakukan Voting

```
   ╱                           ╲
  ╱  INPUT: pilihan (true/false) ╲  ← Input (Jajaran Genjang)
  ╲                              ╱
   ╲                            ╱
                │
   ┌────────────▼─────────────┐
   │  Apakah terdaftar?       │  ← Keputusan (Belah Ketupat)
   └──────┬───────────┬───────┘
         YA          TIDAK
          │             │
          │        ╱         ╲
          │       ╱  OUTPUT:   ╲
          │       ╲  "Bukan    ╱
          │        ╲ pemegang ╱
          │             │
          │           STOP
          │
   ┌──────▼────────────────────┐
   │  Apakah sudah voting?     │  ← Keputusan (Belah Ketupat)
   └──────┬───────────┬────────┘
         TIDAK       YA → ERROR "Sudah voting"
          │
   ┌──────▼────────────────────┐
   │  Apakah voting aktif?     │  ← Keputusan (Belah Ketupat)
   └──────┬───────────┬────────┘
         YA          TIDAK → ERROR "Voting tidak aktif"
          │
   ┌──────▼────────────────────┐
   │  hakSuara = jumlahSaham   │  ← Proses (Persegi)
   └──────┬────────────────────┘
          │
   ┌──────▼────────────────────┐
   │  pilihan == true?         │  ← Keputusan (Belah Ketupat)
   └──────┬───────────┬────────┘
         YA          TIDAK
          │             │
  ┌───────▼──────┐  ┌───▼──────────────┐
  │ setuju +=    │  │ tidakSetuju +=    │  ← Proses (Persegi)
  │ hakSuara     │  │ hakSuara          │
  └───────┬──────┘  └───┬──────────────┘
          └──────┬───────┘
                 │
  ┌──────────────▼──────────────┐
  │  sudahVoting[msg.sender]    │  ← Proses (Persegi)
  │  = true                     │
  └──────────────┬──────────────┘
                 │
          ╱              ╲
         ╱  OUTPUT: Suara  ╲       ← Output (Jajaran Genjang)
         ╲  berhasil dicatat╱
          ╲               ╱
```

---

## 🔷 ALUR 4 — Tutup Voting & Lihat Hasil

```
  ┌──────────────────────────┐
  │  tutupVoting() [owner]   │  ← Proses (Persegi)
  │  aktif = false           │
  └──────────────┬───────────┘
                 │
   ╱                           ╲
  ╱  INPUT: hasilVoting()        ╲  ← Input (Jajaran Genjang)
  ╲                              ╱
   ╲                            ╱
                │
  ┌─────────────▼──────────────┐
  │  Baca data votingSaatIni   │  ← Proses (Persegi)
  └─────────────┬──────────────┘
                │
   ╱                              ╲
  ╱  OUTPUT: judul, setuju,        ╲  ← Output (Jajaran Genjang)
  ╲  tidakSetuju, status aktif     ╱
   ╲                              ╱
                │
        ┌───────▼───────┐
        │    SELESAI    │  ← Terminal (Oval)
        └───────────────┘
```

---

## 📌 Legenda Simbol Flowchart

| Simbol | Bentuk | Fungsi |
|--------|--------|--------|
| `┌──┐` Oval | **Terminal** | Mulai / Selesai |
| `┌──┐` Persegi | **Proses** | Operasi / Komputasi |
| `╱  ╲` Jajaran Genjang | **Input/Output** | Data masuk / keluar |
| `┌──┐` Belah Ketupat | **Keputusan** | Kondisi YA/TIDAK |
| `───▶` Panah | **Aliran** | Arah proses |
