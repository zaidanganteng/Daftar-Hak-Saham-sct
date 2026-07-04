# 📋 Laporan Hasil Pengujian Smart Contract
## `HakVotingSaham` — Solidity ^0.8.19

---

## 📌 Informasi Umum

| Item | Keterangan |
|------|------------|
| **Nama Kontrak** | HakVotingSaham |
| **Versi Solidity** | ^0.8.19 |
| **Jaringan Uji** | Remix VM (Cancun) |
| **Tanggal Pengujian** | 2025 |
| **Penguji** | Developer / Owner |
| **Total Test Case** | 35 |

---

## 1️⃣ Pengujian Fungsional

> Memastikan setiap fungsi berjalan sesuai spesifikasi yang diharapkan.

| No | ID Test | Fungsi yang Diuji | Input | Output yang Diharapkan | Output Aktual | Status |
|----|---------|-------------------|-------|------------------------|---------------|--------|
| 1 | TC-F01 | `constructor()` | Deploy kontrak oleh akun A | `owner` = alamat akun A | `owner` tersimpan = akun A | ✅ PASS |
| 2 | TC-F02 | `tambahPemegangSaham()` | alamat=0xABC, nama="Budi", saham=1000 | Data tersimpan di `daftarSaham` | `terdaftar=true`, nama="Budi", saham=1000 | ✅ PASS |
| 3 | TC-F03 | `tambahPemegangSaham()` | Tambah pemegang saham kedua, saham=500 | Data pemegang ke-2 tersimpan | Data tersimpan dengan benar | ✅ PASS |
| 4 | TC-F04 | `lihatHakVoting()` | alamat pemegang terdaftar | Mengembalikan jumlahSaham | Nilai saham = 1000 | ✅ PASS |
| 5 | TC-F05 | `mulaiVoting()` | judul="Ekspansi Bisnis 2025" | `votingSaatIni.aktif = true`, setuju=0, tidakSetuju=0 | Voting aktif, semua nilai 0 | ✅ PASS |
| 6 | TC-F06 | `voting()` | pilihan=`true` (setuju), pemegang saham=1000 | `setuju += 1000`, `sudahVoting=true` | setuju=1000, sudahVoting=true | ✅ PASS |
| 7 | TC-F07 | `voting()` | pilihan=`false` (tidak setuju), pemegang saham=500 | `tidakSetuju += 500` | tidakSetuju=500 | ✅ PASS |
| 8 | TC-F08 | `tutupVoting()` | Dipanggil oleh owner | `votingSaatIni.aktif = false` | aktif=false | ✅ PASS |
| 9 | TC-F09 | `hasilVoting()` | — (view function) | Mengembalikan judul, setuju, tidakSetuju, aktif | Data sesuai state terakhir | ✅ PASS |
| 10 | TC-F10 | `daftarSaham` (public mapping) | Akses langsung via alamat | Mengembalikan struct PemegangSaham | Data struct tampil lengkap | ✅ PASS |

---

## 2️⃣ Pengujian Boundary Value (Nilai Batas)

> Menguji perilaku sistem pada nilai-nilai ekstrem (minimum, maksimum, dan batas tepi).

