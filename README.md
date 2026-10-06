# Office Installer

Installer Microsoft Office berbasis **PowerShell** yang menggunakan **Microsoft Office Deployment Tool (ODT)**.

Installer ini dibuat untuk memudahkan pengguna Windows melakukan instalasi **Office LTSC 2024** atau **Office LTSC 2021** tanpa perlu membuat file konfigurasi XML secara manual.

---

## Cara Termudah

Ikuti langkah berikut untuk menjalankan installer Microsoft Office.

### 1. Buka PowerShell sebagai Administrator

Pada keyboard, tekan tombol **Windows (⊞)**.

Kemudian ketik:

```text
PowerShell
```

Setelah **Windows PowerShell** muncul pada hasil pencarian:

1. Klik kanan **Windows PowerShell**.
2. Pilih **Run as Administrator**.
3. Jika muncul jendela **User Account Control (UAC)**, klik **Yes**.

Setelah itu akan muncul jendela **Windows PowerShell** dengan hak Administrator.

---

### 2. Copy Perintah Installer

Copy perintah berikut:

```powershell
irm https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 | iex
```

Cara menyalin:

1. Arahkan mouse ke kotak perintah di atas.
2. Klik tombol **Copy** yang muncul pada kotak tersebut.
3. Perintah akan tersalin ke clipboard.

---

### 3. Paste Perintah ke PowerShell

Kembali ke jendela **Windows PowerShell** yang tadi dibuka sebagai Administrator.

Kemudian paste perintah yang sudah disalin.

Kamu dapat melakukan paste dengan:

* Klik kanan di dalam jendela PowerShell, atau
* Tekan **Ctrl + V**.

Kemudian tekan **Enter**.

Setelah itu installer akan berjalan dan menampilkan menu pilihan.

---

# Panduan Menu Installer

Jika kamu belum pernah menggunakan installer seperti ini, jangan khawatir.

Installer akan meminta beberapa pilihan. Setiap pilihan akan menentukan konfigurasi Office yang akan dipasang di komputer.

Secara umum, pilihan yang akan ditampilkan adalah:

```text
1. Versi Office
2. Edisi Office
3. Arsitektur Office
4. Bahasa Office
5. Konfirmasi instalasi
```

Berikut penjelasan masing-masing pilihan.

---

## 1. Pilih Versi Office

Installer akan menampilkan menu seperti:

```text
========================================
          PILIH VERSI OFFICE
========================================

[1] Office LTSC 2024
[2] Office LTSC 2021

[0] Kembali

Pilihan:
```

### Apa maksudnya?

Versi Office menentukan **generasi Office** yang akan dipasang.

Installer mendukung:

* Office LTSC 2024
* Office LTSC 2021

### Office LTSC 2024

Office LTSC 2024 adalah versi yang lebih baru dibandingkan Office LTSC 2021.

Pilih **Office LTSC 2024** jika:

* Kamu melakukan instalasi baru.
* Tidak memiliki kebutuhan khusus terhadap Office 2021.
* Ingin menggunakan versi LTSC yang lebih baru.
* Komputer menggunakan Windows 10 atau Windows 11 yang kompatibel.

Jika kamu tidak tahu harus memilih versi yang mana, **LTSC 2024 dapat menjadi pilihan untuk instalasi baru**, selama sesuai dengan lisensi yang kamu miliki.

Contoh:

```text
[1] Office LTSC 2024
[2] Office LTSC 2021

Pilihan: 1
```

### Office LTSC 2021

Office LTSC 2021 merupakan versi LTSC sebelumnya.

Pilih **Office LTSC 2021** jika:

* Kamu memang membutuhkan Office 2021.
* Organisasi atau lingkungan kerja kamu menggunakan Office LTSC 2021.
* Kamu memiliki lisensi untuk Office LTSC 2021.
* Ada kebutuhan kompatibilitas tertentu dengan lingkungan yang sudah menggunakan Office 2021.

Contoh:

```text
[1] Office LTSC 2024
[2] Office LTSC 2021

Pilihan: 2
```

### Jika tidak tahu pilih yang mana

Gunakan panduan sederhana:

