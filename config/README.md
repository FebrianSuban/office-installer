markdown
# Konfigurasi Office

Folder ini berisi contoh `configuration.xml` untuk Office Deployment Tool.

File konfigurasi digunakan oleh:

text
setup.exe /download configuration.xml


dan:

text
setup.exe /configure configuration.xml


---

## Contoh yang tersedia

text
examples/
├── ltsc-2024-proplus.xml
├── ltsc-2024-standard.xml
├── ltsc-2021-proplus.xml
└── ltsc-2021-standard.xml




## Product ID

Office LTSC 2024:

text
ProPlus2024Volume
Standard2024Volume


Office LTSC 2021:

text
ProPlus2021Volume
Standard2021Volume




## Channel

Office LTSC 2024:

text
PerpetualVL2024


Office LTSC 2021:

text
PerpetualVL2021



## Product Key

Contoh konfigurasi dalam repository ini sengaja tidak menggunakan:

xml
PIDKEY="..."


Repository ini tidak menangani aktivasi Office.

Aktivasi harus dilakukan menggunakan lisensi yang sah.


## Arsitektur

Office Deployment Tool menggunakan:

xml
OfficeClientEdition="64"


untuk Office 64-bit.

Sedangkan:

xml
OfficeClientEdition="32"


untuk Office 32-bit.

Jangan memasang Office 32-bit dan 64-bit secara bersamaan
pada perangkat yang sama.


