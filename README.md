# Office Installer

<p align="center">
  <img src="assets/rgoad.png" alt="RGOAD" width="700">
</p>

PowerShell installer untuk melakukan deployment **Microsoft Office LTSC 2024** dan **Microsoft Office LTSC 2021** menggunakan **Microsoft Office Deployment Tool (ODT)** resmi dari Microsoft.

Installer ini menyediakan antarmuka berbasis menu sehingga pengguna tidak perlu membuat konfigurasi XML ODT secara manual.

> **Catatan:** Project ini bukan produk resmi Microsoft dan tidak berafiliasi dengan Microsoft Corporation.

---

## Fitur

* Office LTSC 2024
* Office LTSC 2021
* Professional Plus
* Standard
* Pemilihan aplikasi Office
* Pemilihan aplikasi secara individual
* Toggle aplikasi menggunakan nomor
* Pilihan semua aplikasi yang tersedia
* Menghapus seluruh pilihan aplikasi
* Validasi minimal satu aplikasi
* Office 64-bit
* Office 32-bit
* Bahasa Indonesia
* English
* Pembuatan `configuration.xml` otomatis
* Download Office Deployment Tool otomatis
* Download file Office menggunakan ODT
* Instalasi Office menggunakan ODT
* Menggunakan `ExcludeApp` untuk aplikasi yang tidak dipilih
* Tidak menyertakan installer Office berukuran besar di repository
* Tidak membutuhkan pembuatan XML secara manual
* Dapat dijalankan langsung menggunakan satu perintah PowerShell
* Tidak menyediakan Product Key
* Tidak melakukan aktivasi
* Tidak menyediakan crack, KMS, loader, patch, atau bypass lisensi

---

# Cara Termudah

## 1. Buka PowerShell sebagai Administrator

Tekan tombol:

```text
Windows (⊞)
```

Kemudian cari:

```text
PowerShell
```

Klik kanan **Windows PowerShell** lalu pilih:

```text
Run as Administrator
```

Jika muncul **User Account Control (UAC)**, pilih **Yes**.

> Installer juga melakukan pemeriksaan hak Administrator dan dapat meminta elevasi jika diperlukan.

---

## 2. Jalankan Installer

Gunakan perintah berikut:

```powershell
irm https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 | iex
```

Kemudian tekan **Enter**.

Installer akan menampilkan menu interaktif.

---

# Alur Installer

Secara umum prosesnya:

```text
PowerShell
    ↓
Pemeriksaan sistem
    ↓
Pemeriksaan koneksi
    ↓
Pilih versi Office
    ↓
Pilih edisi Office
    ↓
Pilih aplikasi
    ↓
Pilih arsitektur
    ↓
Pilih bahasa
    ↓
Konfirmasi
    ↓
Download ODT
    ↓
Ekstrak ODT
    ↓
Buat configuration.xml
    ↓
Download Office
    ↓
Install Office
    ↓
Selesai
```

---

# Versi Office

Installer menyediakan:

```text
[1] Office LTSC 2024
[2] Office LTSC 2021
```

## Office LTSC 2024

Office LTSC 2024 merupakan generasi LTSC yang lebih baru.

Product ID yang digunakan:

| Edisi                  | Product ID           | Channel           |
| ---------------------- | -------------------- | ----------------- |
| Professional Plus 2024 | `ProPlus2024Volume`  | `PerpetualVL2024` |
| Standard 2024          | `Standard2024Volume` | `PerpetualVL2024` |

---

## Office LTSC 2021

Office LTSC 2021 merupakan generasi LTSC sebelumnya.

Product ID yang digunakan:

| Edisi                  | Product ID           | Channel           |
| ---------------------- | -------------------- | ----------------- |
| Professional Plus 2021 | `ProPlus2021Volume`  | `PerpetualVL2021` |
| Standard 2021          | `Standard2021Volume` | `PerpetualVL2021` |

---

# Edisi Office

Setelah memilih versi, installer menampilkan edisi yang tersedia:

