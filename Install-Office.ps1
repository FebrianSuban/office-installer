#Requires -Version 5.1

<#
.SYNOPSIS
    Installer Microsoft Office LTSC 2024 / 2021 menggunakan
    Office Deployment Tool (ODT) resmi Microsoft.

.DESCRIPTION
    Script ini dibuat untuk pengguna Windows di Indonesia.

    Fitur:
    - Pilih Office LTSC 2024 atau LTSC 2021
    - Pilih Professional Plus atau Standard
    - Pilih aplikasi Office yang ingin diinstal
    - Pilih arsitektur 64-bit atau 32-bit
    - Pilih bahasa Indonesia atau Inggris
    - Download ODT dari Microsoft
    - Membuat configuration.xml otomatis
    - Download file Office dari CDN Microsoft
    - Install Office menggunakan ODT
    - Tidak menyertakan Product Key
    - Tidak melakukan aktivasi
    - Tidak menggunakan KMS, crack, patch, atau bypass lisensi
#>

$ErrorActionPreference = "Stop"

# ============================================================
# KONFIGURASI REPOSITORY
# ============================================================

$RepositoryScriptUrl = "https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1"

# Halaman resmi Microsoft untuk Office Deployment Tool
$MicrosoftODTPage = "https://www.microsoft.com/download/details.aspx?id=49117"

# Folder kerja installer
$WorkDirectory = Join-Path $env:TEMP "Office-Installer"

# Folder ODT
$ODTDirectory = Join-Path $WorkDirectory "ODT"

# File configuration
$ConfigurationFile = Join-Path $WorkDirectory "configuration.xml"

# ============================================================
# FUNGSI TAMPILAN
# ============================================================

function Write-Judul {

    Clear-Host

    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "          OFFICE INSTALLER - WINDOWS" -ForegroundColor White
    Write-Host "          Office LTSC 2024 / LTSC 2021" -ForegroundColor White
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
}

function Write-Sukses {

    param(
        [string]$Pesan
    )

    Write-Host "[OK] $Pesan" -ForegroundColor Green
}

function Write-Info {

    param(
        [string]$Pesan
    )

    Write-Host "[INFO] $Pesan" -ForegroundColor Cyan
}

function Write-Peringatan {

    param(
        [string]$Pesan
    )

    Write-Host "[PERINGATAN] $Pesan" -ForegroundColor Yellow
}

function Write-Gagal {

    param(
        [string]$Pesan
    )

    Write-Host "[GAGAL] $Pesan" -ForegroundColor Red
}

function Pause-Script {

    Write-Host ""
    Read-Host "Tekan ENTER untuk melanjutkan"
}

# ============================================================
# CEK ADMINISTRATOR
# ============================================================

function Test-Administrator {

    $CurrentIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()

    $Principal = New-Object Security.Principal.WindowsPrincipal($CurrentIdentity)

    return $Principal.IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator
    )
}

