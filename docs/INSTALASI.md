markdown
# Panduan Instalasi

## 1. Persyaratan

Sebelum menjalankan installer, pastikan:

- Windows 10 atau Windows 11
- Internet aktif
- Memiliki hak Administrator
- Memiliki ruang penyimpanan yang cukup
- Tidak ada proses instalasi Office lain yang sedang berjalan



# 2. Instalasi Otomatis

Cara paling mudah adalah menggunakan PowerShell.

Buka PowerShell.

Kemudian jalankan:

powershell
irm https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 | iex


# 3. Hak Administrator

Installer akan meminta hak Administrator secara otomatis.

Windows akan menampilkan:

text
User Account Control


Pilih:

text
Yes




# 4. Pilih Versi Office

Installer akan menampilkan:

text
[1] Office LTSC 2024
[2] Office LTSC 2021


Masukkan nomor yang diinginkan.



# 5. Pilih Edisi

Pilihan:

text
[1] Professional Plus
[2] Standard




# 6. Pilih Arsitektur

Pilihan:

text
[1] 64-bit
[2] 32-bit


Untuk komputer Windows modern biasanya gunakan 64-bit.



# 7. Pilih Bahasa

Pilihan:

text
[1] Bahasa Indonesia
[2] English




# 8. Konfirmasi

Installer akan menampilkan:

text
Versi
Edisi
Product ID
Arsitektur
Bahasa
Status aktivasi


Jika sudah benar, pilih:

text
Y




# 9. Download

Installer akan:

1. Mengunduh Office Deployment Tool dari Microsoft.
2. Mengekstrak ODT.
3. Membuat configuration.xml.
4. Menjalankan mode download ODT.
5. Mengambil file Office dari CDN Microsoft.

Contoh proses:

text
setup.exe /download configuration.xml


Ukuran download dapat mencapai beberapa GB.

Jangan mematikan komputer selama proses berjalan.


# 10. Instalasi

Setelah download selesai, installer menjalankan:

text
setup.exe /configure configuration.xml


Office kemudian dipasang ke Windows.


# 11. Setelah Instalasi

Setelah selesai, buka:

text
Start Menu


Kemudian cari:

text
Word
Excel
PowerPoint
Outlook


dan aplikasi Office lainnya.


# 12. Aktivasi

Installer ini tidak melakukan aktivasi.

Untuk informasi mengenai lisensi dan aktivasi:

text
docs/AKTIVASI.md



# 13. Jika Instalasi Gagal

Baca:

text
docs/TROUBLESHOOTING.md


Jangan langsung menjalankan activator atau program tidak resmi.