```text
[1] Professional Plus
[2] Standard
```

## Professional Plus

Professional Plus merupakan edisi Office volume yang memiliki kumpulan aplikasi yang berbeda dari Standard.

Product ID:

```text
ProPlus2024Volume
```

atau:

```text
ProPlus2021Volume
```

tergantung versi yang dipilih.

---

## Standard

Standard merupakan edisi Office volume yang berbeda dari Professional Plus.

Product ID:

```text
Standard2024Volume
```

atau:

```text
Standard2021Volume
```

tergantung versi yang dipilih.

> **Penting:** Jangan menentukan edisi hanya berdasarkan nama atau jumlah aplikasi. Gunakan Product ID yang sesuai dengan lisensi Office yang dimiliki.

---

# Perbedaan Professional Plus dan Standard

Professional Plus dan Standard **bukan produk yang sama dengan nama berbeda**.

Keduanya merupakan SKU Office volume dengan komposisi aplikasi yang berbeda.

Secara umum, Professional Plus menyediakan kumpulan aplikasi yang lebih lengkap dibandingkan Standard.

Contoh aplikasi yang dapat berkaitan dengan konfigurasi Office volume:

```text
Word
Excel
PowerPoint
Outlook
OneNote
Access
Publisher
```

Namun aplikasi yang tersedia bergantung pada:

```text
Versi Office
    +
Edisi Office
    +
Product ID
```

Installer karena itu tidak seharusnya menampilkan aplikasi yang tidak didukung oleh kombinasi produk yang dipilih.

> **Catatan:** `Publisher` memiliki status berbeda pada Office LTSC 2024 dan LTSC 2021. Installer tidak menampilkan Publisher untuk konfigurasi LTSC 2024.

---

# Pemilihan Aplikasi

Setelah versi dan edisi dipilih, installer menampilkan menu aplikasi yang sesuai dengan produk tersebut.

Contoh:

```text
============================================================
                 PILIH APLIKASI OFFICE
============================================================

Pilih aplikasi yang ingin diinstal.

Gunakan nomor untuk memilih atau membatalkan pilihan.

[1] [ ] Microsoft Word
[2] [ ] Microsoft Excel
[3] [ ] Microsoft PowerPoint
[4] [ ] Microsoft Outlook
[5] [ ] Microsoft Access
[6] [ ] Microsoft OneNote

------------------------------------------------------------

[8] [ ] Pilih semua aplikasi
[9] [ ] Hapus semua pilihan
[0]     Lanjutkan

------------------------------------------------------------

Pilih nomor:
```

Daftar yang ditampilkan dapat berbeda berdasarkan versi dan edisi Office yang dipilih.

---

# Sistem Toggle

Pemilihan aplikasi menggunakan sistem **toggle**.

Misalnya:

```text
Pilih nomor: 1
```

maka Word menjadi:

```text
[1] [✓] Microsoft Word
```

Jika nomor `1` dipilih kembali:

```text
Pilih nomor: 1
```

maka Word dibatalkan:

```text
[1] [ ] Microsoft Word
```

Dengan demikian pengguna dapat memilih dan membatalkan aplikasi dengan mudah.

---

# Pilih Semua

Gunakan:

```text
[8] Pilih semua aplikasi
```

untuk memilih seluruh aplikasi yang tersedia pada konfigurasi versi dan edisi yang sedang dipilih.

Contoh:

```text
[1] [✓] Microsoft Word
[2] [✓] Microsoft Excel
[3] [✓] Microsoft PowerPoint
[4] [✓] Microsoft Outlook
...
```

Installer hanya memilih aplikasi yang memang tersedia untuk konfigurasi tersebut.

---

# Hapus Semua

Gunakan:

```text
[9] Hapus semua pilihan
```

untuk membatalkan seluruh pilihan.

Hasilnya:

```text
[1] [ ] Microsoft Word
[2] [ ] Microsoft Excel
[3] [ ] Microsoft PowerPoint
...
```

---

# Minimal Satu Aplikasi