function Request-Administrator {

    if (Test-Administrator) {
        return
    }

    Write-Host ""
    Write-Host "Installer membutuhkan hak Administrator." -ForegroundColor Yellow
    Write-Host "Windows akan menampilkan jendela UAC." -ForegroundColor Yellow
    Write-Host ""

    try {

        # ----------------------------------------------------
        # Jika script dijalankan sebagai file .ps1
        # ----------------------------------------------------

        if ($PSCommandPath) {

            Start-Process `
                -FilePath "powershell.exe" `
                -Verb RunAs `
                -ArgumentList @(
                    "-NoProfile"
                    "-ExecutionPolicy"
                    "Bypass"
                    "-File"
                    "`"$PSCommandPath`""
                )

            exit
        }

        # ----------------------------------------------------
        # Jika script dijalankan menggunakan:
        #
        # irm URL | iex
        #
        # Download ulang script ke TEMP lalu jalankan
        # sebagai Administrator.
        # ----------------------------------------------------

        if ([string]::IsNullOrWhiteSpace($RepositoryScriptUrl)) {

            Write-Gagal "URL repository belum dikonfigurasi."
            exit 1
        }

        $ElevatedScript = Join-Path `
            $env:TEMP `
            "Office-Installer-Elevated.ps1"

        Write-Info "Mempersiapkan installer dengan hak Administrator..."

        Invoke-WebRequest `
            -Uri $RepositoryScriptUrl `
            -OutFile $ElevatedScript `
            -UseBasicParsing

        Start-Process `
            -FilePath "powershell.exe" `
            -Verb RunAs `
            -ArgumentList @(
                "-NoProfile"
                "-ExecutionPolicy"
                "Bypass"
                "-File"
                "`"$ElevatedScript`""
            )

        exit

    }
    catch {

        Write-Gagal "Gagal mendapatkan hak Administrator."

        Write-Host ""
        Write-Host $_.Exception.Message -ForegroundColor Red
        Write-Host ""

        exit 1
    }
}

# ============================================================
# CEK WINDOWS
# ============================================================

function Test-Windows {

    Write-Info "Memeriksa sistem Windows..."

    $OS = Get-CimInstance Win32_OperatingSystem

    if ($OS.Caption -notmatch "Windows 10|Windows 11|Windows Server") {

        Write-Gagal "Sistem operasi ini tidak didukung oleh installer."

        Write-Host ""
        Write-Host "Windows terdeteksi:" -ForegroundColor Yellow
        Write-Host $OS.Caption
        Write-Host ""

        exit 1
    }

    Write-Sukses "Windows terdeteksi: $($OS.Caption)"
}

# ============================================================
# CEK INTERNET
# ============================================================

function Test-Internet {

    Write-Info "Memeriksa koneksi internet..."

    try {

        $Response = Invoke-WebRequest `
            -Uri "https://www.microsoft.com" `
            -Method Head `
            -UseBasicParsing `
            -TimeoutSec 15

        if ($Response.StatusCode -ge 200 -and
            $Response.StatusCode -lt 500) {

            Write-Sukses "Koneksi internet tersedia."
        }
        else {

            throw "Microsoft tidak dapat diakses."
        }
    }
    catch {

        Write-Gagal "Tidak dapat mengakses Microsoft."

        Write-Host ""
        Write-Host "Pastikan:" -ForegroundColor Yellow
        Write-Host "- Internet aktif"
        Write-Host "- Tidak menggunakan captive portal"
        Write-Host "- Firewall tidak memblokir PowerShell"
        Write-Host ""

        exit 1
    }
}

# ============================================================
# MEMBERSIHKAN FOLDER LAMA
# ============================================================

function Initialize-WorkDirectory {

    Write-Info "Menyiapkan folder installer..."

    if (Test-Path $WorkDirectory) {

        try {

            Remove-Item `
                -Path $WorkDirectory `
                -Recurse `
                -Force `
                -ErrorAction SilentlyContinue
        }
        catch {

            Write-Peringatan `
                "Folder lama tidak dapat dibersihkan sepenuhnya."
        }
    }

    New-Item `
        -ItemType Directory `
        -Path $WorkDirectory `
        -Force | Out-Null

    New-Item `
        -ItemType Directory `
        -Path $ODTDirectory `
        -Force | Out-Null

    Write-Sukses "Folder kerja siap."
}

# ============================================================
# DOWNLOAD ODT
# ============================================================

