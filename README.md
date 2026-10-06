# Office Installer

Installer Microsoft Office berbasis **PowerShell** yang menggunakan **Microsoft Office Deployment Tool (ODT)** resmi dari Microsoft.

Installer ini dibuat untuk memudahkan pengguna Windows melakukan instalasi **Office LTSC 2024** atau **Office LTSC 2021** tanpa perlu membuat file konfigurasi XML secara manual.

Installer menyediakan pilihan:

* Versi Office
* Edisi Office
* Aplikasi Office yang ingin diinstal
* Arsitektur 64-bit atau 32-bit
* Bahasa Indonesia atau English

Installer kemudian membuat konfigurasi ODT secara otomatis dan menjalankan proses download serta instalasi Office.

> **Catatan:** Project ini bukan produk resmi Microsoft dan tidak berafiliasi dengan Microsoft.

---

# Cara Termudah

Ikuti langkah berikut untuk menjalankan installer Microsoft Office.

## 1. Buka PowerShell sebagai Administrator

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

### Mengapa harus Administrator?

Installer membutuhkan hak Administrator untuk melakukan beberapa proses seperti:

* Menjalankan Office Deployment Tool.
* Menginstal Office.
* Mengubah komponen Office yang diperlukan.
* Menghapus komponen Office berbasis MSI lama jika diperlukan oleh konfigurasi ODT.

Jika PowerShell tidak dijalankan sebagai Administrator, installer akan mencoba meminta hak Administrator secara otomatis.

---

## 2. Copy Perintah Installer

Copy perintah berikut:

```powershell
irm https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 | iex
```

Cara menyalin:

1. Arahkan mouse ke kotak perintah di atas.
2. Klik tombol **Copy** yang muncul pada kotak kode.
3. Perintah akan tersalin ke clipboard.

---

## 3. Paste Perintah ke PowerShell

Kembali ke jendela **Windows PowerShell** yang tadi dibuka sebagai Administrator.

Kemudian paste perintah yang sudah disalin.

Kamu dapat melakukan paste dengan:

* Klik kanan di dalam jendela PowerShell, atau
* Tekan **Ctrl + V**.

Kemudian tekan **Enter**.

Setelah itu installer akan berjalan dan menampilkan menu pilihan.

---

# Alur Pilihan Installer

Installer akan meminta beberapa pilihan secara berurutan:

```text
Versi Office
     ↓
Edisi Office
     ↓
Aplikasi Office
     ↓
Arsitektur Office
     ↓
Bahasa Office
     ↓
Konfirmasi
     ↓
Download ODT
     ↓
Download Office
     ↓
Install Office
     ↓
Selesai
```

Urutan ini penting karena pilihan sebelumnya menentukan pilihan konfigurasi berikutnya.

---

# Panduan Menu Installer

Jika kamu belum pernah menggunakan installer seperti ini, jangan khawatir.

Installer menggunakan menu sederhana berbasis angka.

Kamu cukup memasukkan nomor pilihan kemudian menekan **Enter**.

Contohnya:

```text
Pilih nomor: 1
```

---

# 1. Pilih Versi Office

Pertama installer akan meminta versi Office.

Contohnya:

```text
Pilih versi Microsoft Office:

[1] Office LTSC 2024
[2] Office LTSC 2021

Pilih nomor:
```

Tersedia:

* Office LTSC 2024
* Office LTSC 2021

## Apa maksud versi Office?

Versi menentukan generasi Office yang akan dipasang.

### Office LTSC 2024

Office LTSC 2024 adalah versi LTSC yang lebih baru.

Pilih **Office LTSC 2024** jika:

* Kamu melakukan instalasi baru.
* Tidak memiliki kebutuhan khusus terhadap Office LTSC 2021.
* Organisasi atau lingkungan kerja menggunakan LTSC 2024.
* Lisensi yang kamu miliki sesuai dengan Office LTSC 2024.

Contoh:

```text
[1] Office LTSC 2024
[2] Office LTSC 2021

Pilih nomor: 1
```