Installer tidak mengizinkan pengguna melanjutkan apabila tidak ada aplikasi yang dipilih.

Contoh:

```text
Belum ada aplikasi yang dipilih.
Silakan pilih minimal satu aplikasi.
```

Pengguna harus memilih setidaknya satu aplikasi sebelum memilih:

```text
[0] Lanjutkan
```

---

# Bagaimana Pilihan Aplikasi Diterapkan?

Installer menggunakan mekanisme konfigurasi resmi Office Deployment Tool.

Aplikasi yang tidak dipilih dapat dikecualikan menggunakan:

```xml
<ExcludeApp ID="..." />
```

Contoh konfigurasi:

```xml
<Configuration>
    <Add
        OfficeClientEdition="64"
        Channel="PerpetualVL2024">

        <Product ID="ProPlus2024Volume">
            <Language ID="id-id" />

            <ExcludeApp ID="Outlook" />
            <ExcludeApp ID="Access" />
            <ExcludeApp ID="OneNote" />
        </Product>

    </Add>

    <RemoveMSI />

    <Property
        Name="AUTOACTIVATE"
        Value="0" />

</Configuration>
```

Jika pengguna memilih Word, Excel, dan PowerPoint tetapi tidak memilih Outlook, Access, dan OneNote, maka aplikasi yang tidak dipilih dapat dikecualikan melalui `ExcludeApp`.

Installer tidak memodifikasi file Office.

---

# Arsitektur Office

Installer menyediakan:

```text
[1] 64-bit
[2] 32-bit
```

## 64-bit

64-bit merupakan pilihan yang umum untuk Windows modern 64-bit.

Disarankan jika:

* Windows menggunakan arsitektur 64-bit.
* Tidak membutuhkan kompatibilitas khusus dengan Office 32-bit.
* Menggunakan workbook Excel berukuran besar.
* Menggunakan data dalam jumlah besar.
* Tidak bergantung pada add-in lama 32-bit.

---

## 32-bit

32-bit dapat digunakan apabila terdapat kebutuhan kompatibilitas tertentu.

Contohnya:

* Add-in lama membutuhkan Office 32-bit.
* Aplikasi lama membutuhkan Office 32-bit.
* Lingkungan kerja menggunakan Office 32-bit.
* Kebutuhan kompatibilitas tertentu dengan perangkat lunak lama.

> **Catatan:** Arsitektur Office tidak sama dengan kapasitas RAM.

Komputer dengan RAM:

```text
8 GB
```

tetap dapat menggunakan:

```text
Office 64-bit
```

---

# Bahasa Office

Installer menyediakan:

```text
[1] Bahasa Indonesia
[2] English
```

## Bahasa Indonesia

Menggunakan:

```text
id-id
```

## English

Menggunakan:

```text
en-us
```

Bahasa tersebut digunakan sebagai `Language ID` dalam konfigurasi ODT.

---

# Konfirmasi

Sebelum instalasi dimulai, installer menampilkan ringkasan konfigurasi.

Contoh:

```text
============================================================
                     KONFIGURASI
============================================================

Versi       : Office LTSC 2024
Edisi       : Professional Plus
Product ID  : ProPlus2024Volume
Arsitektur  : 64-bit
Bahasa      : id-id

Aplikasi:

  [✓] Microsoft Word
  [✓] Microsoft Excel
  [✓] Microsoft PowerPoint
  [ ] Microsoft Outlook
  [ ] Microsoft Access
  [ ] Microsoft OneNote

Aktivasi    : Tidak dilakukan oleh installer

============================================================

Lanjutkan proses instalasi? (Y/N):
```

Masukkan:

```text
Y
```

untuk melanjutkan.

Masukkan:

```text
N
```

untuk membatalkan.

---

# Office Deployment Tool

Installer menggunakan **Microsoft Office Deployment Tool (ODT)** resmi.

ODT digunakan untuk:

* Download Office.
* Membaca configuration XML.
* Menentukan Product ID.
* Menentukan channel.
* Menentukan arsitektur.
* Menentukan bahasa.
* Mengecualikan aplikasi.
* Melakukan konfigurasi Office.