function Get-ODT {

    Write-Host ""
    Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "TAHAP 1 - DOWNLOAD OFFICE DEPLOYMENT TOOL" -ForegroundColor White
    Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host ""

    Write-Info "Membuka halaman resmi Microsoft..."

    Write-Host ""
    Write-Host "Microsoft Office Deployment Tool:" -ForegroundColor Gray
    Write-Host $MicrosoftODTPage -ForegroundColor DarkGray
    Write-Host ""

    try {

        $Page = Invoke-WebRequest `
            -Uri $MicrosoftODTPage `
            -UseBasicParsing

        $Links = @()

        foreach ($Link in $Page.Links) {

            if ($null -ne $Link.href) {

                $Href = [string]$Link.href

                if ($Href -match "download\.microsoft\.com" -and
                    $Href -match "\.exe") {

                    $Links += $Href
                }
            }
        }

        # Cari file Office Deployment Tool
        $ODTLink = $Links |
            Where-Object {
                $_ -match "officedeploymenttool"
            } |
            Select-Object -First 1

        if ([string]::IsNullOrWhiteSpace($ODTLink)) {

            throw `
                "Link Office Deployment Tool tidak ditemukan pada halaman Microsoft."
        }

        if ($ODTLink.StartsWith("//")) {

            $ODTLink = "https:$ODTLink"
        }

        if ($ODTLink.StartsWith("/")) {

            $ODTLink = "https://www.microsoft.com$ODTLink"
        }

        # Pastikan link berasal dari Microsoft
        $UriObject = [System.Uri]$ODTLink

        if ($UriObject.Host -notmatch "microsoft\.com$") {

            throw "Sumber ODT bukan domain Microsoft."
        }

        Write-Info "Link ODT ditemukan."

        $ODTInstaller = Join-Path `
            $WorkDirectory `
            "officedeploymenttool.exe"

        Write-Info "Mengunduh Office Deployment Tool..."

        Invoke-WebRequest `
            -Uri $ODTLink `
            -OutFile $ODTInstaller `
            -UseBasicParsing

        if (-not (Test-Path $ODTInstaller)) {

            throw "File ODT tidak ditemukan setelah download."
        }

        $FileSize = (Get-Item $ODTInstaller).Length

        if ($FileSize -lt 100000) {

            throw `
                "File ODT terlalu kecil atau download tidak valid."
        }

        Write-Sukses `
            "Office Deployment Tool berhasil diunduh."

        return $ODTInstaller
    }
    catch {

        Write-Gagal `
            "Gagal mengunduh Office Deployment Tool."

        Write-Host ""
        Write-Host $_.Exception.Message -ForegroundColor Red
        Write-Host ""

        Write-Host `
            "Kamu dapat mengunduh ODT secara manual dari:" `
            -ForegroundColor Yellow

        Write-Host `
            $MicrosoftODTPage `
            -ForegroundColor Cyan

        Write-Host ""

        exit 1
    }
}

# ============================================================
# EKSTRAK ODT
# ============================================================

function Expand-ODT {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Installer
    )

    Write-Info "Mengekstrak Office Deployment Tool..."

    try {

        $Process = Start-Process `
            -FilePath $Installer `
            -ArgumentList "/quiet", "/extract:`"$ODTDirectory`"" `
            -Wait `
            -PassThru `
            -WindowStyle Hidden

        if ($Process.ExitCode -ne 0) {

            throw `
                "ODT gagal diekstrak. Exit Code: $($Process.ExitCode)"
        }

        $SetupFile = Join-Path `
            $ODTDirectory `
            "setup.exe"

        if (-not (Test-Path $SetupFile)) {

            throw `
                "setup.exe tidak ditemukan setelah ekstraksi."
        }

        Write-Sukses `
            "Office Deployment Tool berhasil diekstrak."

        return $SetupFile
    }
    catch {

        Write-Gagal `
            "Gagal mengekstrak Office Deployment Tool."

        Write-Host ""
        Write-Host $_.Exception.Message -ForegroundColor Red

        exit 1
    }
}

# ============================================================
# MENU UMUM
# ============================================================

function Show-Menu {

    param(
        [string]$Judul,
        [array]$Pilihan
    )

    Write-Host ""
    Write-Host $Judul -ForegroundColor White
    Write-Host ""

    for ($i = 0; $i -lt $Pilihan.Count; $i++) {

        Write-Host `
            "[$($i + 1)] $($Pilihan[$i].Label)" `
            -ForegroundColor Gray
    }

    Write-Host ""

    while ($true) {

        $InputUser = Read-Host "Pilih nomor"

        $Nomor = 0

        if ([int]::TryParse(
            $InputUser,
            [ref]$Nomor
        )) {

            if ($Nomor -ge 1 -and
                $Nomor -le $Pilihan.Count) {

                return $Pilihan[$Nomor - 1].Value
            }
        }

        Write-Peringatan `
            "Pilihan tidak valid. Masukkan nomor yang tersedia."
    }
}

# ============================================================
# PILIH VERSI OFFICE
# ============================================================

function Select-OfficeVersion {

    $Pilihan = @(
        [PSCustomObject]@{
            Label = "Office LTSC 2024"
            Value = "2024"
        }

        [PSCustomObject]@{
            Label = "Office LTSC 2021"
            Value = "2021"
        }
    )

    return Show-Menu `
        -Judul "Pilih versi Microsoft Office:" `
        -Pilihan $Pilihan
}

# ============================================================
# PILIH EDISI OFFICE
# ============================================================

function Select-OfficeEdition {

    $Pilihan = @(
        [PSCustomObject]@{
            Label = "Professional Plus"
            Value = "ProPlus"
        }

        [PSCustomObject]@{
            Label = "Standard"
            Value = "Standard"
        }
    )

    return Show-Menu `
        -Judul "Pilih edisi Microsoft Office:" `
        -Pilihan $Pilihan
}

# ============================================================
# PILIH APLIKASI OFFICE
# ============================================================

function Select-OfficeApps {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Version
    )

    # --------------------------------------------------------
    # Daftar aplikasi yang ditampilkan.
    #
    # Publisher hanya ditampilkan untuk LTSC 2021.
    # Publisher tidak ditampilkan untuk LTSC 2024.
    # --------------------------------------------------------

    $OfficeApps = @(
        [PSCustomObject]@{
            Id = "Word"
            Label = "Microsoft Word"
            Description = "Untuk membuat dan mengedit dokumen."
        }

        [PSCustomObject]@{
            Id = "Excel"
            Label = "Microsoft Excel"
            Description = "Untuk spreadsheet, tabel, rumus, dan data."
        }

        [PSCustomObject]@{
            Id = "PowerPoint"
            Label = "Microsoft PowerPoint"
            Description = "Untuk membuat presentasi."
        }

        [PSCustomObject]@{
            Id = "Outlook"
            Label = "Microsoft Outlook"
            Description = "Untuk email, kalender, dan kontak."
        }

        [PSCustomObject]@{
            Id = "Access"
            Label = "Microsoft Access"
            Description = "Untuk membuat dan mengelola database."
        }

        [PSCustomObject]@{
            Id = "OneNote"
            Label = "Microsoft OneNote"
            Description = "Untuk membuat catatan digital."
        }
    )

    if ($Version -eq "2021") {

        $OfficeApps += [PSCustomObject]@{
            Id = "Publisher"
            Label = "Microsoft Publisher"
            Description = "Untuk membuat desain dan publikasi."
        }
    }

    # --------------------------------------------------------
    # Pilihan awal kosong.
    # --------------------------------------------------------

    $SelectedApps = @()

    while ($true) {

        Clear-Host

        Write-Host ""
        Write-Host "============================================================" -ForegroundColor Cyan
        Write-Host "                 PILIH APLIKASI OFFICE" -ForegroundColor White
        Write-Host "============================================================" -ForegroundColor Cyan
        Write-Host ""

        Write-Host "Pilih aplikasi yang ingin diinstal." -ForegroundColor Gray
        Write-Host ""
        Write-Host "Gunakan nomor untuk mencentang atau menghapus pilihan." -ForegroundColor Gray
        Write-Host ""

        # ----------------------------------------------------
        # Tampilkan aplikasi
        # ----------------------------------------------------

        for ($i = 0; $i -lt $OfficeApps.Count; $i++) {

            $App = $OfficeApps[$i]

            if ($SelectedApps -contains $App.Id) {

                $Check = "[✓]"
                $Color = "Green"
            }
            else {

                $Check = "[ ]"
                $Color = "Gray"
            }

            Write-Host `
                "[$($i + 1)] $Check $($App.Label)" `
                -ForegroundColor $Color

            Write-Host `
                "    $($App.Description)" `
                -ForegroundColor DarkGray

            Write-Host ""
        }

        # ----------------------------------------------------
        # Nomor menu tambahan
        # ----------------------------------------------------

        $SelectAllNumber = 8
        $ClearAllNumber = 9
        $ContinueNumber = 0

        Write-Host "------------------------------------------------------------" `
            -ForegroundColor DarkGray

        if ($SelectedApps.Count -eq $OfficeApps.Count) {

            Write-Host `
                "[$SelectAllNumber] [✓] Pilih semua aplikasi" `
                -ForegroundColor Green
        }
        else {

            Write-Host `
                "[$SelectAllNumber] [ ] Pilih semua aplikasi" `
                -ForegroundColor Gray
        }

        Write-Host `
            "[$ClearAllNumber] [ ] Hapus semua pilihan" `
            -ForegroundColor Yellow

        Write-Host `
            "[$ContinueNumber]     Lanjutkan" `
            -ForegroundColor Cyan

        Write-Host "------------------------------------------------------------" `
            -ForegroundColor DarkGray

        Write-Host ""

        if ($SelectedApps.Count -eq 0) {

            Write-Host `
                "Belum ada aplikasi yang dipilih." `
                -ForegroundColor Yellow
        }
        else {

            Write-Host `
                "Aplikasi terpilih: $($SelectedApps.Count)" `
                -ForegroundColor Green
        }

        Write-Host ""

        $InputUser = Read-Host "Pilih nomor"

        # ----------------------------------------------------
        # Lanjutkan
        # ----------------------------------------------------

        if ($InputUser -eq "0") {

            if ($SelectedApps.Count -eq 0) {

                Write-Host ""

                Write-Peringatan `
                    "Pilih minimal satu aplikasi sebelum melanjutkan."

                Start-Sleep -Seconds 1

                continue
            }

            return @($SelectedApps)
        }

        # ----------------------------------------------------
        # Pilih semua
        # ----------------------------------------------------

        if ($InputUser -eq "8") {

            $SelectedApps = @(
                $OfficeApps | ForEach-Object {
                    $_.Id
                }
            )

            continue
        }

        # ----------------------------------------------------
        # Hapus semua
        # ----------------------------------------------------

        if ($InputUser -eq "9") {

            $SelectedApps = @()

            continue
        }

        # ----------------------------------------------------
        # Toggle aplikasi individual
        # ----------------------------------------------------

        $Number = 0

        if ([int]::TryParse(
            $InputUser,
            [ref]$Number
        )) {

            if ($Number -ge 1 -and
                $Number -le $OfficeApps.Count) {

                $SelectedId = $OfficeApps[$Number - 1].Id

                if ($SelectedApps -contains $SelectedId) {

                    $SelectedApps = @(
                        $SelectedApps |
                        Where-Object {
                            $_ -ne $SelectedId
                        }
                    )
                }
                else {

                    $SelectedApps = @(
                        $SelectedApps
                        $SelectedId
                    )
                }

                continue
            }
        }

        Write-Peringatan `
            "Pilihan tidak valid."

        Start-Sleep -Seconds 1
    }
}

# ============================================================
# PILIH ARSITEKTUR
# ============================================================

function Select-Architecture {

    $Pilihan = @(
        [PSCustomObject]@{
            Label = "64-bit (disarankan untuk Windows modern)"
            Value = "64"
        }

        [PSCustomObject]@{
            Label = "32-bit"
            Value = "32"
        }
    )

    return Show-Menu `
        -Judul "Pilih arsitektur Office:" `
        -Pilihan $Pilihan
}

# ============================================================
# PILIH BAHASA
# ============================================================

function Select-Language {

    $Pilihan = @(
        [PSCustomObject]@{
            Label = "Bahasa Indonesia"
            Value = "id-id"
        }

        [PSCustomObject]@{
            Label = "English"
            Value = "en-us"
        }
    )

    return Show-Menu `
        -Judul "Pilih bahasa Office:" `
        -Pilihan $Pilihan
}

# ============================================================
# MEMBENTUK PRODUCT ID
# ============================================================

function Get-ProductId {

    param(
        [string]$Version,
        [string]$Edition
    )

    if ($Version -eq "2024") {

        if ($Edition -eq "ProPlus") {

            return "ProPlus2024Volume"
        }

        return "Standard2024Volume"
    }

    if ($Version -eq "2021") {

        if ($Edition -eq "ProPlus") {

            return "ProPlus2021Volume"
        }

        return "Standard2021Volume"
    }

    throw "Versi Office tidak valid."
}

# ============================================================
# MEMBENTUK CHANNEL
# ============================================================

function Get-Channel {

    param(
        [string]$Version
    )

    if ($Version -eq "2024") {

        return "PerpetualVL2024"
    }

    if ($Version -eq "2021") {

        return "PerpetualVL2021"
    }

    throw "Versi Office tidak valid."
}

# ============================================================
# MEMBUAT EXCLUDE APP XML
# ============================================================

function Get-ExcludeAppXml {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Version,

        [Parameter(Mandatory = $true)]
        [array]$SelectedApps
    )

    # --------------------------------------------------------
    # Semua aplikasi yang kita kelola melalui menu.
    # --------------------------------------------------------

    $AllApps = @(
        "Word"
        "Excel"
        "PowerPoint"
        "Outlook"
        "Access"
        "OneNote"
    )

    # Publisher hanya relevan untuk LTSC 2021
    if ($Version -eq "2021") {

        $AllApps += "Publisher"
    }

    $ExcludeLines = @()

    foreach ($App in $AllApps) {

        if ($SelectedApps -notcontains $App) {

            $ExcludeLines += `
                "      <ExcludeApp ID=`"$App`" />"
        }
    }

    if ($ExcludeLines.Count -eq 0) {

        return ""
    }

    return ($ExcludeLines -join "`r`n")
}

# ============================================================
# MEMBUAT CONFIGURATION XML
# ============================================================

function New-Configuration {

    param(
        [string]$Version,
        [string]$Edition,
        [string]$Architecture,
        [string]$Language,
        [array]$SelectedApps
    )

    $ProductId = Get-ProductId `
        -Version $Version `
        -Edition $Edition

    $Channel = Get-Channel `
        -Version $Version

    Write-Host ""
    Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "TAHAP 2 - KONFIGURASI OFFICE" -ForegroundColor White
    Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host ""

    Write-Info "Membuat configuration.xml..."

    # --------------------------------------------------------
    # Membentuk ExcludeApp berdasarkan pilihan user.
    # --------------------------------------------------------

    $ExcludeXml = Get-ExcludeAppXml `
        -Version $Version `
        -SelectedApps $SelectedApps

    # --------------------------------------------------------
    # Tidak ada PIDKEY.
    # Tidak ada aktivasi.
    # Office mengambil file dari CDN Microsoft.
    # --------------------------------------------------------

    $Xml = @"
<Configuration>
  <Add OfficeClientEdition="$Architecture" Channel="$Channel">
    <Product ID="$ProductId">
      <Language ID="$Language" />
$ExcludeXml
    </Product>
  </Add>

  <RemoveMSI />

  <Display Level="Full" AcceptEULA="TRUE" />

  <Property Name="AUTOACTIVATE" Value="0" />

  <Updates Enabled="TRUE" Channel="$Channel" />
</Configuration>
"@

    Set-Content `
        -Path $ConfigurationFile `
        -Value $Xml `
        -Encoding UTF8

    Write-Sukses `
        "configuration.xml berhasil dibuat."

    return $ProductId
}

# ============================================================
# TAMPILKAN KONFIGURASI
# ============================================================

function Show-Configuration {

    param(
        [string]$Version,
        [string]$Edition,
        [string]$Architecture,
        [string]$Language,
        [string]$ProductId,
        [array]$SelectedApps
    )

    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "                    KONFIGURASI" -ForegroundColor White
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "Versi       : Office LTSC $Version"
    Write-Host "Edisi       : $Edition"
    Write-Host "Product ID  : $ProductId"
    Write-Host "Arsitektur  : $Architecture-bit"
    Write-Host "Bahasa      : $Language"

    Write-Host ""
    Write-Host "Aplikasi yang akan diinstal:" -ForegroundColor Yellow

    $AppLabels = @{
        "Word"       = "Microsoft Word"
        "Excel"      = "Microsoft Excel"
        "PowerPoint" = "Microsoft PowerPoint"
        "Outlook"    = "Microsoft Outlook"
        "Access"     = "Microsoft Access"
        "OneNote"    = "Microsoft OneNote"
        "Publisher"  = "Microsoft Publisher"
    }

    foreach ($AppId in $SelectedApps) {

        if ($AppLabels.ContainsKey($AppId)) {

            Write-Host "  [✓] $($AppLabels[$AppId])" `
                -ForegroundColor Green
        }
        else {

            Write-Host "  [✓] $AppId" `
                -ForegroundColor Green
        }
    }

    Write-Host ""

    Write-Host "Aktivasi    : Tidak dilakukan oleh installer"

    Write-Host ""

    Write-Host "Catatan:" -ForegroundColor Yellow
    Write-Host "Installer ini tidak memasukkan Product Key."
    Write-Host "Lisensi/aktivasi harus dilakukan secara sah oleh pemilik lisensi."
    Write-Host ""

    $Konfirmasi = Read-Host `
        "Lanjutkan proses instalasi? (Y/N)"

    if ($Konfirmasi -notmatch "^[Yy]$") {

        Write-Host ""

        Write-Info `
            "Instalasi dibatalkan oleh pengguna."

        exit 0
    }
}