```text
Ingin instalasi LTSC yang lebih baru?
            ↓
       Office LTSC 2024

Membutuhkan Office LTSC 2021?
            ↓
       Office LTSC 2021
```

**Penting:** versi Office tetap harus sesuai dengan lisensi yang kamu miliki.

---

# 2. Pilih Edisi Office

Setelah memilih versi Office, installer akan meminta pilihan edisi.

Contohnya:

```text
========================================
           PILIH EDISI OFFICE
========================================

[1] Professional Plus
[2] Standard

[0] Kembali

Pilihan:
```

Tersedia dua pilihan:

* Professional Plus
* Standard

### Professional Plus

Professional Plus merupakan edisi Office yang ditujukan untuk deployment volume dan menyediakan paket aplikasi yang lebih lengkap dibandingkan edisi Standard dalam konfigurasi yang didukung.

Pilih **Professional Plus** jika:

* Lisensi yang kamu miliki memang untuk Professional Plus.
* Organisasi atau perusahaan menggunakan Professional Plus.
* Kamu membutuhkan aplikasi Office yang tersedia pada edisi tersebut.

Contoh:

```text
[1] Professional Plus
[2] Standard

Pilihan: 1
```

### Standard

Standard merupakan edisi Office lainnya yang tersedia untuk deployment volume.

Pilih **Standard** jika:

* Lisensi yang kamu miliki memang untuk Office Standard.
* Organisasi atau perusahaan menggunakan Office Standard.
* Kamu memang membutuhkan edisi Standard.

Contoh:

```text
[1] Professional Plus
[2] Standard

Pilihan: 2
```

### Jangan memilih berdasarkan nama saja

Hal yang sangat penting:

**Professional Plus bukan berarti otomatis cocok untuk semua orang.**

Begitu juga **Standard bukan berarti Office yang "lebih jelek".**

Edisi harus disesuaikan dengan **jenis lisensi yang kamu miliki**.

Jika kamu memiliki lisensi:

```text
Professional Plus
```

gunakan:

```text
Professional Plus
```

Jika kamu memiliki lisensi:

```text
Standard
```

gunakan:

```text
Standard
```

---

# 3. Pilih Arsitektur Office

Selanjutnya installer akan menampilkan:

```text
========================================
        PILIH ARSITEKTUR OFFICE
========================================

[1] 64-bit
[2] 32-bit

[0] Kembali

Pilihan:
```

Pilihan ini menentukan arsitektur Office yang akan dipasang.

Tersedia:

* 64-bit
* 32-bit

---

## Apa itu 64-bit dan 32-bit?

64-bit dan 32-bit adalah **arsitektur perangkat lunak**.

Ini berbeda dengan kapasitas RAM.

Misalnya komputer kamu memiliki:

```text
RAM 8 GB
```

Bukan berarti Office harus menggunakan "8-bit".

Office tetap memilih:

```text
64-bit
atau
32-bit
```

---

## 64-bit

Untuk kebanyakan komputer Windows modern, **Office 64-bit merupakan pilihan yang disarankan**, terutama jika sistem Windows kamu menggunakan arsitektur 64-bit.

Pilih 64-bit jika:

* Windows kamu 64-bit.
* Komputer relatif modern.
* Kamu menggunakan file Excel berukuran besar.
* Kamu bekerja dengan data dalam jumlah besar.
* Tidak memiliki kebutuhan khusus terhadap Office 32-bit.

Contoh:

```text
Windows 11
64-bit
RAM 8 GB
CPU modern

↓
Office 64-bit
```

---

## 32-bit

Office 32-bit dapat dipilih apabila terdapat kebutuhan kompatibilitas tertentu.

Contohnya:

* Aplikasi lama membutuhkan Office 32-bit.
* Add-in lama hanya mendukung Office 32-bit.
* Lingkungan kerja secara khusus menggunakan Office 32-bit.
* Sistem Windows yang digunakan memang 32-bit.

Jadi jangan memilih 32-bit hanya karena RAM komputer kecil.

---

## Cara Mengetahui Windows 64-bit atau 32-bit

Ikuti langkah berikut:

1. Tekan **Windows + I**.
2. Pilih **System**.
3. Pilih **About**.
4. Cari bagian **System type**.

Contoh:

```text
System type:
64-bit operating system, x64-based processor
```