Installer tidak menyimpan file instalasi Office di repository GitHub.

---

# Download ODT

Setelah pengguna melakukan konfirmasi, installer akan mengunduh ODT dari sumber resmi Microsoft.

File ODT kemudian diekstrak sehingga tersedia:

```text
setup.exe
```

Installer menggunakan `setup.exe` untuk menjalankan deployment Office.

---

# Configuration XML

Installer membuat:

```text
configuration.xml
```

secara otomatis.

Pengguna tidak perlu membuat XML secara manual.

Konfigurasi dibuat berdasarkan:

```text
Versi
Edisi
Product ID
Arsitektur
Bahasa
Aplikasi
Channel
```

---

# Download Office

ODT kemudian menjalankan mode:

```text
setup.exe /download configuration.xml
```

Tahap ini mengunduh file Office dari infrastruktur distribusi Microsoft.

File Office tidak disimpan di repository.

Selama proses download:

* Pastikan koneksi internet aktif.
* Jangan menutup PowerShell.
* Jangan mematikan komputer.
* Pastikan ruang penyimpanan mencukupi.
* Jangan menjalankan instalasi Office lain secara bersamaan.

---

# Instalasi Office

Setelah download selesai, ODT menjalankan konfigurasi:

```text
setup.exe /configure configuration.xml
```

ODT kemudian melakukan instalasi berdasarkan konfigurasi yang telah dibuat.

---

# Folder Kerja

Installer menggunakan folder kerja sementara:

```text
%TEMP%\Office-Installer
```

Contohnya:

```text
C:\Users\<username>\AppData\Local\Temp\Office-Installer
```

Folder tersebut dapat berisi:

```text
officedeploymenttool.exe
setup.exe
configuration.xml
file instalasi Office
```

Folder kerja dapat dihapus setelah instalasi selesai apabila sudah tidak diperlukan.

---

# Office yang Sudah Terpasang

Jika komputer sudah memiliki Office, proses deployment dapat dipengaruhi oleh instalasi yang sudah ada.

Konfigurasi installer dapat menggunakan:

```xml
<RemoveMSI />
```

untuk menangani instalasi Office berbasis MSI lama.

Namun `RemoveMSI` bukan berarti seluruh konfigurasi Office Click-to-Run yang sudah ada akan otomatis dihapus.

Jika terdapat Office Click-to-Run lain, produk Microsoft 365, Visio, Project, atau konfigurasi Office lainnya, pengguna harus memperhatikan kompatibilitas sebelum menjalankan deployment.

---

# Aktivasi

Installer **tidak melakukan aktivasi Office**.

Installer tidak menyediakan:

```text
Crack
KMS ilegal
Activator
Loader
Patch
Bypass
Product Key
```

Installer hanya melakukan:

```text
Download
    ↓
Configure
    ↓
Install
```

Aktivasi bergantung pada lisensi yang dimiliki pengguna dan metode aktivasi resmi yang sesuai dengan produk Office.

> Pengguna bertanggung jawab memastikan bahwa Office yang dipasang memiliki lisensi yang sesuai.

---

# Persyaratan

Sebelum menjalankan installer, pastikan:

* Windows kompatibel dengan produk Office yang dipilih.
* Koneksi internet aktif.
* PowerShell tersedia.
* Memiliki hak Administrator.
* Ruang penyimpanan mencukupi.
* Tidak sedang melakukan instalasi Office lain.
* Memiliki lisensi yang sesuai.
* Tidak ada proses Office Deployment Tool lain yang sedang berjalan.

---

# Instalasi Manual

Jika tidak ingin menggunakan `irm | iex`, repository dapat di-clone terlebih dahulu.

## 1. Clone Repository

```powershell
git clone https://github.com/FebrianSuban/office-installer.git
```

## 2. Masuk ke Folder

```powershell
cd office-installer
```

## 3. Jalankan Installer

```powershell
powershell -ExecutionPolicy Bypass -File .\Install-Office.ps1
```