### Office LTSC 2021

Office LTSC 2021 merupakan versi LTSC sebelumnya.

Pilih **Office LTSC 2021** jika:

* Kamu memang membutuhkan Office LTSC 2021.
* Organisasi atau lingkungan kerja menggunakan Office LTSC 2021.
* Kamu memiliki lisensi Office LTSC 2021.
* Ada kebutuhan kompatibilitas tertentu dengan lingkungan yang sudah menggunakan Office LTSC 2021.

Contoh:

```text
[1] Office LTSC 2024
[2] Office LTSC 2021

Pilih nomor: 2
```

## Jika tidak tahu pilih yang mana

Gunakan panduan sederhana:

```text
Ingin menggunakan versi LTSC yang lebih baru?
                ↓
          Office LTSC 2024

Membutuhkan Office LTSC 2021?
                ↓
          Office LTSC 2021
```

> **Penting:** versi Office harus sesuai dengan lisensi yang kamu miliki.

---

# 2. Pilih Edisi Office

Setelah memilih versi, installer akan meminta edisi Office.

Contohnya:

```text
Pilih edisi Microsoft Office:

[1] Professional Plus
[2] Standard

Pilih nomor:
```

Tersedia dua pilihan:

* Professional Plus
* Standard

## Professional Plus

Professional Plus merupakan edisi Office yang ditujukan untuk deployment volume.

Pilih **Professional Plus** jika:

* Lisensi yang kamu miliki memang untuk Professional Plus.
* Organisasi atau perusahaan menggunakan Professional Plus.
* Kamu membutuhkan aplikasi yang tersedia pada edisi tersebut.

Contoh:

```text
[1] Professional Plus
[2] Standard

Pilih nomor: 1
```

## Standard

Standard merupakan edisi Office lainnya yang tersedia untuk deployment volume.

Pilih **Standard** jika:

* Lisensi yang kamu miliki memang untuk Office Standard.
* Organisasi atau perusahaan menggunakan Office Standard.
* Kamu memang membutuhkan edisi Standard.

Contoh:

```text
[1] Professional Plus
[2] Standard

Pilih nomor: 2
```

## Jangan memilih berdasarkan nama saja

Hal yang sangat penting:

**Professional Plus bukan berarti otomatis cocok untuk semua orang.**

Begitu juga:

**Standard bukan berarti Office yang "lebih jelek".**

Edisi harus disesuaikan dengan **jenis lisensi yang kamu miliki**.

Jika lisensi kamu adalah:

```text
Professional Plus
```

gunakan:

```text
Professional Plus
```

Jika lisensi kamu adalah:

```text
Standard
```

gunakan:

```text
Standard
```

---

# 3. Pilih Aplikasi Office

Setelah memilih edisi, installer akan meminta aplikasi Office yang ingin diinstal.

Ini merupakan fitur penting pada installer versi terbaru.

Contoh menu:

```text
============================================================
                 PILIH APLIKASI OFFICE
============================================================

Pilih aplikasi yang ingin diinstal.

Gunakan nomor untuk mencentang atau menghapus pilihan.

[1] [ ] Microsoft Word
    Untuk membuat dan mengedit dokumen.

[2] [ ] Microsoft Excel
    Untuk spreadsheet, tabel, rumus, dan data.

[3] [ ] Microsoft PowerPoint
    Untuk membuat presentasi.

[4] [ ] Microsoft Outlook
    Untuk email, kalender, dan kontak.

[5] [ ] Microsoft Access
    Untuk membuat dan mengelola database.

[6] [ ] Microsoft OneNote
    Untuk membuat catatan digital.

------------------------------------------------------------
[8] [ ] Pilih semua aplikasi
[9] [ ] Hapus semua pilihan
[0]     Lanjutkan
------------------------------------------------------------

Pilih nomor:
```

## Bagaimana cara memilih aplikasi?

Masukkan nomor aplikasi yang ingin dipilih.

Misalnya ingin memilih Word:

```text
Pilih nomor: 1
```

Tampilannya kemudian berubah menjadi:

```text
[1] [✓] Microsoft Word
```

Tanda:

```text
[✓]
```

berarti aplikasi tersebut dipilih.

Jika menekan nomor yang sama lagi, pilihan akan dibatalkan:

```text
[1] [ ]
```

Jadi menu ini menggunakan sistem **toggle**.

---

# Daftar Aplikasi

## Microsoft Word

```text
Microsoft Word
```

Digunakan untuk:

* Membuat dokumen.
* Mengedit dokumen.
* Membuat surat.
* Membuat laporan.
* Membuat tugas.
* Membuat dokumen dengan format teks dan gambar.

Jika sering membuat dokumen, Word biasanya merupakan salah satu aplikasi utama.

---

## Microsoft Excel

```text
Microsoft Excel
```

Digunakan untuk:

* Spreadsheet.
* Tabel.
* Perhitungan.
* Rumus.
* Pengolahan data.
* Grafik.
* Analisis data.

Excel sangat berguna untuk pekerjaan administrasi, keuangan, data, dan pekerjaan kantor lainnya.

---

## Microsoft PowerPoint

```text
Microsoft PowerPoint
```

Digunakan untuk:

* Membuat presentasi.
* Membuat slide.
* Menambahkan gambar.
* Menambahkan diagram.
* Membuat materi presentasi.

PowerPoint biasanya digunakan untuk presentasi sekolah, kuliah, pekerjaan, maupun organisasi.

---

## Microsoft Outlook

```text
Microsoft Outlook
```

Digunakan untuk:

* Email.
* Kalender.
* Kontak.
* Pengelolaan komunikasi dan jadwal.

Outlook lebih berguna untuk pengguna yang memang membutuhkan aplikasi email dan kalender desktop.

---

## Microsoft Access

```text
Microsoft Access
```

Digunakan untuk:

* Membuat database.
* Mengelola database.
* Membuat tabel.
* Membuat form.
* Membuat query.
* Membuat aplikasi database sederhana.

Access lebih cocok untuk pengguna yang membutuhkan database desktop.

---

## Microsoft OneNote

```text
Microsoft OneNote
```

Digunakan untuk:

* Membuat catatan digital.
* Menyimpan catatan.
* Membuat notebook.
* Menyusun informasi dan catatan.

---

## Microsoft Publisher

Microsoft Publisher dapat dipilih pada konfigurasi **Office LTSC 2021** yang didukung oleh installer.

Publisher digunakan untuk membuat:

* Brosur.
* Pamflet.
* Kartu.
* Publikasi sederhana.
* Layout dokumen.

Untuk **Office LTSC 2024**, Publisher tidak ditampilkan pada menu installer.

---

# Pilih Semua Aplikasi

Jika ingin memasang semua aplikasi yang tersedia pada menu, gunakan:

```text
[8] [✓] Pilih semua aplikasi
```

Contohnya:

```text
[1] [✓] Microsoft Word
[2] [✓] Microsoft Excel
[3] [✓] Microsoft PowerPoint
[4] [✓] Microsoft Outlook
[5] [✓] Microsoft Access
[6] [✓] Microsoft OneNote
```

Pada LTSC 2021, Publisher juga akan ikut dipilih apabila tersedia pada daftar.

---

# Hapus Semua Pilihan

Jika ingin membatalkan seluruh pilihan aplikasi, gunakan:

```text
[9] [ ] Hapus semua pilihan
```

Semua aplikasi akan kembali menjadi:

```text
[ ] Microsoft Word
[ ] Microsoft Excel
[ ] Microsoft PowerPoint
...
```

Setelah itu kamu dapat memilih kembali aplikasi yang dibutuhkan.

---

# Lanjutkan

Jika sudah selesai memilih aplikasi, gunakan:

```text
[0] Lanjutkan
```

Installer **tidak akan mengizinkan proses dilanjutkan jika belum ada aplikasi yang dipilih**.

Contohnya jika belum memilih apa pun:

```text
Belum ada aplikasi yang dipilih.

Pilih nomor:
```