Artinya Windows kamu adalah 64-bit.

Maka umumnya pilih:

```text
[1] 64-bit
```

---

## Rekomendasi Sederhana

Jika komputer menggunakan Windows 10 atau Windows 11 64-bit dan tidak memiliki kebutuhan khusus:

```text
Pilih: 64-bit
```

---

# 4. Pilih Bahasa Office

Selanjutnya installer akan menampilkan:

```text
========================================
          PILIH BAHASA OFFICE
========================================

[1] Bahasa Indonesia
[2] English

[0] Kembali

Pilihan:
```

Pilihan ini menentukan bahasa antarmuka Office.

---

## Bahasa Indonesia

Pilih:

```text
[1] Bahasa Indonesia
```

Jika kamu ingin menggunakan Office dalam bahasa Indonesia.

Contohnya menu Office akan menggunakan istilah seperti:

```text
File
Beranda
Sisipkan
Tata Letak
Tinjau
Tampilan
```

Pilihan ini cocok jika kamu lebih nyaman menggunakan bahasa Indonesia.

---

## English

Pilih:

```text
[2] English
```

Jika kamu terbiasa menggunakan Office dalam bahasa Inggris.

Contohnya:

```text
File
Home
Insert
Layout
Review
View
```

Pilihan ini juga cocok jika kamu sering mengikuti tutorial Office berbahasa Inggris.

---

# 5. Konfirmasi Instalasi

Setelah semua pilihan selesai, installer akan menampilkan ringkasan.

Contohnya:

```text
========================================
        KONFIRMASI INSTALASI
========================================

Versi       : Office LTSC 2024
Edisi       : Professional Plus
Arsitektur  : 64-bit
Bahasa      : Bahasa Indonesia

========================================

Apakah konfigurasi sudah benar?

[Y] Ya, lanjutkan instalasi
[N] Tidak, kembali ke menu

Pilihan:
```

Periksa semua informasi sebelum melanjutkan.

Pastikan:

```text
Versi       → sesuai yang diinginkan
Edisi       → sesuai dengan lisensi
Arsitektur  → sesuai dengan Windows
Bahasa      → sesuai dengan kebutuhan
```

Jika sudah benar, pilih:

```text
Y
```

Kemudian tekan **Enter**.

Installer akan mulai melakukan proses instalasi.

---

# Contoh Konfigurasi untuk Pengguna Umum

Jika kamu menggunakan komputer Windows modern dan tidak tahu harus memilih arsitektur apa, contoh konfigurasi yang umum adalah:

```text
Versi       : Office LTSC 2024
Edisi       : Sesuai dengan lisensi
Arsitektur  : 64-bit
Bahasa      : Bahasa Indonesia
```

Contoh proses:

```text
========================================
        MICROSOFT OFFICE INSTALLER
========================================

Pilih versi Office:

[1] Office LTSC 2024
[2] Office LTSC 2021

Pilihan: 1


Pilih edisi Office:

[1] Professional Plus
[2] Standard

Pilihan: 1


Pilih arsitektur:

[1] 64-bit
[2] 32-bit

Pilihan: 1


Pilih bahasa:

[1] Bahasa Indonesia
[2] English

Pilihan: 1


========================================
        KONFIRMASI INSTALASI
========================================

Versi       : Office LTSC 2024
Edisi       : Professional Plus
Arsitektur  : 64-bit
Bahasa      : Bahasa Indonesia

Lanjutkan instalasi? [Y/N]: Y
```

**Perhatian:** contoh di atas bukan berarti semua pengguna harus memilih Professional Plus. Edisi Office harus disesuaikan dengan lisensi yang dimiliki.

---

# Proses Setelah Konfirmasi

Setelah kamu memilih **Y**, installer akan menjalankan beberapa tahap secara otomatis.

## Tahap 1 — Download Office Deployment Tool

Installer akan mengunduh **Microsoft Office Deployment Tool (ODT)**.

ODT adalah alat resmi Microsoft yang digunakan untuk melakukan deployment Office.

Kamu tidak perlu mengunduh atau memasangnya secara manual.

---

## Tahap 2 — Membuat Konfigurasi

Installer akan membuat file:

```text
configuration.xml
```