Jika belum menggunakan PowerShell Administrator, script akan melakukan pemeriksaan hak Administrator dan meminta elevasi jika diperlukan.

---

# Melihat Script Sebelum Menjalankan

Untuk keamanan, pengguna disarankan memeriksa script sebelum menjalankannya dari internet.

Repository:

```text
https://github.com/FebrianSuban/office-installer
```

Script:

```text
Install-Office.ps1
```

Untuk mengunduh script tanpa langsung mengeksekusinya:

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 -OutFile Install-Office.ps1
```

Kemudian buka menggunakan Visual Studio Code:

```powershell
code .\Install-Office.ps1
```

atau menggunakan Notepad:

```powershell
notepad .\Install-Office.ps1
```

Setelah script diperiksa, script dapat dijalankan secara manual.

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

```text
                    Pengguna
                       │
                       ▼
              Install-Office.ps1
                       │
             ┌─────────┴─────────┐
             │                   │
       Cek Administrator    Cek Windows
             │                   │
             └─────────┬─────────┘
                       │
                       ▼
                 Cek Internet
                       │
                       ▼
                Pilih Versi
                       │
              ┌────────┴────────┐
              │                 │
        LTSC 2024          LTSC 2021
              │                 │
              └────────┬────────┘
                       │
                       ▼
                 Pilih Edisi
                       │
              ┌────────┴────────┐
              │                 │
        Professional Plus     Standard
              │                 │
              └────────┬────────┘
                       │
                       ▼
                Pilih Aplikasi
                       │
                       ▼
              Pilih Arsitektur
                       │
                       ▼
                 Pilih Bahasa
                       │
                       ▼
                  Konfirmasi
                       │
                       ▼
                 Download ODT
                       │
                       ▼
                 Ekstrak ODT
                       │
                       ▼
             configuration.xml
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
                 Office Terpasang
```

---

# Contoh Konfigurasi

Misalnya pengguna memilih:

```text
Versi       : Office LTSC 2024
Edisi       : Professional Plus
Product ID  : ProPlus2024Volume
Aplikasi    : Word
              Excel
              PowerPoint
Arsitektur  : 64-bit
Bahasa      : Bahasa Indonesia
```

Maka installer dapat menghasilkan konfigurasi yang secara konsep berisi:

```xml
<Configuration>

    <Add
        OfficeClientEdition="64"
        Channel="PerpetualVL2024">

        <Product ID="ProPlus2024Volume">

            <Language ID="id-id" />

            <ExcludeApp ID="Outlook" />
            <ExcludeApp ID="Access" />
            <ExcludeApp ID="OneNote" />

        </Product>

    </Add>

    <RemoveMSI />

</Configuration>
```

Konfigurasi aktual dibuat oleh PowerShell berdasarkan pilihan pengguna.

---

# Troubleshooting

## Installer Tidak Bisa Berjalan

Pastikan PowerShell dijalankan sebagai Administrator.

Coba:

```text
Run as Administrator
```

---

## Download ODT Gagal

Periksa:

* Koneksi internet.
* Firewall.
* Proxy.
* Antivirus.
* Akses ke server Microsoft.
* Ruang penyimpanan.

Kemudian coba kembali.

---

## Download Office Gagal

Pastikan:

```text
Internet aktif
```

dan ruang penyimpanan mencukupi.

Jangan menjalankan beberapa proses ODT secara bersamaan.

---

## Office Tidak Bisa Diinstal

Periksa apakah terdapat Office lain yang sudah terpasang.

Khususnya:

```text
Microsoft 365
Office Click-to-Run
Office MSI
Visio
Project
```

Konfigurasi Office yang berbeda dapat menyebabkan konflik.

---

## Product ID Tidak Sesuai

Pastikan edisi yang dipilih sesuai dengan lisensi.

Contoh:

```text
Professional Plus 2024
        ↓
ProPlus2024Volume
```

```text
Standard 2024
        ↓
Standard2024Volume
```

Untuk 2021:

```text
Professional Plus 2021
        ↓
