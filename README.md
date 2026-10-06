markdown
# Office Installer

Installer sederhana Microsoft Office LTSC untuk Windows menggunakan
Office Deployment Tool (ODT) resmi Microsoft.

Project ini dibuat untuk mempermudah pengguna Windows di Indonesia
melakukan instalasi Office LTSC tanpa harus membuat configuration.xml
secara manual.

---

## Fitur

Installer menyediakan pilihan:

- Office LTSC 2024
- Office LTSC 2021
- Professional Plus
- Standard
- 64-bit
- 32-bit
- Bahasa Indonesia
- English

Proses instalasi:

1. Download Office Deployment Tool
2. Pilih versi Office
3. Pilih edisi
4. Pilih arsitektur
5. Pilih bahasa
6. Membuat konfigurasi otomatis
7. Download file Office dari CDN Microsoft
8. Install Office
9. Selesai

---

## Persyaratan

Pastikan komputer memiliki:

- Windows 10 atau Windows 11
- Koneksi internet
- Hak Administrator
- Ruang penyimpanan yang cukup
- Lisensi Office LTSC yang sah

Office LTSC merupakan produk volume licensing.

Project ini tidak menyediakan lisensi Office.


# Cara Termudah

Buka PowerShell sebagai pengguna biasa kemudian jalankan:

powershell
irm https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 | iex


Setelah itu installer akan berjalan.

Windows mungkin akan menampilkan UAC untuk meminta hak Administrator.

---

# Cara Manual

Clone repository:

powershell
git clone https://github.com/FebrianSuban/office-installer.git


Masuk ke folder:

powershell
cd office-installer


Jalankan:

powershell
powershell -ExecutionPolicy Bypass -File .\Install-Office.ps1



# Office yang Didukung

## Office LTSC 2024

Professional Plus:

text
ProPlus2024Volume


Standard:

text
Standard2024Volume


Channel:

text
PerpetualVL2024


## Office LTSC 2021

Professional Plus:

text
ProPlus2021Volume


Standard:

text
Standard2021Volume


Channel:

text
PerpetualVL2021


Product ID tersebut mengikuti dokumentasi resmi Microsoft.


# Aktivasi

Installer ini TIDAK:

* memasukkan Product Key
* melakukan aktivasi
* menggunakan KMS ilegal
* menggunakan crack
* menggunakan activator
* memodifikasi file Office
* melakukan bypass lisensi

Setelah instalasi selesai, pengguna bertanggung jawab melakukan
aktivasi sesuai lisensi yang dimiliki.

Lihat:

text
docs/AKTIVASI.md


# Office Deployment Tool

Project ini menggunakan Office Deployment Tool resmi Microsoft.

Microsoft Download Center:

https://www.microsoft.com/download/details.aspx?id=49117

Dokumentasi Microsoft:

https://learn.microsoft.com/office/ltsc/2024/deploy

https://learn.microsoft.com/office/ltsc/2021/deploy


# Struktur Repository

text
office-installer/
│
├── Install-Office.ps1
├── README.md
├── LICENSE
├── .gitignore
│
├── config/
│   ├── README.md
│   └── examples/
│       ├── ltsc-2024-proplus.xml
│       ├── ltsc-2024-standard.xml
│       ├── ltsc-2021-proplus.xml
│       └── ltsc-2021-standard.xml
│
└── docs/
    ├── INSTALASI.md
    ├── AKTIVASI.md
    └── TROUBLESHOOTING.md


# Catatan Lisensi

Project ini hanya menyediakan script deployment.

Microsoft Office bukan bagian dari repository ini.

File instalasi Office diambil melalui Office Deployment Tool
dan CDN Microsoft.

Jangan mengunggah file instalasi Office ke repository GitHub.


# Disclaimer

Project ini bukan produk resmi Microsoft.

Microsoft Office dan Office Deployment Tool merupakan produk dan
merek dagang Microsoft.

Project ini hanya menyediakan script untuk membantu proses deployment.