| No | ID Test | Fungsi | Kondisi Batas | Input | Output yang Diharapkan | Output Aktual | Status |
|----|---------|--------|---------------|-------|------------------------|---------------|--------|
| 1 | TC-B01 | `tambahPemegangSaham()` | Jumlah saham minimum | saham = `0` | Tersimpan, hakSuara = 0 | terdaftar=true, saham=0 | ✅ PASS |
| 2 | TC-B02 | `tambahPemegangSaham()` | Jumlah saham maksimum uint256 | saham = `2^256 - 1` | Tersimpan tanpa overflow | Nilai tersimpan penuh | ✅ PASS |
| 3 | TC-B03 | `voting()` | Pemegang saham dengan saham=0 | pilihan=true | setuju += 0 (tidak berpengaruh) | setuju tidak bertambah | ✅ PASS |
| 4 | TC-B04 | `voting()` | Akumulasi suara banyak pemegang | 10 pemegang @ 1000 saham | setuju = 10.000 | Total akumulasi benar | ✅ PASS |
| 5 | TC-B05 | `mulaiVoting()` | Judul string kosong | judul = `""` | Voting terbuat dengan judul kosong | aktif=true, judul="" | ✅ PASS |
| 6 | TC-B06 | `mulaiVoting()` | Judul string sangat panjang | judul = 1000 karakter | Tersimpan (gas tinggi) | Tersimpan, gas meningkat | ✅ PASS |
| 7 | TC-B07 | `tambahPemegangSaham()` | Nama string kosong | nama = `""` | Tersimpan dengan nama kosong | terdaftar=true, nama="" | ✅ PASS |
| 8 | TC-B08 | `hasilVoting()` | Sebelum ada voting dibuat | — | Mengembalikan nilai default (0, false) | setuju=0, tidakSetuju=0, aktif=false | ✅ PASS |

---

## 3️⃣ Pengujian Exception Handling

> Memastikan kontrak melempar error yang tepat pada kondisi tidak valid.

| No | ID Test | Fungsi | Skenario Error | Input Tidak Valid | Pesan Error yang Diharapkan | Pesan Error Aktual | Status |
|----|---------|--------|----------------|-------------------|-----------------------------|--------------------|--------|
| 1 | TC-E01 | `tambahPemegangSaham()` | Dipanggil bukan oleh owner | msg.sender = akun B (bukan owner) | `"Hanya owner"` | revert: "Hanya owner" | ✅ PASS |
| 2 | TC-E02 | `mulaiVoting()` | Dipanggil bukan oleh owner | msg.sender = pemegang saham biasa | `"Hanya owner"` | revert: "Hanya owner" | ✅ PASS |
| 3 | TC-E03 | `tutupVoting()` | Dipanggil bukan oleh owner | msg.sender = akun sembarang | `"Hanya owner"` | revert: "Hanya owner" | ✅ PASS |
| 4 | TC-E04 | `lihatHakVoting()` | Alamat belum terdaftar | alamat = 0x000 (tidak terdaftar) | `"Belum terdaftar"` | revert: "Belum terdaftar" | ✅ PASS |
| 5 | TC-E05 | `voting()` | Bukan pemegang saham | msg.sender tidak ada di daftarSaham | `"Bukan pemegang saham"` | revert: "Bukan pemegang saham" | ✅ PASS |
| 6 | TC-E06 | `voting()` | Pemegang saham voting dua kali | Panggil `voting()` dua kali dari alamat sama | `"Sudah voting"` | revert: "Sudah voting" | ✅ PASS |
| 7 | TC-E07 | `voting()` | Voting belum dimulai / sudah ditutup | `votingSaatIni.aktif = false` | `"Voting tidak aktif"` | revert: "Voting tidak aktif" | ✅ PASS |
| 8 | TC-E08 | `voting()` | Voting dipanggil setelah `tutupVoting()` | Panggil voting setelah tutup | `"Voting tidak aktif"` | revert: "Voting tidak aktif" | ✅ PASS |
| 9 | TC-E09 | `tambahPemegangSaham()` | Overwrite data pemegang yang sudah ada | Daftarkan ulang alamat yang sama | Data tertimpa (tidak ada proteksi) | Data lama tertimpa | ⚠️ WARNING |

---

## 4️⃣ Pengujian State Transition (Transisi Status)

> Memastikan perubahan state kontrak berjalan sesuai urutan yang benar.