# ============================================================
# DOWNLOAD OFFICE
# ============================================================

function Download-Office {

    param(
        [string]$SetupFile
    )

    Write-Host ""
    Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "TAHAP 3 - DOWNLOAD FILE OFFICE" -ForegroundColor White
    Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host ""

    Write-Info `
        "Office akan diunduh dari CDN Microsoft."

    Write-Info `
        "Ukuran download dapat mencapai beberapa GB."

    Write-Host ""

    Write-Info "Proses download dimulai..."

    Write-Host ""

    $Process = Start-Process `
        -FilePath $SetupFile `
        -ArgumentList "/download", "`"$ConfigurationFile`"" `
        -Wait `
        -PassThru

    if ($Process.ExitCode -ne 0) {

        Write-Gagal "Download Office gagal."

        Write-Host `
            "Exit Code: $($Process.ExitCode)" `
            -ForegroundColor Red

        exit 1
    }

    Write-Sukses `
        "File Office berhasil diunduh."
}

# ============================================================
# INSTALL OFFICE
# ============================================================

function Install-Office {

    param(
        [string]$SetupFile
    )

    Write-Host ""
    Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host "TAHAP 4 - INSTALASI OFFICE" -ForegroundColor White
    Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host ""

    Write-Info "Memulai instalasi Office..."

    Write-Host ""

    Write-Host `
        "Jangan matikan komputer selama proses instalasi." `
        -ForegroundColor Yellow

    Write-Host ""

    $Process = Start-Process `
        -FilePath $SetupFile `
        -ArgumentList "/configure", "`"$ConfigurationFile`"" `
        -Wait `
        -PassThru

    if ($Process.ExitCode -ne 0) {

        Write-Gagal `
            "Instalasi Office gagal."

        Write-Host ""

        Write-Host `
            "Exit Code: $($Process.ExitCode)" `
            -ForegroundColor Red

        Write-Host ""

        Write-Host `
            "Periksa log Office di folder TEMP Windows." `
            -ForegroundColor Yellow

        exit 1
    }

    Write-Sukses `
        "Instalasi Office selesai."
}

# ============================================================
# SELESAI
# ============================================================

function Show-Finish {

    param(
        [array]$SelectedApps
    )

    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Green
    Write-Host "                 INSTALASI SELESAI" -ForegroundColor White
    Write-Host "============================================================" -ForegroundColor Green
    Write-Host ""

    Write-Host `
        "Microsoft Office berhasil dipasang." `
        -ForegroundColor Green

    Write-Host ""

    Write-Host "Aplikasi yang dipilih:" -ForegroundColor Yellow

    $AppLabels = @{
        "Word"       = "Microsoft Word"
        "Excel"      = "Microsoft Excel"
        "PowerPoint" = "Microsoft PowerPoint"
        "Outlook"    = "Microsoft Outlook"
        "Access"     = "Microsoft Access"
        "OneNote"    = "Microsoft OneNote"
        "Publisher"  = "Microsoft Publisher"
    }

    foreach ($AppId in $SelectedApps) {

        if ($AppLabels.ContainsKey($AppId)) {

            Write-Host `
                "  [✓] $($AppLabels[$AppId])" `
                -ForegroundColor Green
        }
    }

    Write-Host ""

    Write-Host "Penting:" -ForegroundColor Yellow
    Write-Host "Installer ini TIDAK melakukan aktivasi Office."
    Write-Host "Pastikan kamu memiliki lisensi yang sesuai untuk Office LTSC."
    Write-Host ""

    Write-Host "Folder kerja installer:" -ForegroundColor Gray
    Write-Host `
        $WorkDirectory `
        -ForegroundColor DarkGray

    Write-Host ""

    Write-Host `
        "Terima kasih telah menggunakan Office Installer." `
        -ForegroundColor Cyan

    Write-Host ""

    Pause-Script
}

# ============================================================
# PROGRAM UTAMA
# ============================================================

try {

    # --------------------------------------------------------
    # Administrator
    # --------------------------------------------------------

    Request-Administrator

    Write-Judul

    Write-Host `
        "Installer resmi berbasis Office Deployment Tool." `
        -ForegroundColor Gray

    Write-Host `
        "Dibuat untuk mempermudah instalasi Office LTSC di Windows." `
        -ForegroundColor Gray

    Write-Host ""

    # --------------------------------------------------------
    # Pemeriksaan sistem
    # --------------------------------------------------------

    Test-Windows

    Test-Internet

    Initialize-WorkDirectory

    # --------------------------------------------------------
    # PILIHAN USER
    # --------------------------------------------------------

    # 1. Versi
    $OfficeVersion = Select-OfficeVersion

    # 2. Edisi
    $OfficeEdition = Select-OfficeEdition

    # 3. Aplikasi
    $SelectedApps = Select-OfficeApps `
        -Version $OfficeVersion

    # 4. Arsitektur
    $Architecture = Select-Architecture

    # 5. Bahasa
    $Language = Select-Language

    # --------------------------------------------------------
    # PRODUCT ID
    # --------------------------------------------------------

    $ProductId = Get-ProductId `
        -Version $OfficeVersion `
        -Edition $OfficeEdition

    # --------------------------------------------------------
    # KONFIGURASI
    # --------------------------------------------------------

    New-Configuration `
        -Version $OfficeVersion `
        -Edition $OfficeEdition `
        -Architecture $Architecture `
        -Language $Language `
        -SelectedApps $SelectedApps |
        Out-Null

    # --------------------------------------------------------
    # KONFIRMASI
    # --------------------------------------------------------

    Show-Configuration `
        -Version $OfficeVersion `
        -Edition $OfficeEdition `
        -Architecture $Architecture `
        -Language $Language `
        -ProductId $ProductId `
        -SelectedApps $SelectedApps

    # --------------------------------------------------------
    # DOWNLOAD ODT
    # --------------------------------------------------------

    $ODTInstaller = Get-ODT

    # --------------------------------------------------------
    # EKSTRAK ODT
    # --------------------------------------------------------

    $SetupFile = Expand-ODT `
        -Installer $ODTInstaller

    # --------------------------------------------------------
    # DOWNLOAD OFFICE
    # --------------------------------------------------------

    Download-Office `
        -SetupFile $SetupFile

    # --------------------------------------------------------
    # INSTALL
    # --------------------------------------------------------

    Install-Office `
        -SetupFile $SetupFile

    # --------------------------------------------------------
    # SELESAI
    # --------------------------------------------------------

    Show-Finish `
        -SelectedApps $SelectedApps
}
catch {

    Write-Host ""

    Write-Host "============================================================" -ForegroundColor Red
    Write-Host "                 TERJADI KESALAHAN" -ForegroundColor White
    Write-Host "============================================================" -ForegroundColor Red
    Write-Host ""

    Write-Host `
        $_.Exception.Message `
        -ForegroundColor Red

    Write-Host ""

    Write-Host `
        "Jika masalah tetap terjadi, baca:" `
        -ForegroundColor Yellow

    Write-Host `
        "docs\TROUBLESHOOTING.md" `
        -ForegroundColor Cyan

    Write-Host ""

    Pause-Script

    exit 1
}