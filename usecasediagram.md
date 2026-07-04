# 📐 Use Case Diagram — Smart Contract `HakVotingSaham`

---

## 🔰 Keterangan Simbol UML Use Case

| Simbol | Notasi Teks | Keterangan |
|--------|-------------|------------|
| Persegi panjang besar | `╔═ System ═╗` | **System Boundary** — batas sistem |
| Orang (stick figure) | `[Actor]` | **Actor** — pengguna/entitas luar |
| Oval/Ellipse | `( Use Case )` | **Use Case** — fungsionalitas sistem |
| Garis solid `────` | Asosiasi | Hubungan Actor → Use Case |
| Panah terbuka `- - -▶ «include»` | Include | Use Case selalu memanggil UC lain |
| Panah terbuka `- - -▶ «extend»` | Extend | Use Case opsional memperluas UC lain |
| Garis `────` generalisasi | Generalisasi | Pewarisan antar actor |

---

## 🖼️ Diagram Use Case

```
                ┌──────────────────────────────────────────────────────────────────┐
                │              « System »                                          │
                │         HakVotingSaham Smart Contract                            │
                │                                                                  │
                │                                                                  │
   ╔═════════╗  │   ╭─────────────────────────╮                                   │
   ║         ║  │   │                         │                                   │
   ║  Owner  ║──┼──▶│  tambahPemegangSaham()  │                                   │
   ║         ║  │   │                         │                                   │
   ║  (Admin)║  │   ╰─────────────────────────╯                                   │
   ║         ║  │              │                                                   │
   ║  O      ║  │              │ «include»                                         │
   ║ /|\     ║  │              ▼                                                   │
   ║  |      ║  │   ╭─────────────────────────╮                                   │
   ║ / \     ║  │   │                         │                                   │
   ╚═════════╝  │   │   validasiOnlyOwner()   │                                   │
                │   │                         │                                   │
                │   ╰─────────────────────────╯                                   │
                │              ▲                                                   │
                │              │ «include»                                         │
   ╔═════════╗  │              │                                                   │
   ║         ║  │   ╭──────────┴──────────────╮                                   │
   ║  Owner  ║──┼──▶│                         │                                   │
   ║         ║  │   │      mulaiVoting()      │                                   │
   ║  (Admin)║  │   │                         │                                   │
   ║         ║  │   ╰─────────────────────────╯                                   │
   ║  O      ║  │                                                                  │
   ║ /|\     ║  │   ╭─────────────────────────╮                                   │
   ║  |      ║──┼──▶│                         │                                   │
   ║ / \     ║  │   │      tutupVoting()      │                                   │
   ╚═════════╝  │   │                         │                                   │
                │   ╰─────────────────────────╯                                   │
                │              │                                                   │
                │              │ «extend»                                          │
                │              ▼                                                   │
                │   ╭─────────────────────────╮                                   │
                │   │                         │                                   │
                │   │     hasilVoting()       │◀──────────────────────────────┐   │
                │   │                         │                               │   │
                │   ╰─────────────────────────╯                               │   │
                │                                                             │   │
                │                                                             │   │
                │   ╭─────────────────────────╮                               │   │
   ╔══════════════╗  │                         │  «include»                    │   │
   ║              ║─┼▶│       voting()          │───────────────────────────────┘   │
   ║  Pemegang    ║  │                         │                                   │
   ║  Saham       ║  ╰─────────────────────────╯                                   │
   ║              ║              │                                                  │
   ║  O           ║              │ «include»                                        │
   ║ /|\          ║              ▼                                                  │
   ║  |           ║  ╭─────────────────────────╮                                   │
   ║ / \          ║  │                         │                                   │
   ╚══════════════╝  │  validasiPemegangSaham()│                                   │
                │   │  - terdaftar?            │                                   │
                │   │  - sudahVoting?          │                                   │
                │   │  - votingAktif?          │                                   │
                │   ╰─────────────────────────╯                                   │
                │                                                                  │
                │   ╭─────────────────────────╮                                   │
   ╔══════════════╗  │                         │                                   │
   ║  Pemegang    ║─┼▶│    lihatHakVoting()    │                                   │
   ║  Saham /     ║  │                         │                                   │
   ║  Owner       ║  ╰─────────────────────────╯                                   │
   ║              ║                                                                 │
   ║  O           ║                                                                 │
   ║ /|\          ║                                                                 │
   ║  |           ║                                                                 │
   ║ / \          ║                                                                 │
   ╚══════════════╝                                                                 │
                │                                                                  │
                └──────────────────────────────────────────────────────────────────┘
```

---

## 👥 Daftar Actor

| Actor | Peran |
|-------|-------|
| **Owner (Admin)** | Deployer kontrak. Memiliki hak eksklusif mengelola data saham dan sesi voting |
| **Pemegang Saham** | Entitas terdaftar yang berhak memberikan suara sesuai jumlah saham |

---

## 📋 Daftar Use Case

| ID | Use Case | Actor | Keterangan |
|----|----------|-------|------------|
| UC-01 | `tambahPemegangSaham()` | Owner | Mendaftarkan alamat wallet sebagai pemegang saham |
| UC-02 | `mulaiVoting()` | Owner | Membuat sesi voting baru dengan judul tertentu |
| UC-03 | `tutupVoting()` | Owner | Menonaktifkan sesi voting yang sedang berjalan |
| UC-04 | `voting()` | Pemegang Saham | Memberikan suara setuju/tidak sesuai bobot saham |
| UC-05 | `lihatHakVoting()` | Owner / Pemegang Saham | Melihat jumlah hak suara suatu alamat |
| UC-06 | `hasilVoting()` | Owner / Pemegang Saham | Melihat rekap hasil voting (setuju, tidak, status) |
| UC-07 | `validasiOnlyOwner()` | Sistem | «include» — Validasi bahwa pemanggil adalah owner |
| UC-08 | `validasiPemegangSaham()` | Sistem | «include» — Validasi terdaftar, belum voting, voting aktif |

---

## 🔗 Relasi Antar Use Case

| Relasi | Dari | Ke | Tipe |
|--------|------|----|------|
| Owner memanggil | Owner | UC-01, UC-02, UC-03 | **Asosiasi** |
| Pemegang Saham memanggil | Pemegang Saham | UC-04, UC-05, UC-06 | **Asosiasi** |
| UC-01 selalu validasi owner | UC-01 | UC-07 | **«include»** |
| UC-02 selalu validasi owner | UC-02 | UC-07 | **«include»** |
| UC-03 selalu validasi owner | UC-03 | UC-07 | **«include»** |
| UC-04 selalu validasi pemegang | UC-04 | UC-08 | **«include»** |
| UC-04 menampilkan hasil | UC-04 | UC-06 | **«include»** |
| UC-03 memicu lihat hasil | UC-03 | UC-06 | **«extend»** |