| No | ID Test | State Awal | Aksi / Fungsi | State Akhir yang Diharapkan | State Akhir Aktual | Status |
|----|---------|-----------|---------------|-----------------------------|--------------------|--------|
| 1 | TC-S01 | Kontrak baru di-deploy | `constructor()` | `owner` = deployer, tidak ada pemegang saham | owner terset, mapping kosong | ✅ PASS |
| 2 | TC-S02 | Tidak ada pemegang saham | `tambahPemegangSaham()` | `terdaftar = true`, data saham tersimpan | State berubah sesuai | ✅ PASS |
| 3 | TC-S03 | Voting belum ada (`aktif=false`) | `mulaiVoting("Judul")` | `aktif=true`, setuju=0, tidakSetuju=0 | Voting aktif | ✅ PASS |
| 4 | TC-S04 | Voting aktif | `voting(true)` oleh pemegang A | `setuju += hakSuara`, `sudahVoting[A]=true` | State terakumulasi benar | ✅ PASS |
| 5 | TC-S05 | Voting aktif, A sudah voting | `voting(false)` oleh pemegang A lagi | REVERT — state tidak berubah | State tetap, revert terjadi | ✅ PASS |
| 6 | TC-S06 | Voting aktif | `tutupVoting()` | `aktif = false` | aktif berubah jadi false | ✅ PASS |
| 7 | TC-S07 | Voting sudah tutup | `voting(true)` oleh pemegang baru | REVERT — voting tidak aktif | State tidak berubah, revert | ✅ PASS |
| 8 | TC-S08 | Voting sudah tutup | `mulaiVoting("Judul Baru")` | Voting baru dimulai, state direset | setuju=0, tidakSetuju=0, aktif=true | ✅ PASS |
| 9 | TC-S09 | Voting baru dimulai (sesi ke-2) | Pemegang A voting lagi | REVERT — `sudahVoting[A]` masih `true` dari sesi lama | Revert: "Sudah voting" | ⚠️ WARNING |
| 10 | TC-S10 | `hasilVoting()` dipanggil kapan saja | View function | Mengembalikan state saat ini tanpa mengubah apapun | State tidak berubah | ✅ PASS |

> ⚠️ **Catatan TC-S09:** Mapping `sudahVoting` tidak direset saat `mulaiVoting()` baru dipanggil. Pemegang saham yang sudah voting di sesi sebelumnya tidak bisa voting di sesi berikutnya.

---

## 5️⃣ Pengujian Keamanan (Security Testing)

> Menguji ketahanan kontrak terhadap serangan dan eksploitasi umum.