File tersebut berisi konfigurasi berdasarkan pilihan kamu.

Misalnya:

```text
Versi Office
Edisi Office
Arsitektur
Bahasa
Channel
```

Kamu tidak perlu membuat file XML tersebut secara manual.

---

## Tahap 3 — Download Office

ODT akan mulai mengunduh file Office.

File tersebut tidak disimpan di GitHub.

File Office akan diunduh melalui mekanisme distribusi Microsoft yang digunakan oleh ODT.

Pada tahap ini:

* Pastikan internet tetap terhubung.
* Jangan menutup PowerShell.
* Jangan mematikan komputer.
* Jangan menjalankan installer Office lain secara bersamaan.

Lama download bergantung pada kecepatan internet dan kondisi jaringan.

---

## Tahap 4 — Install Office

Setelah file Office selesai diunduh, ODT akan menjalankan proses instalasi.

Tunggu sampai proses selesai.

Jangan menutup jendela PowerShell selama proses berlangsung.

---

## Tahap 5 — Selesai

Jika proses berhasil, installer akan memberikan informasi bahwa instalasi telah selesai.

Setelah itu kamu dapat membuka aplikasi Office melalui:

```text
Windows
   ↓
Start Menu
   ↓
Microsoft Word
Microsoft Excel
Microsoft PowerPoint
dan aplikasi Office lainnya
```

---

# Alur Instalasi

Secara keseluruhan prosesnya:

```text
Buka PowerShell sebagai Administrator
              ↓
Copy perintah installer
              ↓
Paste ke PowerShell
              ↓
Tekan Enter
              ↓
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
Konfirmasi
              ↓
Download Office
              ↓
Install Office
              ↓
Selesai
```

---

# Fitur

* Instalasi Office LTSC 2024
* Instalasi Office LTSC 2021
* Pilihan Professional Plus
* Pilihan Standard
* Pilihan 64-bit
* Pilihan 32-bit
* Pilihan bahasa Indonesia
* Pilihan bahasa English
* Menggunakan Microsoft Office Deployment Tool (ODT)
* File Office diunduh melalui mekanisme distribusi Microsoft
* Tidak menyimpan installer Office berukuran besar di GitHub
* Membuat konfigurasi ODT secara otomatis
* Tidak membutuhkan pembuatan XML secara manual
* Mendukung instalasi melalui satu perintah PowerShell
* Tidak menyertakan product key
* Tidak melakukan crack
* Tidak melakukan bypass aktivasi

---

# Persyaratan

Sebelum menjalankan installer, pastikan:

* Windows 10 atau Windows 11
* Koneksi internet aktif
* PowerShell tersedia
* Memiliki hak Administrator
* Ruang penyimpanan yang cukup
* Tidak sedang menjalankan proses instalasi Office lainnya

---

# Produk yang Didukung

## Office LTSC 2024

| Edisi                  | Product ID           | Channel           |
| ---------------------- | -------------------- | ----------------- |
| Professional Plus 2024 | `ProPlus2024Volume`  | `PerpetualVL2024` |
| Standard 2024          | `Standard2024Volume` | `PerpetualVL2024` |

## Office LTSC 2021

| Edisi                  | Product ID           | Channel           |
| ---------------------- | -------------------- | ----------------- |
| Professional Plus 2021 | `ProPlus2021Volume`  | `PerpetualVL2021` |
| Standard 2021          | `Standard2021Volume` | `PerpetualVL2021` |

---

# Instalasi Manual

Jika tidak ingin menggunakan perintah `irm | iex`, repository dapat di-clone terlebih dahulu.

## 1. Clone repository

```powershell
git clone https://github.com/FebrianSuban/office-installer.git
```

## 2. Masuk ke folder

```powershell
cd office-installer
```

## 3. Jalankan installer

```powershell
powershell -ExecutionPolicy Bypass -File .\Install-Office.ps1
```

---

# Struktur Repository

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

# Cara Kerja

Installer menggunakan **Office Deployment Tool (ODT)** dari Microsoft.

Secara sederhana:

```text
Pengguna
   │
   ▼
Install-Office.ps1
   │
   ├── Cek Windows
   ├── Cek koneksi internet
   └── Cek hak Administrator
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
Distribusi Microsoft
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

# Office Deployment Tool

Installer ini menggunakan **Office Deployment Tool (ODT)** resmi dari Microsoft.

ODT digunakan untuk:

* Mengunduh file instalasi Office.
* Membaca konfigurasi XML.
* Menentukan produk Office.
* Menentukan arsitektur.
* Menentukan bahasa.
* Melakukan instalasi Office.

File Office **tidak disimpan di repository GitHub**.

Repository hanya menyimpan script dan konfigurasi yang diperlukan.

---

# Aktivasi

**Installer ini tidak melakukan aktivasi Office.**

Installer tidak menyediakan:

```text
Product Key
Crack
KMS
Activator
Bypass
Loader
Patch
```

Installer hanya melakukan:

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

# Keamanan

Script ini tidak menyertakan file Office dalam repository.

File Office diunduh menggunakan **Office Deployment Tool** dan mekanisme distribusi Microsoft.

Repository ini hanya menyediakan script otomatisasi.

Sebelum menjalankan perintah PowerShell dari internet, pengguna disarankan untuk memeriksa isi script terlebih dahulu.

Script utama:

```text
Install-Office.ps1
```

---

# Melihat Script Sebelum Menjalankan

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

Jika Visual Studio Code tidak tersedia:

```powershell
notepad .\Install-Office.ps1
```

---

# Folder Sementara

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

# Jika Instalasi Gagal

Jika terjadi masalah, jangan langsung menjalankan installer berulang kali.

Periksa terlebih dahulu:

## 1. Koneksi Internet

Pastikan komputer dapat mengakses internet.

## 2. Ruang Penyimpanan

Pastikan drive sistem memiliki ruang kosong yang cukup.

## 3. Office yang Sudah Terpasang

Office versi lain yang sudah terpasang dapat menyebabkan konflik.

## 4. Hak Administrator

Pastikan PowerShell dijalankan menggunakan:

```text
Run as Administrator
```

## 5. Pesan Error

Perhatikan pesan error yang ditampilkan pada PowerShell.

Dokumentasi troubleshooting tersedia di:

```text
docs/TROUBLESHOOTING.md
```

---

# Repository

Repository GitHub:

```text
https://github.com/FebrianSuban/office-installer
```

Script installer:

```text
https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1
```

---

# Dokumentasi

Dokumentasi tambahan:

```text
docs/
├── INSTALASI.md
├── AKTIVASI.md
└── TROUBLESHOOTING.md
```

Contoh konfigurasi:

```text
config/
└── examples/
```

---

# Disclaimer

Project ini merupakan script otomatisasi untuk membantu proses deployment Microsoft Office menggunakan Office Deployment Tool.

Project ini **bukan produk resmi Microsoft** dan tidak berafiliasi dengan Microsoft.

Microsoft Office merupakan produk dan merek dagang milik Microsoft Corporation.

Pengguna bertanggung jawab untuk memastikan bahwa penggunaan Office memiliki lisensi yang sesuai dengan ketentuan Microsoft.

Project ini tidak menyediakan product key, aktivasi ilegal, crack, atau mekanisme bypass lisensi.

---

# Lisensi

Project ini menggunakan lisensi **MIT**.

Lihat file:

```text
LICENSE
```

---

# Sumber Resmi Microsoft

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

# Ringkas

Jika hanya ingin menginstal Office:

### 1. Buka PowerShell sebagai Administrator

Tekan:

```text
Windows (⊞)
```

Kemudian ketik:

```text
PowerShell
```

Klik kanan **Windows PowerShell** → **Run as Administrator** → **Yes**.

### 2. Copy perintah berikut

```powershell
irm https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 | iex
```

### 3. Paste ke PowerShell

Tekan:

```text
Ctrl + V
```

Kemudian tekan:

```text
Enter
```

### 4. Ikuti pilihan yang ditampilkan

```text
Pilih versi
   ↓
Pilih edisi
   ↓
Pilih arsitektur
   ↓
Pilih bahasa
   ↓
Konfirmasi
   ↓
Download
   ↓
Install
   ↓
Selesai
```

**Tidak perlu membuat XML, mengunduh ODT secara manual, atau melakukan konfigurasi secara manual.**
