markdown
# Aktivasi Microsoft Office

## Penting

Repository ini hanya digunakan untuk deployment atau instalasi Office.

Repository ini TIDAK menyediakan:

- Product Key
- KMS ilegal
- Crack
- Activator
- Patch
- Bypass
- Pembajakan lisensi



# Mengapa Tidak Ada Product Key?

Office LTSC merupakan produk yang menggunakan model volume licensing.

Microsoft menyediakan beberapa metode aktivasi untuk lingkungan
yang memiliki lisensi volume yang sesuai.

Contohnya:

- KMS
- MAK

Pengaturan aktivasi tersebut berada di luar fungsi installer ini.



# Installer Tidak Mengaktifkan Office

Configuration yang dibuat installer tidak berisi:

xml
PIDKEY="XXXXX-XXXXX-XXXXX-XXXXX-XXXXX"


Installer juga menggunakan:

xml
<Property Name="AUTOACTIVATE" Value="0" />


Artinya installer tidak sengaja menjalankan proses aktivasi otomatis.

---

# Jika Memiliki Lisensi Resmi

Gunakan metode aktivasi yang disediakan oleh organisasi atau
pemegang lisensi.

Untuk lingkungan perusahaan, hubungi administrator IT.

Untuk lisensi volume, gunakan dokumentasi resmi Microsoft.



# Jika Tidak Memiliki Lisensi

Jangan menggunakan:

* crack
* activator
* KMS emulator
* script aktivasi ilegal
* file DLL hasil modifikasi

Gunakan produk Office yang memiliki lisensi sesuai kebutuhan.



# Status Setelah Instalasi

Office dapat terpasang tanpa proses aktivasi dari script ini.

Namun:

text
TERINSTALL ≠ TERAKTIVASI


Instalasi dan aktivasi merupakan dua hal yang berbeda.

Pengguna tetap harus memiliki lisensi yang sesuai.

