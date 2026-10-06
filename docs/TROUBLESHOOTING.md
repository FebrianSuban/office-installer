markdown
# Troubleshooting

Dokumen ini berisi solusi untuk masalah umum saat menjalankan
Office Installer.



# 1. PowerShell Tidak Bisa Menjalankan Script

Jika muncul pesan seperti:

text
running scripts is disabled on this system


gunakan:

powershell
powershell -ExecutionPolicy Bypass -File .\Install-Office.ps1


Untuk metode online:

powershell
irm https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1 | iex




# 2. UAC Tidak Muncul

Pastikan PowerShell dijalankan dari akun Windows yang mempunyai
hak Administrator.

Installer memang membutuhkan hak Administrator untuk memasang Office.



# 3. Tidak Bisa Download ODT

Pastikan Microsoft dapat diakses:

text
https://www.microsoft.com


Coba:

powershell
Invoke-WebRequest https://www.microsoft.com -UseBasicParsing


Jika gagal:

* periksa koneksi internet
* matikan VPN sementara
* periksa proxy
* periksa firewall
* coba jaringan lain



# 4. Download Office Gagal

Office LTSC diambil melalui CDN Microsoft.

Pastikan:

* internet stabil
* ruang disk cukup
* tidak ada firewall yang memblokir Office
* tidak ada antivirus yang memblokir proses setup.exe

Coba jalankan kembali installer.

ODT dapat melanjutkan download file yang belum lengkap pada
folder sumber yang sama.



# 5. Office Lama Masih Terpasang

Installer menggunakan:

xml
<RemoveMSI />


untuk membantu menghapus instalasi Office berbasis MSI lama.

Namun Office Click-to-Run yang sudah terpasang dapat menyebabkan
konflik produk atau channel.

Jika terjadi konflik:

1. Buka Settings.
2. Masuk ke Apps.
3. Cari Microsoft Office.
4. Hapus instalasi Office lama.
5. Restart Windows.
6. Jalankan installer kembali.


# 6. Error Arsitektur 32-bit / 64-bit

Office tidak dapat mencampurkan arsitektur 32-bit dan 64-bit
pada instalasi yang sama.

Contoh:

text
Office lama 32-bit
+
Office baru 64-bit


dapat menyebabkan konflik.

Solusinya adalah menghapus Office lama terlebih dahulu.

Kemudian install Office dengan arsitektur yang diinginkan.



# 7. Office Tidak Muncul di Start Menu

Tunggu beberapa menit setelah instalasi selesai.

Kemudian coba:

text
Start


dan cari:

text
Word
Excel
PowerPoint


Jika masih tidak muncul, restart Windows.



# 8. Instalasi Berhenti

Jangan langsung mematikan komputer.

Tunggu beberapa menit.

Jika benar-benar berhenti:

1. Catat pesan error.
2. Tutup installer.
3. Restart Windows.
4. Jalankan installer kembali.



# 9. Error Product ID

Pastikan Product ID sesuai.

Office LTSC 2024:

text
ProPlus2024Volume
Standard2024Volume


Office LTSC 2021:

text
ProPlus2021Volume
Standard2021Volume


Jangan mengubah Product ID sembarangan.



# 10. Error Channel

Office LTSC 2024:

text
PerpetualVL2024


Office LTSC 2021:

text
PerpetualVL2021


Jangan menggunakan:

text
Current
MonthlyEnterprise
SemiAnnual


untuk konfigurasi LTSC ini.



# 11. Melihat Log Office

ODT menyimpan log instalasi pada folder TEMP Windows.

Buka PowerShell:

powershell
explorer $env:TEMP


Cari file log Office.



# 12. Menjalankan ODT Secara Manual

Jika installer otomatis mengalami masalah, ODT dapat dijalankan
secara manual.

Download:

text
https://www.microsoft.com/download/details.aspx?id=49117


Ekstrak ODT.

Kemudian gunakan:

powershell
setup.exe /download configuration.xml


Setelah download selesai:

powershell
setup.exe /configure configuration.xml




# 13. Jangan Menggunakan Activator

Jika Office meminta aktivasi, jangan menggunakan program activator
yang tidak dikenal.

Installer ini tidak menangani aktivasi.

Gunakan lisensi dan metode aktivasi yang sah.



# 14. Membuka Issue GitHub

Jika masalah tetap terjadi, buat Issue di repository GitHub.

Sertakan:

* Versi Windows
* 32-bit / 64-bit
* Office LTSC 2021 / 2024
* Edisi Office
* Pesan error
* Exit Code
* Log yang relevan

Jangan mengunggah:

* Product Key
* Password
* Token
* Credential
* Data pribadi

