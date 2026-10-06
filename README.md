# Office Installer

Installer Microsoft Office berbasis **PowerShell** yang menggunakan **Microsoft Office Deployment Tool (ODT)**.

Installer ini dibuat untuk memudahkan pengguna Windows melakukan instalasi **Office LTSC 2024** atau **Office LTSC 2021** tanpa perlu membuat file konfigurasi XML secara manual.

---

## Cara Termudah

Ikuti langkah berikut untuk menjalankan installer Microsoft Office.

1. Buka PowerShell sebagai Administrator

Pada keyboard, tekan tombol Windows (⊞).

Kemudian ketik:

PowerShell

Setelah Windows PowerShell muncul pada hasil pencarian:

Klik kanan Windows PowerShell
Pilih Run as Administrator
Jika muncul jendela User Account Control (UAC), klik Yes

Setelah itu akan muncul jendela Windows PowerShell dengan hak Administrator.

2. Copy perintah installer

Copy perintah berikut:

irm https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 | iex

Cara menyalin:

Arahkan mouse ke kotak perintah di atas.
Klik tombol Copy yang muncul pada kotak tersebut.
Perintah akan tersalin ke clipboard.
3. Paste perintah ke PowerShell

Kembali ke jendela Windows PowerShell yang tadi dibuka sebagai Administrator.

Kemudian paste perintah yang sudah disalin.

Kamu dapat melakukan paste dengan:

Klik kanan di dalam jendela PowerShell, atau
Tekan Ctrl + V

Kemudian tekan Enter.

Setelah itu installer akan berjalan dan menampilkan menu pilihan.

Alur instalasi:

```text
Download ODT
     ↓
Pilih versi Office
     ↓
Pilih edisi Office
     ↓
Pilih arsitektur
     ↓
Pilih bahasa
     ↓
Download file Office
     ↓
Install Office
     ↓
Selesai

## Fitur

* Instalasi Office LTSC 2024
* Instalasi Office LTSC 2021
* Pilihan **Professional Plus** atau **Standard**
* Pilihan **64-bit** atau **32-bit**
* Pilihan bahasa **Indonesia** atau **English**
* Menggunakan Microsoft Office Deployment Tool (ODT)
* File Office diunduh langsung dari server Microsoft
* Tidak menyimpan installer Office berukuran besar di GitHub
* Membuat konfigurasi ODT secara otomatis
* Tidak membutuhkan pembuatan XML secara manual
* Mendukung instalasi melalui satu perintah PowerShell
* Tidak menyertakan product key
* Tidak melakukan crack atau bypass aktivasi

---

## Persyaratan

Sebelum menjalankan installer, pastikan:

* Windows 10 atau Windows 11
* Koneksi internet aktif
* PowerShell tersedia
* Memiliki hak administrator saat proses instalasi
* Ruang penyimpanan yang cukup
* Tidak sedang menjalankan proses instalasi Office lainnya

---

## Produk yang Didukung

### Office LTSC 2024

| Edisi                  | Product ID           | Channel           |
| ---------------------- | -------------------- | ----------------- |
| Professional Plus 2024 | `ProPlus2024Volume`  | `PerpetualVL2024` |
| Standard 2024          | `Standard2024Volume` | `PerpetualVL2024` |

### Office LTSC 2021

| Edisi                  | Product ID           | Channel           |
| ---------------------- | -------------------- | ----------------- |
| Professional Plus 2021 | `ProPlus2021Volume`  | `PerpetualVL2021` |
| Standard 2021          | `Standard2021Volume` | `PerpetualVL2021` |

---

## Pilihan Arsitektur

Installer menyediakan dua pilihan:

```text
1. 64-bit
2. 32-bit
```

Untuk sebagian besar komputer Windows modern, **64-bit** merupakan pilihan yang disarankan.

Jika komputer atau aplikasi tertentu membutuhkan Office 32-bit, gunakan pilihan **32-bit**.

---

## Pilihan Bahasa

Installer menyediakan:

```text
1. Bahasa Indonesia
2. English
```

Bahasa yang dipilih akan digunakan sebagai bahasa instalasi Office.

---

## Instalasi Manual

Jika tidak ingin menggunakan perintah `irm | iex`, repository dapat di-clone terlebih dahulu.

### 1. Clone repository

```powershell
git clone https://github.com/FebrianSuban/office-installer.git
```

### 2. Masuk ke folder

```powershell
cd office-installer
```

### 3. Jalankan installer

```powershell
powershell -ExecutionPolicy Bypass -File .\Install-Office.ps1
```

---

## Struktur Repository

```text
office-installer/
│
├── Install-Office.ps1
├── README.md
├── LICENSE
├── .gitignore
│
├── config/
│   ├── README.md
│   │
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
```

---

## Cara Kerja

Installer menggunakan **Office Deployment Tool (ODT)** dari Microsoft.

Secara sederhana prosesnya:

```text
Pengguna
   │
   ▼
Install-Office.ps1
   │
   ├── Cek Windows
   ├── Cek koneksi internet
   ├── Cek hak administrator
   │
   ▼
Download Office Deployment Tool
   │
   ▼
Pilih konfigurasi Office
   │
   ├── Versi
   ├── Edisi
   ├── Arsitektur
   └── Bahasa
   │
   ▼