ProPlus2021Volume
```

```text
Standard 2021
        ↓
Standard2021Volume
```

Jangan menggunakan Product ID yang berbeda dari lisensi yang dimiliki.

---

# Keamanan

Installer ini menggunakan:

* PowerShell.
* Office Deployment Tool resmi Microsoft.
* Configuration XML ODT.
* Infrastruktur distribusi Office Microsoft.

Repository tidak menyimpan:

* File Office.
* Product Key.
* Crack.
* Activator.
* KMS ilegal.
* Patch.
* Loader.
* Bypass lisensi.

Sebelum menggunakan perintah:

```powershell
irm https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 | iex
```

pengguna disarankan membaca dan memeriksa isi script terlebih dahulu.

---

# Repository

GitHub:

```text
https://github.com/FebrianSuban/office-installer
```

Script:

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

# Sumber Resmi Microsoft

## Office Deployment Tool

https://www.microsoft.com/download/details.aspx?id=49117

## Office LTSC 2024

https://learn.microsoft.com/office/ltsc/2024/deploy

## Office LTSC 2021

https://learn.microsoft.com/office/ltsc/2021/deploy

---

# Disclaimer

Project ini merupakan script otomatisasi untuk membantu proses deployment Microsoft Office menggunakan Office Deployment Tool.

Project ini **bukan produk resmi Microsoft** dan tidak berafiliasi dengan Microsoft Corporation.

Microsoft Office merupakan produk dan merek dagang milik Microsoft Corporation.

Pengguna bertanggung jawab memastikan bahwa penggunaan Office memiliki lisensi yang sesuai dengan ketentuan Microsoft.

Project ini tidak menyediakan Product Key, aktivasi ilegal, crack, atau mekanisme bypass lisensi.

---

# Lisensi

Project ini menggunakan lisensi:

```text
MIT License
```

Lihat:

```text
LICENSE
```

---

# Ringkas

Untuk instalasi cepat:

### 1. Buka PowerShell sebagai Administrator

### 2. Jalankan:

```powershell
irm https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 | iex
```

### 3. Pilih:

```text
Versi
  ↓
Edisi
  ↓
Aplikasi
  ↓
Arsitektur
  ↓
Bahasa
  ↓
Konfirmasi
```

### 4. Installer melakukan:

```text
Download ODT
     ↓
Ekstrak ODT
     ↓
Buat XML
     ↓
Download Office
     ↓
Install Office
```

### 5. Selesai

Installer **tidak melakukan aktivasi**. Pastikan Office yang digunakan memiliki lisensi yang sesuai.

---

## Contoh Pilihan Pengguna

Untuk komputer Windows 64-bit dan kebutuhan Office dasar:

```text
Versi       : Office LTSC 2024
Edisi       : Sesuai lisensi
Aplikasi    : Word
              Excel
              PowerPoint
Arsitektur  : 64-bit
Bahasa      : Bahasa Indonesia
```

Yang paling penting:

> **Pilih Product ID dan edisi yang sesuai dengan lisensi yang dimiliki.**

---

## Ringkasan Fitur

```text
┌─────────────────────────────┐
│     OFFICE LTSC 2024        │
│     OFFICE LTSC 2021        │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│ Professional Plus / Standard│
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│      PILIH APLIKASI         │
│                             │
│ [✓] Word                    │
│ [✓] Excel                   │
│ [✓] PowerPoint              │
│ [ ] Outlook                 │
│ [ ] Access                  │
│ [ ] OneNote                 │
│                             │
│ [8] Pilih semua             │
│ [9] Hapus semua             │
│ [0] Lanjutkan               │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│        64-bit / 32-bit      │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│     Indonesia / English     │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│         KONFIRMASI          │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│        DOWNLOAD ODT         │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│       DOWNLOAD OFFICE       │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│        INSTALL OFFICE       │
└──────────────┬──────────────┘
               ↓
┌─────────────────────────────┐
│           SELESAI           │
└─────────────────────────────┘
```