Kamu harus memilih minimal satu aplikasi.

---

# Contoh Pemilihan Aplikasi

Misalnya kamu hanya membutuhkan:

* Word
* Excel
* PowerPoint

Pilih:

```text
Pilih nomor: 1
Pilih nomor: 2
Pilih nomor: 3
```

Hasilnya:

```text
[1] [✓] Microsoft Word
[2] [✓] Microsoft Excel
[3] [✓] Microsoft PowerPoint
[4] [ ] Microsoft Outlook
[5] [ ] Microsoft Access
[6] [ ] Microsoft OneNote
```

Kemudian:

```text
[0] Lanjutkan
```

Installer hanya akan mengonfigurasi aplikasi yang dipilih dan mengecualikan aplikasi lainnya melalui konfigurasi ODT.

---

# Mengapa Ada Pilihan Aplikasi?

Fitur ini berguna jika kamu tidak ingin memasang seluruh aplikasi Office.

Misalnya komputer hanya digunakan untuk:

```text
Word
Excel
PowerPoint
```

Maka kamu tidak perlu memilih:

```text
Outlook
Access
OneNote
```

Ini dapat membantu mengurangi aplikasi yang dipasang dan menyesuaikan instalasi dengan kebutuhan pengguna.

---

# Bagaimana Installer Menerapkan Pilihan Aplikasi?

Installer menggunakan fitur konfigurasi resmi Office Deployment Tool:

```xml
<ExcludeApp ID="NamaAplikasi" />
```

Contohnya jika pengguna hanya memilih Word, Excel, dan PowerPoint:

```xml
<Product ID="ProPlus2024Volume">
  <Language ID="id-id" />
  <ExcludeApp ID="Outlook" />
  <ExcludeApp ID="Access" />
  <ExcludeApp ID="OneNote" />
</Product>
```

Dengan demikian, installer tidak perlu membuat installer Office terpisah untuk setiap kombinasi aplikasi.

Script hanya membuat konfigurasi ODT berdasarkan pilihan pengguna.

---

# 4. Pilih Arsitektur Office

Setelah memilih aplikasi, installer akan meminta arsitektur Office.

Contohnya:

```text
Pilih arsitektur Office:

[1] 64-bit (disarankan untuk Windows modern)
[2] 32-bit

Pilih nomor:
```

Tersedia:

* 64-bit
* 32-bit

---

## Apa itu 64-bit dan 32-bit?

64-bit dan 32-bit merupakan **arsitektur perangkat lunak**.

Ini berbeda dengan kapasitas RAM.

Misalnya komputer memiliki:

```text
RAM 8 GB
```

Bukan berarti Office harus menggunakan "8-bit".

Office tetap menggunakan:

```text
64-bit
```

atau:

```text
32-bit
```

---

## 64-bit

Untuk kebanyakan komputer Windows modern, Office 64-bit merupakan pilihan yang umum dan disarankan apabila sistem Windows yang digunakan adalah 64-bit.

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

# Cara Mengetahui Windows 64-bit atau 32-bit

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

Maka umumnya kamu dapat memilih:

```text
[1] 64-bit
```

Jika tertulis:

```text
32-bit operating system
```

maka pilih:

```text
[2] 32-bit
```

---

# Rekomendasi Sederhana Arsitektur

Jika komputer menggunakan Windows 10 atau Windows 11 64-bit dan tidak memiliki kebutuhan khusus terhadap Office 32-bit:

```text
Pilih: 64-bit
```

---

# 5. Pilih Bahasa Office

Selanjutnya installer akan menampilkan pilihan bahasa.

```text
Pilih bahasa Office:

[1] Bahasa Indonesia
[2] English

Pilih nomor:
```

Tersedia:

* Bahasa Indonesia
* English

---

## Bahasa Indonesia

Pilih:

```text
[1] Bahasa Indonesia
```

Jika kamu ingin menggunakan antarmuka Office dalam bahasa Indonesia.

Contoh menu dapat menggunakan istilah seperti:

```text
File
Beranda
Sisipkan
Tata Letak
Tinjau
Tampilan
```

Pilihan ini cocok jika kamu lebih nyaman menggunakan Office dalam bahasa Indonesia.

---

## English

Pilih:

```text
[2] English
```

Jika kamu terbiasa menggunakan Office dalam bahasa Inggris.

Contoh:

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

# 6. Konfirmasi Instalasi

Setelah semua pilihan selesai, installer akan menampilkan ringkasan konfigurasi.

Contohnya:

```text
============================================================
                    KONFIGURASI
============================================================

Versi       : Office LTSC 2024
Edisi       : ProPlus
Product ID  : ProPlus2024Volume
Arsitektur  : 64-bit
Bahasa      : id-id

Aplikasi yang akan diinstal:
  [✓] Microsoft Word
  [✓] Microsoft Excel
  [✓] Microsoft PowerPoint

Aktivasi    : Tidak dilakukan oleh installer
```

Periksa semua informasi sebelum melanjutkan.

Pastikan:

```text
Versi       → sesuai yang diinginkan
Edisi       → sesuai dengan lisensi
Aplikasi    → sesuai kebutuhan
Arsitektur  → sesuai dengan Windows
Bahasa      → sesuai kebutuhan
```

Kemudian installer akan bertanya:

```text
Lanjutkan proses instalasi? (Y/N):
```

Jika semua sudah benar, masukkan:

```text
Y
```

Kemudian tekan **Enter**.

Jika ingin membatalkan, masukkan:

```text
N
```

---

# Contoh Konfigurasi

Misalnya pengguna ingin:

```text
Versi       : Office LTSC 2024
Edisi       : Professional Plus
Aplikasi    : Word + Excel + PowerPoint
Arsitektur  : 64-bit
Bahasa      : Bahasa Indonesia
```

Maka proses pemilihannya kira-kira:

```text
Pilih versi Microsoft Office:

[1] Office LTSC 2024
[2] Office LTSC 2021

Pilih nomor: 1
```

Kemudian:

```text
Pilih edisi Microsoft Office:

[1] Professional Plus
[2] Standard

Pilih nomor: 1
```

Kemudian aplikasi:

```text
[1] [ ] Microsoft Word
[2] [ ] Microsoft Excel
[3] [ ] Microsoft PowerPoint
[4] [ ] Microsoft Outlook
[5] [ ] Microsoft Access
[6] [ ] Microsoft OneNote

[8] [ ] Pilih semua aplikasi
[9] [ ] Hapus semua pilihan
[0]     Lanjutkan

Pilih nomor: 1
Pilih nomor: 2
Pilih nomor: 3
Pilih nomor: 0
```

Kemudian:

```text
Pilih arsitektur Office:

[1] 64-bit (disarankan untuk Windows modern)
[2] 32-bit

Pilih nomor: 1
```

Kemudian:

```text
Pilih bahasa Office:

[1] Bahasa Indonesia
[2] English

Pilih nomor: 1
```

Kemudian installer menampilkan konfigurasi:

```text
============================================================
                    KONFIGURASI
============================================================

Versi       : Office LTSC 2024
Edisi       : ProPlus
Product ID  : ProPlus2024Volume
Arsitektur  : 64-bit
Bahasa      : id-id

Aplikasi yang akan diinstal:
  [✓] Microsoft Word
  [✓] Microsoft Excel
  [✓] Microsoft PowerPoint

Aktivasi    : Tidak dilakukan oleh installer

Lanjutkan proses instalasi? (Y/N):
```

Masukkan:

```text
Y
```

---

# Proses Setelah Konfirmasi

Setelah memilih **Y**, installer akan menjalankan beberapa tahap secara otomatis.

---

# Tahap 1 — Download Office Deployment Tool

Installer akan mengunduh **Microsoft Office Deployment Tool (ODT)** dari halaman resmi Microsoft.

ODT adalah alat resmi Microsoft yang digunakan untuk melakukan deployment Office.

Kamu tidak perlu mengunduh dan memasang ODT secara manual.