| No | ID Test | Kategori Serangan | Skenario | Metode Serangan | Hasil yang Diharapkan | Hasil Aktual | Status |
|----|---------|-------------------|----------|-----------------|----------------------|--------------|--------|
| 1 | TC-K01 | **Unauthorized Access** | Non-owner mencoba tambah pemegang saham | Panggil `tambahPemegangSaham()` dari akun lain | Revert dengan "Hanya owner" | Revert berhasil | ✅ AMAN |
| 2 | TC-K02 | **Unauthorized Access** | Non-owner mencoba mulai voting | Panggil `mulaiVoting()` dari akun lain | Revert dengan "Hanya owner" | Revert berhasil | ✅ AMAN |
| 3 | TC-K03 | **Unauthorized Access** | Non-owner mencoba tutup voting | Panggil `tutupVoting()` dari akun lain | Revert dengan "Hanya owner" | Revert berhasil | ✅ AMAN |
| 4 | TC-K04 | **Double Voting** | Pemegang saham voting lebih dari sekali | Panggil `voting()` dua kali dari alamat sama | Revert "Sudah voting" di panggilan ke-2 | Revert berhasil | ✅ AMAN |
| 5 | TC-K05 | **Sybil Attack** | Satu entitas daftarkan banyak alamat | Owner daftarkan 10 alamat berbeda milik satu orang | Tidak ada proteksi on-chain (by design) | Berhasil — perlu kontrol off-chain | ⚠️ RISIKO |
| 6 | TC-K06 | **Integer Overflow** | Akumulasi suara melebihi batas | Total saham mendekati `2^256` | Solidity 0.8.x auto-revert overflow | Revert otomatis oleh compiler | ✅ AMAN |
| 7 | TC-K07 | **Reentrancy Attack** | Kontrak berbahaya memanggil ulang fungsi | Tidak ada transfer ETH / external call | Tidak ada celah reentrancy | Tidak rentan | ✅ AMAN |
| 8 | TC-K08 | **Front-Running** | Melihat transaksi voting di mempool lalu menyalin | Monitor mempool, kirim tx dengan gas lebih tinggi | Pilihan voting terekspos di mempool | Pilihan bisa dilihat sebelum dikonfirmasi | ⚠️ RISIKO |
| 9 | TC-K09 | **Owner Privilege Abuse** | Owner overwrite data pemegang saham | Panggil `tambahPemegangSaham()` dua kali pada alamat sama | Data tertimpa tanpa notifikasi | Data tertimpa — tidak ada event log | ⚠️ RISIKO |
| 10 | TC-K10 | **Voting Session Reset** | Mapping `sudahVoting` tidak direset | Mulai voting baru tanpa reset `sudahVoting` | Pemegang lama tidak bisa voting lagi | Konfirmasi — bug logika ditemukan | ❌ BUG |
| 11 | TC-K11 | **Visibility Public** | Akses data sensitif via public mapping | Baca `daftarSaham[alamat]` langsung | Data saham terbaca publik (by design) | Terbaca publik — sesuai desain | ℹ️ INFO |
| 12 | TC-K12 | **Zero Address** | Daftarkan alamat `address(0)` | `tambahPemegangSaham(0x000, "Test", 100)` | Tidak ada validasi zero address | Berhasil tersimpan — tidak ada proteksi | ⚠️ RISIKO |

---

## 📊 Rekapitulasi Hasil Pengujian

| Kategori Pengujian | Total TC | ✅ PASS | ⚠️ WARNING | ❌ BUG | Persentase Lulus |
|--------------------|----------|---------|------------|--------|-----------------|
| Fungsional | 10 | 10 | 0 | 0 | **100%** |
| Boundary Value | 8 | 8 | 0 | 0 | **100%** |
| Exception Handling | 9 | 8 | 1 | 0 | **89%** |
| State Transition | 10 | 8 | 2 | 0 | **80%** |
| Keamanan | 12 | 6 | 4 | 1 | **50%** (kritis: 1 bug) |
| **TOTAL** | **49** | **40** | **7** | **1** | **82%** |

---

## 🔴 Temuan & Rekomendasi

| No | ID | Tingkat | Temuan | Rekomendasi |
|----|----|---------|--------|-------------|
| 1 | BUG-01 | 🔴 **HIGH** | Mapping `sudahVoting` tidak direset saat sesi voting baru dimulai | Tambahkan reset `sudahVoting` di fungsi `mulaiVoting()` atau gunakan ID sesi voting |
| 2 | RISK-01 | 🟡 **MEDIUM** | Tidak ada validasi `address(0)` saat mendaftarkan pemegang saham | Tambahkan `require(_alamat != address(0), "Alamat tidak valid")` |
| 3 | RISK-02 | 🟡 **MEDIUM** | Data pemegang saham bisa ditimpa tanpa notifikasi | Tambahkan event `emit` dan pengecekan `!daftarSaham[_alamat].terdaftar` |
| 4 | RISK-03 | 🟡 **MEDIUM** | Pilihan voting terekspos di mempool (front-running) | Pertimbangkan mekanisme commit-reveal scheme |
| 5 | RISK-04 | 🟠 **LOW** | Tidak ada event/log untuk setiap aksi penting | Tambahkan `event` untuk `tambahPemegangSaham`, `mulaiVoting`, `voting`, `tutupVoting` |
| 6 | RISK-05 | 🟠 **LOW** | Sybil attack tidak dapat dicegah on-chain | Implementasi whitelist atau verifikasi identitas off-chain |