Membuat configuration.xml
   │
   ▼
ODT /download
   │
   ▼
Server Microsoft
   │
   ▼
File Office
   │
   ▼
ODT /configure
   │
   ▼
Office terpasang
```

---

## Office Deployment Tool

Installer ini menggunakan **Office Deployment Tool (ODT)** resmi dari Microsoft.

ODT bertugas untuk:

* Mengunduh file instalasi Office
* Membaca konfigurasi XML
* Menentukan produk Office
* Menentukan arsitektur
* Menentukan bahasa
* Melakukan instalasi Office

File Office **tidak disimpan di repository GitHub**.

Installer hanya menyimpan script dan konfigurasi. File Office akan diunduh ketika proses instalasi dijalankan.

---

## Aktivasi

**Installer ini tidak melakukan aktivasi Office.**

Tidak ada:

```text
Product Key
Crack
KMS
Activator
Bypass
Loader
Patch
```

Script hanya melakukan:

```text
Download
    ↓
Configure
    ↓
Install
```

Setelah Office terpasang, status aktivasi bergantung pada **lisensi yang dimiliki pengguna dan metode lisensi Microsoft yang sesuai**.

Untuk informasi lebih lanjut, lihat:

```text
docs/AKTIVASI.md
```

---

## Keamanan

Script ini tidak menyertakan file Office dalam repository.

File Office diunduh menggunakan **Office Deployment Tool** dan sumber distribusi Microsoft.

Repository ini hanya menyediakan script otomatisasi.

Sebelum menjalankan perintah PowerShell dari internet, pengguna disarankan untuk memeriksa isi script terlebih dahulu.

Script utama:

```text
Install-Office.ps1
```

---

## Melihat Script Sebelum Menjalankan

Jika ingin melihat isi script terlebih dahulu, buka:

```text
https://github.com/FebrianSuban/office-installer/blob/main/Install-Office.ps1
```

Atau download menggunakan:

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 -OutFile Install-Office.ps1
```

Kemudian buka:

```powershell
code .\Install-Office.ps1
```

Jika Visual Studio Code tidak tersedia, dapat menggunakan:

```powershell
notepad .\Install-Office.ps1
```

---

## Folder Sementara

Installer menggunakan folder sementara:

```text
%TEMP%\Office-Installer
```

Contohnya:

```text
C:\Users\<username>\AppData\Local\Temp\Office-Installer
```

Folder tersebut digunakan untuk menyimpan sementara:

```text
Office Deployment Tool
configuration.xml
file instalasi Office
```

Folder dapat dihapus setelah proses instalasi selesai jika sudah tidak diperlukan.

---

## Jika Instalasi Gagal

Jika terjadi masalah, jangan langsung menjalankan installer berulang kali.

Periksa terlebih dahulu:

### 1. Koneksi internet

Pastikan komputer dapat mengakses internet.

### 2. Ruang penyimpanan

Pastikan drive sistem memiliki ruang kosong yang cukup.

### 3. Office yang sudah terpasang

Office versi lain yang sudah terpasang dapat menyebabkan konflik.

### 4. Hak administrator

Pastikan PowerShell dapat memperoleh hak administrator ketika diminta.

### 5. File log

Periksa pesan error yang ditampilkan PowerShell.

Dokumentasi troubleshooting:

```text
docs/TROUBLESHOOTING.md
```

---

## Repository

Repository GitHub:

```text
https://github.com/FebrianSuban/office-installer
```

Script installer:

```text
https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1
```

---

## Dokumentasi

Dokumentasi tambahan tersedia di:

```text
docs/
├── INSTALASI.md
├── AKTIVASI.md
└── TROUBLESHOOTING.md
```

Konfigurasi contoh tersedia di:

```text
config/
└── examples/
```

---

## Disclaimer

Project ini merupakan script otomatisasi untuk membantu proses deployment Microsoft Office menggunakan Office Deployment Tool.

Project ini **bukan produk resmi Microsoft** dan tidak berafiliasi dengan Microsoft.

Microsoft Office merupakan produk dan merek dagang milik Microsoft Corporation.

Pengguna bertanggung jawab untuk memastikan bahwa penggunaan Office memiliki lisensi yang sesuai dengan ketentuan Microsoft.

Project ini tidak menyediakan product key, aktivasi ilegal, crack, atau mekanisme bypass lisensi.

---

## Lisensi

Project ini menggunakan lisensi **MIT**.

Lihat file:

```text
LICENSE
```

---

## Sumber Resmi Microsoft

Office Deployment Tool:

```text
https://www.microsoft.com/download/details.aspx?id=49117
```

Dokumentasi Office LTSC 2024:

```text
https://learn.microsoft.com/office/ltsc/2024/deploy
```

Dokumentasi Office LTSC 2021:

```text
https://learn.microsoft.com/office/ltsc/2021/deploy
```

---

## Ringkas

Jika hanya ingin menginstal Office, cukup jalankan:

```powershell
irm https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 | iex
```

Kemudian ikuti menu yang muncul.

```text
Pilih versi
   ↓
Pilih edisi
   ↓
Pilih arsitektur
   ↓
Pilih bahasa
   ↓
Download
   ↓
Install
   ↓
Selesai
```