Secara umum prosesnya:

```text
Installer
    ↓
Halaman Microsoft
    ↓
Office Deployment Tool
    ↓
Download
```

---

# Tahap 2 — Ekstrak Office Deployment Tool

Setelah ODT berhasil diunduh, installer akan mengekstrak ODT ke folder sementara.

Salah satu file yang digunakan adalah:

```text
setup.exe
```

File tersebut kemudian digunakan untuk menjalankan perintah ODT.

---

# Tahap 3 — Membuat Configuration XML

Installer membuat file:

```text
configuration.xml
```

File ini dibuat secara otomatis berdasarkan pilihan pengguna.

Konfigurasinya dapat berisi:

```text
Product ID
Office version
Edition
Architecture
Language
Channel
ExcludeApp
Update configuration
```

Kamu tidak perlu membuat file XML secara manual.

---

# Tahap 4 — Download File Office

ODT kemudian digunakan untuk mengunduh file Office.

Secara sederhana:

```text
configuration.xml
        ↓
ODT /download
        ↓
Distribusi Microsoft
        ↓
File Office
```

File Office **tidak disimpan di repository GitHub**.

Repository hanya menyimpan script dan konfigurasi yang diperlukan.

Pada tahap ini:

* Pastikan internet tetap terhubung.
* Jangan menutup PowerShell.
* Jangan mematikan komputer.
* Jangan menjalankan installer Office lain secara bersamaan.
* Pastikan ruang penyimpanan mencukupi.

Lama download bergantung pada kecepatan internet dan kondisi jaringan.

---

# Tahap 5 — Install Office

Setelah file Office selesai diunduh, ODT akan menjalankan proses instalasi.

Secara sederhana:

```text
File Office
    ↓
ODT /configure
    ↓
Instalasi Office
```

Tunggu sampai proses selesai.

Jangan menutup jendela PowerShell selama proses berlangsung.

---

# Tahap 6 — Selesai

Jika proses berhasil, installer akan memberikan informasi bahwa instalasi telah selesai.

Aplikasi yang dipilih kemudian dapat dibuka melalui:

```text
Windows
   ↓
Start Menu
   ↓
Microsoft Word
Microsoft Excel
Microsoft PowerPoint
dan aplikasi lain yang dipilih
```

---

# Alur Instalasi Lengkap

Secara keseluruhan:

```text
Buka PowerShell sebagai Administrator
              ↓
Copy perintah installer
              ↓
Paste ke PowerShell
              ↓
Tekan Enter
              ↓
Cek Windows
              ↓
Cek koneksi internet
              ↓
Siapkan folder kerja
              ↓
Pilih versi Office
              ↓
Pilih edisi Office
              ↓
Pilih aplikasi Office
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

# Fitur

Installer menyediakan fitur berikut:

* Instalasi Office LTSC 2024.
* Instalasi Office LTSC 2021.
* Pilihan Professional Plus.
* Pilihan Standard.
* Pilihan aplikasi Office.
* Toggle aplikasi menggunakan nomor.
* Pilihan **Pilih semua aplikasi**.
* Pilihan **Hapus semua pilihan**.
* Validasi minimal satu aplikasi harus dipilih.
* Pilihan 64-bit.
* Pilihan 32-bit.
* Pilihan bahasa Indonesia.
* Pilihan bahasa English.
* Menggunakan Microsoft Office Deployment Tool (ODT).
* Mengunduh ODT dari Microsoft.
* Mengunduh file Office melalui mekanisme distribusi Microsoft.
* Tidak menyimpan installer Office berukuran besar di GitHub.
* Membuat configuration XML secara otomatis.
* Menggunakan `ExcludeApp` untuk aplikasi yang tidak dipilih.
* Tidak membutuhkan pembuatan XML secara manual.
* Mendukung instalasi melalui satu perintah PowerShell.
* Tidak menyertakan Product Key.
* Tidak melakukan aktivasi.
* Tidak melakukan crack.
* Tidak melakukan bypass lisensi.

---

# Persyaratan

Sebelum menjalankan installer, pastikan:

* Windows 10 atau Windows 11 yang kompatibel.
* Koneksi internet aktif.
* PowerShell tersedia.
* Memiliki hak Administrator.
* Ruang penyimpanan yang cukup.
* Tidak sedang menjalankan proses instalasi Office lainnya.
* Lisensi Office yang sesuai dengan produk yang akan digunakan.

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

Jika tidak ingin menggunakan perintah:

```powershell
irm https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 | iex
```

repository dapat di-clone terlebih dahulu.

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

Jika PowerShell belum memiliki hak Administrator, script akan meminta hak Administrator secara otomatis.

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

Installer menggunakan **Office Deployment Tool (ODT)** resmi dari Microsoft.

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
Pilih versi Office
   │
   ▼
Pilih edisi Office
   │
   ▼
Pilih aplikasi Office
   │
   ├── Word
   ├── Excel
   ├── PowerPoint
   ├── Outlook
   ├── Access
   └── OneNote
   │
   ▼
Pilih arsitektur
   │
   ▼
Pilih bahasa
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
* Menentukan edisi Office.
* Menentukan arsitektur.
* Menentukan bahasa.
* Mengecualikan aplikasi yang tidak dipilih.
* Melakukan instalasi Office.

File Office **tidak disimpan di repository GitHub**.

Repository hanya menyimpan script dan konfigurasi yang diperlukan.

---

# Konfigurasi Aplikasi

Installer menggunakan konfigurasi ODT untuk menentukan aplikasi mana yang tidak perlu dipasang.

Contohnya jika pengguna memilih:

```text
Word
Excel
PowerPoint
```

sedangkan Outlook, Access, dan OneNote tidak dipilih, installer akan membuat konfigurasi seperti:

```xml
<Product ID="ProPlus2024Volume">
  <Language ID="id-id" />
  <ExcludeApp ID="Outlook" />
  <ExcludeApp ID="Access" />
  <ExcludeApp ID="OneNote" />
</Product>
```

Pendekatan ini menggunakan fitur konfigurasi resmi ODT.

Installer tidak memodifikasi file Office dan tidak menggunakan patch atau bypass.

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

Sebelum menjalankan perintah PowerShell yang mengambil script dari internet, pengguna disarankan untuk memeriksa isi script terlebih dahulu.

Script utama:

```text
Install-Office.ps1
```

---

# Melihat Script Sebelum Menjalankan

Jika ingin melihat isi script terlebih dahulu, buka halaman repository:

```text
https://github.com/FebrianSuban/office-installer/blob/main/Install-Office.ps1
```

Atau download script menggunakan:

```powershell
Invoke-WebRequest https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 -OutFile Install-Office.ps1
```

Kemudian buka menggunakan Visual Studio Code:

```powershell
code .\Install-Office.ps1
```

Jika Visual Studio Code tidak tersedia:

```powershell
notepad .\Install-Office.ps1
```

Dengan cara ini kamu dapat melihat isi script sebelum menjalankannya.

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

Folder tersebut digunakan untuk menyimpan sementara beberapa file yang diperlukan selama proses, seperti:

```text
officedeploymenttool.exe
setup.exe
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

Installer perlu mengakses layanan Microsoft untuk mendapatkan ODT dan file Office.

## 2. Ruang Penyimpanan

Pastikan drive sistem memiliki ruang kosong yang cukup.

File Office yang diunduh dapat berukuran cukup besar.

## 3. Office yang Sudah Terpasang

Office versi lain yang sudah terpasang dapat menyebabkan konflik.

Installer menggunakan:

```xml
<RemoveMSI />
```

untuk menangani Office berbasis MSI lama, tetapi konflik dengan instalasi Office lain, terutama konfigurasi Click-to-Run tertentu, tetap dapat terjadi.

## 4. Hak Administrator

Pastikan PowerShell dijalankan menggunakan:

```text
Run as Administrator
```

## 5. Pilihan Product dan Lisensi

Pastikan:

```text
Versi Office
Edisi Office
```

sesuai dengan lisensi yang kamu miliki.

## 6. Pesan Error

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

Dokumentasi tambahan tersedia pada folder:

```text
docs/
├── INSTALASI.md
├── AKTIVASI.md
└── TROUBLESHOOTING.md
```

Contoh konfigurasi tersedia pada:

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

Project ini tidak menyediakan Product Key, aktivasi ilegal, crack, atau mekanisme bypass lisensi.

---

# Lisensi

Project ini menggunakan lisensi **MIT**.

Lihat file:

```text
LICENSE
```

---

# Sumber Resmi Microsoft

## Office Deployment Tool

```text
https://www.microsoft.com/download/details.aspx?id=49117
```

## Dokumentasi Office LTSC 2024

```text
https://learn.microsoft.com/office/ltsc/2024/deploy
```

## Dokumentasi Office LTSC 2021

```text
https://learn.microsoft.com/office/ltsc/2021/deploy
```

---

# Ringkas

Jika hanya ingin menginstal Office:

## 1. Buka PowerShell sebagai Administrator

Tekan:

```text
Windows (⊞)
```

Kemudian ketik:

```text
PowerShell
```

Klik kanan **Windows PowerShell** → **Run as Administrator** → **Yes**.

## 2. Copy perintah berikut

```powershell
irm https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 | iex
```

## 3. Paste ke PowerShell

Tekan:

```text
Ctrl + V
```

Kemudian tekan:

```text
Enter
```

## 4. Ikuti pilihan yang ditampilkan

```text
Pilih versi
   ↓
Pilih edisi
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
Download Office
   ↓
Install
   ↓
Selesai
```

**Tidak perlu membuat XML, mengunduh ODT secara manual, atau melakukan konfigurasi ODT secara manual.**

---

# Contoh Pilihan untuk Pengguna Umum

Jika komputer menggunakan Windows modern 64-bit dan pengguna membutuhkan aplikasi Office dasar, contoh pilihan dapat berupa:

```text
Versi       : Office LTSC 2024
Edisi       : Sesuai dengan lisensi
Aplikasi    : Word
              Excel
              PowerPoint
Arsitektur  : 64-bit
Bahasa      : Bahasa Indonesia
```

Namun, **edisi Office tetap harus disesuaikan dengan lisensi yang dimiliki**.

Tidak semua pengguna harus memilih Professional Plus.

---

# Ringkasan Fitur Installer Terbaru

Versi installer terbaru memiliki alur:

```text
┌───────────────────────────┐
│     Office LTSC 2024      │
│     Office LTSC 2021      │
└─────────────┬─────────────┘
              ↓
┌───────────────────────────┐
│ Professional Plus /       │
│ Standard                  │
└─────────────┬─────────────┘
              ↓
┌───────────────────────────┐
│     PILIH APLIKASI        │
│                           │
│ [✓] Word                  │
│ [✓] Excel                 │
│ [ ] PowerPoint            │
│ [ ] Outlook               │
│ [ ] Access                │
│ [ ] OneNote               │
│                           │
│ [8] Pilih semua           │
│ [9] Hapus semua            │
│ [0] Lanjutkan             │
└─────────────┬─────────────┘
              ↓
┌───────────────────────────┐
│      64-bit / 32-bit      │
└─────────────┬─────────────┘
              ↓
┌───────────────────────────┐
│   Indonesia / English     │
└─────────────┬─────────────┘
              ↓
┌───────────────────────────┐
│        KONFIRMASI         │
└─────────────┬─────────────┘
              ↓
┌───────────────────────────┐
│       DOWNLOAD ODT        │
└─────────────┬─────────────┘
              ↓
┌───────────────────────────┐
│      DOWNLOAD OFFICE      │
└─────────────┬─────────────┘
              ↓
┌───────────────────────────┐
│       INSTALL OFFICE      │
└─────────────┬─────────────┘
              ↓
┌───────────────────────────┐
│          SELESAI           │
└───────────────────────────┘
```
