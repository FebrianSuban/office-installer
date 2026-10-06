#Requires -Version 5.1

<#
.SYNOPSIS
    RGOAD Office Installer
    Microsoft Office LTSC 2024 / LTSC 2021 Deployment Tool

.DESCRIPTION
    RGOAD Office Installer adalah installer PowerShell untuk
    melakukan deployment Microsoft Office LTSC menggunakan
    Office Deployment Tool (ODT) resmi Microsoft.

    Didukung:
        - Office LTSC 2024
        - Office LTSC 2021
        - Professional Plus
        - Standard
        - 64-bit
        - 32-bit
        - Bahasa Indonesia
        - English

    Tidak melakukan:
        - Product Key injection
        - Activation
        - KMS
        - Crack
        - Patch
        - Loader
        - License bypass

.NOTES
    Project : RGOAD Office Installer
    Version : 1.1.0
    Theme   : RGOAD
#>

$ErrorActionPreference = "Stop"

# ============================================================
# IDENTITAS RGOAD
# ============================================================

$RGOADName = "RGOAD"
$RGOADVersion = "1.1.0"
$RGOADTagline = "OFFICE DEPLOYMENT SYSTEM"

# ============================================================
# REPOSITORY
# ============================================================

$RepositoryScriptUrl = "https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1"

$MicrosoftODTPage = "https://www.microsoft.com/download/details.aspx?id=49117"

# ============================================================
# WORKSPACE
# ============================================================

$WorkDirectory = Join-Path $env:TEMP "Office-Installer"

$ODTDirectory = Join-Path `
    $WorkDirectory `
    "ODT"

$ConfigurationFile = Join-Path `
    $WorkDirectory `
    "configuration.xml"

$ElevatedScript = Join-Path `
    $env:TEMP `
    "Office-Installer-Elevated.ps1"

# ============================================================
# TEMA RGOAD
# ============================================================

$RGOADPrimary = "Cyan"
$RGOADSecondary = "DarkCyan"
$RGOADAccent = "Blue"
$RGOADSuccess = "Green"
$RGOADWarning = "Yellow"
$RGOADError = "Red"
$RGOADMuted = "DarkGray"
$RGOADText = "White"

# ============================================================
# KARAKTER UI
# ============================================================

$RGOADLine = "------------------------------------------------------------"
$RGOADDoubleLine = "============================================================"

# ============================================================
# INISIALISASI CONSOLE
# ============================================================

function Initialize-RGOADConsole {

    try {
        $Host.UI.RawUI.WindowTitle = `
            "RGOAD | Office Installer | LTSC 2024 / LTSC 2021"
    }
    catch {
        # Abaikan jika judul console tidak dapat diubah.
    }

    try {
        [Console]::OutputEncoding = `
            New-Object System.Text.UTF8Encoding($false)
    }
    catch {
        # Abaikan jika encoding tidak dapat diubah.
    }
}

# ============================================================
# LOGO RGOAD
# ============================================================

function Show-RGOADLogo {

    Clear-Host

    Write-Host ""

    Write-Host "  ██████╗   ██████╗   ██████╗   █████╗  ██████╗ " `
        -ForegroundColor Cyan

    Write-Host "  ██╔══██╗ ██╔════╝  ██╔════╝  ██╔══██╗ ██╔══██╗" `
        -ForegroundColor Cyan

    Write-Host "  ██████╔╝ ██║  ███╗ ██║  ███╗ ███████║ ██║  ██║" `
        -ForegroundColor Cyan

    Write-Host "  ██╔══██╗ ██║   ██║ ██║   ██║ ██╔══██║ ██║  ██║" `
        -ForegroundColor Cyan

    Write-Host "  ██║  ██║ ╚██████╔╝ ╚██████╔╝ ██║  ██║ ██████╔╝" `
        -ForegroundColor Cyan

    Write-Host "  ╚═╝  ╚═╝  ╚═════╝   ╚═════╝  ╚═╝  ╚═╝ ╚═════╝ " `
        -ForegroundColor Cyan

    Write-Host ""

    Write-Host "                  RGOAD" `
        -ForegroundColor White

    Write-Host "          $RGOADTagline" `
        -ForegroundColor DarkCyan

    Write-Host ""

    Write-Host "  $RGOADLine" `
        -ForegroundColor DarkCyan

    Write-Host ""
}

# ============================================================
# HEADER
# ============================================================

function Show-RGOADHeader {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Title,

        [string]$Subtitle = ""
    )

    Write-Host ""

    Write-Host "  +----------------------------------------------------------+" `
        -ForegroundColor DarkCyan

    Write-Host "  |  RGOAD / OFFICE INSTALLER                                |" `
        -ForegroundColor Cyan

    Write-Host "  +----------------------------------------------------------+" `
        -ForegroundColor DarkCyan

    $DisplayTitle = $Title

    if ($DisplayTitle.Length -gt 56) {
        $DisplayTitle = $DisplayTitle.Substring(0, 56)
    }

    Write-Host "  |  $($DisplayTitle.PadRight(56))|" `
        -ForegroundColor White

    if (-not [string]::IsNullOrWhiteSpace($Subtitle)) {

        $DisplaySubtitle = $Subtitle

        if ($DisplaySubtitle.Length -gt 56) {
            $DisplaySubtitle = $DisplaySubtitle.Substring(0, 56)
        }

        Write-Host "  |  $($DisplaySubtitle.PadRight(56))|" `
            -ForegroundColor DarkGray
    }

    Write-Host "  +----------------------------------------------------------+" `
        -ForegroundColor DarkCyan

    Write-Host ""
}

# ============================================================
# STATUS
# ============================================================

function Write-Sukses {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Pesan
    )

    Write-Host "  [OK] " `
        -NoNewline `
        -ForegroundColor Green

    Write-Host $Pesan `
        -ForegroundColor Gray
}

function Write-Info {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Pesan
    )

    Write-Host "  [..] " `
        -NoNewline `
        -ForegroundColor Cyan

    Write-Host $Pesan `
        -ForegroundColor Gray
}

function Write-Peringatan {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Pesan
    )

    Write-Host "  [!!] " `
        -NoNewline `
        -ForegroundColor Yellow

    Write-Host $Pesan `
        -ForegroundColor Yellow
}

function Write-Gagal {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Pesan
    )

    Write-Host "  [XX] " `
        -NoNewline `
        -ForegroundColor Red

    Write-Host $Pesan `
        -ForegroundColor Red
}

# ============================================================
# SECTION
# ============================================================

function Show-Section {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Title,

        [string]$Description = ""
    )

    Write-Host ""

    Write-Host "  $RGOADLine" `
        -ForegroundColor DarkGray

    Write-Host ""

    Write-Host "  $Title" `
        -ForegroundColor Cyan

    if (-not [string]::IsNullOrWhiteSpace($Description)) {

        Write-Host "  $Description" `
            -ForegroundColor DarkGray
    }

    Write-Host ""
}

# ============================================================
# STEP
# ============================================================

function Show-Step {

    param(
        [Parameter(Mandatory = $true)]
        [int]$Number,

        [Parameter(Mandatory = $true)]
        [int]$Total,

        [Parameter(Mandatory = $true)]
        [string]$Title,

        [string]$Description = ""
    )

    Write-Host ""

    Write-Host "  $RGOADLine" `
        -ForegroundColor DarkGray

    Write-Host ""

    Write-Host "  LANGKAH $Number/$Total  " `
        -NoNewline `
        -ForegroundColor Cyan

    Write-Host $Title `
        -ForegroundColor White

    if (-not [string]::IsNullOrWhiteSpace($Description)) {

        Write-Host "  $Description" `
            -ForegroundColor DarkGray
    }

    Write-Host ""
}

# ============================================================
# PAUSE
# ============================================================

function Pause-RGOAD {

    Write-Host ""

    Read-Host `
        "  Tekan ENTER untuk keluar"
}

# ============================================================
# CEK ADMINISTRATOR
# ============================================================

function Test-Administrator {

    $CurrentIdentity = `
        [Security.Principal.WindowsIdentity]::GetCurrent()

    $Principal = New-Object `
        Security.Principal.WindowsPrincipal(
            $CurrentIdentity
        )

    return $Principal.IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator
    )
}

# ============================================================
# ELEVASI ADMINISTRATOR
# ============================================================

function Request-Administrator {

    if (Test-Administrator) {
        return
    }

    Write-Host ""

    Write-Host "  $RGOADDoubleLine" `
        -ForegroundColor Yellow

    Write-Host ""

    Write-Host "  RGOAD membutuhkan hak Administrator." `
        -ForegroundColor Yellow

    Write-Host ""

    Write-Host "  Windows akan menampilkan permintaan UAC." `
        -ForegroundColor DarkGray

    Write-Host ""

    try {

        # ----------------------------------------------------
        # JIKA DIJALANKAN DARI FILE PS1
        # ----------------------------------------------------

        if (
            -not [string]::IsNullOrWhiteSpace(
                $PSCommandPath
            )
        ) {

            Write-Info `
                "Membuka RGOAD sebagai Administrator..."

            $ArgumentList = @(
                "-NoProfile"
                "-ExecutionPolicy"
                "Bypass"
                "-File"
                "`"$PSCommandPath`""
                "-RGOADElevated"
            )

            Start-Process `
                -FilePath "powershell.exe" `
                -Verb RunAs `
                -ArgumentList $ArgumentList

            exit 0
        }

        # ----------------------------------------------------
        # JIKA DIJALANKAN DENGAN IRM | IEX
        # ----------------------------------------------------

        if (
            [string]::IsNullOrWhiteSpace(
                $RepositoryScriptUrl
            )
        ) {

            throw `
                "URL repository RGOAD belum dikonfigurasi."
        }

        Write-Info `
            "Mengambil salinan installer dari GitHub..."

        Invoke-WebRequest `
            -Uri $RepositoryScriptUrl `
            -OutFile $ElevatedScript `
            -UseBasicParsing

        if (-not (Test-Path $ElevatedScript)) {

            throw `
                "Salinan installer gagal dibuat."
        }

        $DownloadedSize = `
            (Get-Item $ElevatedScript).Length

        if ($DownloadedSize -lt 10000) {

            throw `
                "File installer yang diunduh terlalu kecil atau tidak valid."
        }

        Write-Sukses `
            "Salinan installer berhasil disiapkan."

        Write-Info `
            "Meminta hak Administrator..."

        $ArgumentList = @(
            "-NoProfile"
            "-ExecutionPolicy"
            "Bypass"
            "-File"
            "`"$ElevatedScript`""
            "-RGOADElevated"
        )

        Start-Process `
            -FilePath "powershell.exe" `
            -Verb RunAs `
            -ArgumentList $ArgumentList

        exit 0
    }
    catch {

        Write-Gagal `
            "Gagal mendapatkan hak Administrator."

        Write-Host ""

        Write-Host `
            $_.Exception.Message `
            -ForegroundColor Red

        Write-Host ""

        Pause-RGOAD

        exit 1
    }
}

# ============================================================
# CEK WINDOWS
# ============================================================

function Test-Windows {

    Show-Step `
        -Number 1 `
        -Total 7 `
        -Title "PEMERIKSAAN SISTEM" `
        -Description "Memeriksa lingkungan Windows."

    try {

        $OS = Get-CimInstance `
            Win32_OperatingSystem

        if (
            $OS.Caption `
                -notmatch "Windows 10|Windows 11|Windows Server"
        ) {

            Write-Gagal `
                "Sistem operasi tidak didukung."

            Write-Host ""

            Write-Host `
                "  Sistem terdeteksi: $($OS.Caption)" `
                -ForegroundColor Yellow

            exit 1
        }

        Write-Sukses `
            "Windows: $($OS.Caption)"

        Write-Sukses `
            "Hak Administrator: tersedia."
    }
    catch {

        Write-Gagal `
            "Tidak dapat membaca informasi Windows."

        throw
    }
}

# ============================================================
# CEK INTERNET
# ============================================================

function Test-Internet {

    Show-Step `
        -Number 2 `
        -Total 7 `
        -Title "PEMERIKSAAN JARINGAN" `
        -Description "Memeriksa koneksi ke server Microsoft."

    Write-Info `
        "Memeriksa konektivitas Microsoft..."

    try {

        $Response = Invoke-WebRequest `
            -Uri "https://www.microsoft.com" `
            -Method Head `
            -UseBasicParsing `
            -TimeoutSec 15

        if (
            $Response.StatusCode -ge 200 -and
            $Response.StatusCode -lt 500
        ) {

            Write-Sukses `
                "Koneksi internet tersedia."
        }
        else {

            throw `
                "Server Microsoft tidak dapat diakses."
        }
    }
    catch {

        Write-Gagal `
            "Tidak dapat mengakses server Microsoft."

        Write-Host ""

        Write-Host `
            "  Pastikan:" `
            -ForegroundColor Yellow

        Write-Host `
            "  - Internet aktif."

        Write-Host `
            "  - Tidak berada di captive portal."

        Write-Host `
            "  - Firewall tidak memblokir PowerShell."

        Write-Host ""

        exit 1
    }
}

# ============================================================
# SIAPKAN WORKSPACE
# ============================================================

function Initialize-WorkDirectory {

    Show-Step `
        -Number 3 `
        -Total 7 `
        -Title "WORKSPACE" `
        -Description "Menyiapkan folder kerja sementara."

    Write-Info `
        "Menyiapkan workspace RGOAD..."

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
                "Sebagian file workspace lama tidak dapat dihapus."
        }
    }

    New-Item `
        -ItemType Directory `
        -Path $WorkDirectory `
        -Force |
        Out-Null

    New-Item `
        -ItemType Directory `
        -Path $ODTDirectory `
        -Force |
        Out-Null

    Write-Sukses `
        "Workspace RGOAD siap digunakan."
}

# ============================================================
# MENU UMUM
# ============================================================

function Show-Menu {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Title,

        [Parameter(Mandatory = $true)]
        [array]$Options,

        [string]$Description = ""
    )

    Clear-Host

    Show-RGOADLogo

    Show-RGOADHeader `
        -Title $Title `
        -Subtitle $Description

    foreach ($Option in $Options) {

        $Index = `
            [array]::IndexOf(
                $Options,
                $Option
            ) + 1

        Write-Host `
            "  [$Index] " `
            -NoNewline `
            -ForegroundColor Cyan

        Write-Host `
            $Option.Label `
            -ForegroundColor White

        if (
            $Option.PSObject.Properties.Name `
                -contains "Description"
        ) {

            if (
                -not [string]::IsNullOrWhiteSpace(
                    $Option.Description
                )
            ) {

                Write-Host `
                    "       $($Option.Description)" `
                    -ForegroundColor DarkGray
            }
        }

        Write-Host ""
    }

    Write-Host `
        "  $RGOADLine" `
        -ForegroundColor DarkGray

    Write-Host ""

    while ($true) {

        $InputUser = Read-Host "  › Pilih"

        $Number = 0

        if (
            [int]::TryParse(
                $InputUser,
                [ref]$Number
            )
        ) {

            if (
                $Number -ge 1 -and
                $Number -le $Options.Count
            ) {

                return `
                    $Options[$Number - 1].Value
            }
        }

        Write-Peringatan `
            "Pilihan tidak valid."

        Start-Sleep `
            -Milliseconds 700
    }
}

# ============================================================
# PILIH VERSI OFFICE
# ============================================================

function Select-OfficeVersion {

    $Options = @(

        [PSCustomObject]@{
            Label = "Office LTSC 2024"
            Description = "Long-Term Servicing Channel terbaru"
            Value = "2024"
        }

        [PSCustomObject]@{
            Label = "Office LTSC 2021"
            Description = "Long-Term Servicing Channel"
            Value = "2021"
        }
    )

    return Show-Menu `
        -Title "PILIH VERSI OFFICE" `
        -Description "Pilih versi Microsoft Office LTSC." `
        -Options $Options
}

# ============================================================
# PILIH EDISI OFFICE
# ============================================================

function Select-OfficeEdition {

    $Options = @(

        [PSCustomObject]@{
            Label = "Professional Plus"
            Description = "Edisi volume dengan aplikasi lebih lengkap"
            Value = "ProPlus"
        }

        [PSCustomObject]@{
            Label = "Standard"
            Description = "Edisi volume standar"
            Value = "Standard"
        }
    )

    return Show-Menu `
        -Title "PILIH EDISI OFFICE" `
        -Description "Pilih edisi Microsoft Office." `
        -Options $Options
}

# ============================================================
# PILIH APLIKASI
# ============================================================

function Select-OfficeApps {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Version,

        [Parameter(Mandatory = $true)]
        [string]$Edition
    )

    $OfficeApps = @()

    $OfficeApps += [PSCustomObject]@{
        Id = "Word"
        Label = "Microsoft Word"
        Description = "Dokumen dan penulisan"
    }

    $OfficeApps += [PSCustomObject]@{
        Id = "Excel"
        Label = "Microsoft Excel"
        Description = "Spreadsheet dan pengolahan data"
    }

    $OfficeApps += [PSCustomObject]@{
        Id = "PowerPoint"
        Label = "Microsoft PowerPoint"
        Description = "Presentasi"
    }

    $OfficeApps += [PSCustomObject]@{
        Id = "Outlook"
        Label = "Microsoft Outlook"
        Description = "Email, kalender dan kontak"
    }

    $OfficeApps += [PSCustomObject]@{
        Id = "OneNote"
        Label = "Microsoft OneNote"
        Description = "Catatan digital"
    }

    if ($Edition -eq "ProPlus") {

        $OfficeApps += [PSCustomObject]@{
            Id = "Access"
            Label = "Microsoft Access"
            Description = "Manajemen database"
        }
    }

    if ($Version -eq "2021") {

        $OfficeApps += [PSCustomObject]@{
            Id = "Publisher"
            Label = "Microsoft Publisher"
            Description = "Penerbitan dan tata letak"
        }
    }

    $SelectedApps = @()

    $SelectAllNumber = `
        $OfficeApps.Count + 1

    $ClearAllNumber = `
        $OfficeApps.Count + 2

    while ($true) {

        Clear-Host

        Show-RGOADLogo

        Show-RGOADHeader `
            -Title "PILIH APLIKASI" `
            -Subtitle "Office LTSC $Version / $Edition"

        Write-Host `
            "  Pilih aplikasi yang ingin dipasang." `
            -ForegroundColor Gray

        Write-Host `
            "  Masukkan nomor untuk memilih atau membatalkan pilihan." `
            -ForegroundColor DarkGray

        Write-Host ""

        for (
            $i = 0;
            $i -lt $OfficeApps.Count;
            $i++
        ) {

            $App = $OfficeApps[$i]

            $Selected = `
                $SelectedApps -contains $App.Id

            if ($Selected) {

                $Symbol = "[X]"
                $Color = "Green"
            }
            else {

                $Symbol = "[ ]"
                $Color = "DarkGray"
            }

            Write-Host `
                "  [$($i + 1)] " `
                -NoNewline `
                -ForegroundColor Cyan

            Write-Host `
                "$Symbol " `
                -NoNewline `
                -ForegroundColor $Color

            Write-Host `
                $App.Label `
                -ForegroundColor White

            Write-Host `
                "       $($App.Description)" `
                -ForegroundColor DarkGray

            Write-Host ""
        }

        Write-Host `
            "  $RGOADLine" `
            -ForegroundColor DarkGray

        Write-Host ""

        Write-Host `
            "  [$SelectAllNumber] " `
            -NoNewline `
            -ForegroundColor Cyan

        Write-Host `
            "Pilih Semua" `
            -ForegroundColor White

        Write-Host `
            "  [$ClearAllNumber] " `
            -NoNewline `
            -ForegroundColor Cyan

        Write-Host `
            "Hapus Semua Pilihan" `
            -ForegroundColor Yellow

        Write-Host `
            "  [0] " `
            -NoNewline `
            -ForegroundColor Cyan

        Write-Host `
            "Lanjutkan" `
            -ForegroundColor White

        Write-Host ""

        Write-Host `
            "  Dipilih: " `
            -NoNewline `
            -ForegroundColor DarkGray

        Write-Host `
            "$($SelectedApps.Count) aplikasi" `
            -ForegroundColor Green

        Write-Host ""

        $InputUser = Read-Host "  › Pilih"

        # ----------------------------------------------------
        # LANJUTKAN
        # ----------------------------------------------------

        if ($InputUser -eq "0") {

            if ($SelectedApps.Count -eq 0) {

                Write-Peringatan `
                    "Pilih minimal satu aplikasi."

                Start-Sleep `
                    -Milliseconds 900

                continue
            }

            return @($SelectedApps)
        }

        # ----------------------------------------------------
        # PILIH SEMUA
        # ----------------------------------------------------

        if (
            $InputUser -eq
            "$SelectAllNumber"
        ) {

            $SelectedApps = @(
                $OfficeApps |
                    ForEach-Object {
                        $_.Id
                    }
            )

            continue
        }

        # ----------------------------------------------------
        # HAPUS SEMUA
        # ----------------------------------------------------

        if (
            $InputUser -eq
            "$ClearAllNumber"
        ) {

            $SelectedApps = @()

            continue
        }

        # ----------------------------------------------------
        # TOGGLE
        # ----------------------------------------------------

        $Number = 0

        if (
            [int]::TryParse(
                $InputUser,
                [ref]$Number
            )
        ) {

            if (
                $Number -ge 1 -and
                $Number -le $OfficeApps.Count
            ) {

                $SelectedId = `
                    $OfficeApps[$Number - 1].Id

                if (
                    $SelectedApps -contains
                    $SelectedId
                ) {

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

        Start-Sleep `
            -Milliseconds 700
    }
}

# ============================================================
# PILIH ARSITEKTUR
# ============================================================

function Select-Architecture {

    $Options = @(

        [PSCustomObject]@{
            Label = "64-bit"
            Description = "Direkomendasikan untuk Windows modern"
            Value = "64"
        }

        [PSCustomObject]@{
            Label = "32-bit"
            Description = "Untuk kebutuhan kompatibilitas tertentu"
            Value = "32"
        }
    )

    return Show-Menu `
        -Title "PILIH ARSITEKTUR" `
        -Description "Pilih arsitektur Microsoft Office." `
        -Options $Options
}

# ============================================================
# PILIH BAHASA
# ============================================================

function Select-Language {

    $Options = @(

        [PSCustomObject]@{
            Label = "Bahasa Indonesia"
            Description = "Antarmuka Office dalam Bahasa Indonesia"
            Value = "id-id"
        }

        [PSCustomObject]@{
            Label = "English"
            Description = "Antarmuka Office dalam Bahasa Inggris"
            Value = "en-us"
        }
    )

    return Show-Menu `
        -Title "PILIH BAHASA" `
        -Description "Pilih bahasa antarmuka Microsoft Office." `
        -Options $Options
}

# ============================================================
# PRODUCT ID
# ============================================================

function Get-ProductId {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Version,

        [Parameter(Mandatory = $true)]
        [string]$Edition
    )

    switch ($Version) {

        "2024" {

            switch ($Edition) {

                "ProPlus" {
                    return "ProPlus2024Volume"
                }

                "Standard" {
                    return "Standard2024Volume"
                }

                default {
                    throw `
                        "Edisi Office 2024 tidak valid."
                }
            }
        }

        "2021" {

            switch ($Edition) {

                "ProPlus" {
                    return "ProPlus2021Volume"
                }

                "Standard" {
                    return "Standard2021Volume"
                }

                default {
                    throw `
                        "Edisi Office 2021 tidak valid."
                }
            }
        }

        default {

            throw `
                "Versi Office tidak valid."
        }
    }
}

# ============================================================
# CHANNEL
# ============================================================

function Get-Channel {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Version
    )

    switch ($Version) {

        "2024" {
            return "PerpetualVL2024"
        }

        "2021" {
            return "PerpetualVL2021"
        }

        default {
            throw `
                "Versi Office tidak valid."
        }
    }
}

# ============================================================
# EXCLUDE APP XML
# ============================================================

function Get-ExcludeAppXml {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Version,

        [Parameter(Mandatory = $true)]
        [string]$Edition,

        [Parameter(Mandatory = $true)]
        [array]$SelectedApps
    )

    $AllApps = @(
        "Word"
        "Excel"
        "PowerPoint"
        "Outlook"
        "OneNote"
    )

    if ($Edition -eq "ProPlus") {
        $AllApps += "Access"
    }

    if ($Version -eq "2021") {
        $AllApps += "Publisher"
    }

    $ExcludeLines = @()

    foreach ($App in $AllApps) {

        if (
            $SelectedApps -notcontains $App
        ) {

            $ExcludeLines += `
                "      <ExcludeApp ID=`"$App`" />"
        }
    }

    if ($ExcludeLines.Count -eq 0) {
        return ""
    }

    return (
        $ExcludeLines -join "`r`n"
    )
}

# ============================================================
# BUAT CONFIGURATION.XML
# ============================================================

function New-Configuration {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Version,

        [Parameter(Mandatory = $true)]
        [string]$Edition,

        [Parameter(Mandatory = $true)]
        [string]$Architecture,

        [Parameter(Mandatory = $true)]
        [string]$Language,

        [Parameter(Mandatory = $true)]
        [array]$SelectedApps
    )

    $ProductId = Get-ProductId `
        -Version $Version `
        -Edition $Edition

    $Channel = Get-Channel `
        -Version $Version

    Show-Step `
        -Number 4 `
        -Total 7 `
        -Title "KONFIGURASI" `
        -Description "Membuat configuration.xml."

    $ExcludeXml = Get-ExcludeAppXml `
        -Version $Version `
        -Edition $Edition `
        -SelectedApps $SelectedApps

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

    if (-not (Test-Path $ConfigurationFile)) {

        throw `
            "configuration.xml gagal dibuat."
    }

    Write-Sukses `
        "configuration.xml berhasil dibuat."

    Write-Host ""

    Write-Host `
        "  Product ID : $ProductId" `
        -ForegroundColor Gray

    Write-Host `
        "  Channel    : $Channel" `
        -ForegroundColor Gray

    Write-Host `
        "  Arsitektur : $Architecture-bit" `
        -ForegroundColor Gray

    Write-Host `
        "  Bahasa     : $Language" `
        -ForegroundColor Gray

    return $ProductId
}

# ============================================================
# RINGKASAN KONFIGURASI
# ============================================================

function Show-Configuration {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Version,

        [Parameter(Mandatory = $true)]
        [string]$Edition,

        [Parameter(Mandatory = $true)]
        [string]$Architecture,

        [Parameter(Mandatory = $true)]
        [string]$Language,

        [Parameter(Mandatory = $true)]
        [string]$ProductId,

        [Parameter(Mandatory = $true)]
        [array]$SelectedApps
    )

    Clear-Host

    Show-RGOADLogo

    Show-RGOADHeader `
        -Title "RINGKASAN INSTALASI" `
        -Subtitle "Periksa konfigurasi sebelum proses deployment."

    $Channel = Get-Channel `
        -Version $Version

    Write-Host `
        "  VERSI" `
        -ForegroundColor DarkGray

    Write-Host `
        "  Office LTSC $Version" `
        -ForegroundColor White

    Write-Host ""

    Write-Host `
        "  EDISI" `
        -ForegroundColor DarkGray

    Write-Host `
        "  $Edition" `
        -ForegroundColor White

    Write-Host ""

    Write-Host `
        "  PRODUCT ID" `
        -ForegroundColor DarkGray

    Write-Host `
        "  $ProductId" `
        -ForegroundColor Cyan

    Write-Host ""

    Write-Host `
        "  CHANNEL" `
        -ForegroundColor DarkGray

    Write-Host `
        "  $Channel" `
        -ForegroundColor White

    Write-Host ""

    Write-Host `
        "  ARSITEKTUR" `
        -ForegroundColor DarkGray

    Write-Host `
        "  $Architecture-bit" `
        -ForegroundColor White

    Write-Host ""

    Write-Host `
        "  BAHASA" `
        -ForegroundColor DarkGray

    if ($Language -eq "id-id") {

        Write-Host `
            "  Bahasa Indonesia" `
            -ForegroundColor White
    }
    else {

        Write-Host `
            "  English" `
            -ForegroundColor White
    }

    Write-Host ""

    Write-Host `
        "  APLIKASI" `
        -ForegroundColor DarkGray

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

        Write-Host `
            "  +-- [OK] " `
            -NoNewline `
            -ForegroundColor Green

        if ($AppLabels.ContainsKey($AppId)) {

            Write-Host `
                $AppLabels[$AppId] `
                -ForegroundColor White
        }
        else {

            Write-Host `
                $AppId `
                -ForegroundColor White
        }
    }

    Write-Host ""

    Write-Host `
        "  AKTIVASI" `
        -ForegroundColor DarkGray

    Write-Host `
        "  Tidak dilakukan oleh RGOAD." `
        -ForegroundColor Yellow

    Write-Host ""

    Write-Host `
        "  $RGOADLine" `
        -ForegroundColor DarkGray

    Write-Host ""

    Write-Host `
        "  [Y] " `
        -NoNewline `
        -ForegroundColor Green

    Write-Host `
        "Lanjutkan instalasi" `
        -ForegroundColor White

    Write-Host `
        "  [N] " `
        -NoNewline `
        -ForegroundColor Red

    Write-Host `
        "Batalkan" `
        -ForegroundColor White

    Write-Host ""

    while ($true) {

        $Confirmation = Read-Host `
            "  › Lanjutkan"

        if ($Confirmation -match "^[Yy]$") {
            return
        }

        if ($Confirmation -match "^[Nn]$") {

            Write-Host ""

            Write-Info `
                "Instalasi dibatalkan."

            exit 0
        }

        Write-Peringatan `
            "Masukkan Y atau N."
    }
}

# ============================================================
# DOWNLOAD ODT MICROSOFT
# ============================================================

function Get-ODT {

    Show-Step `
        -Number 5 `
        -Total 7 `
        -Title "MICROSOFT ODT" `
        -Description "Mengunduh Office Deployment Tool resmi Microsoft."

    Write-Info `
        "Mencari link Office Deployment Tool resmi Microsoft..."

    Write-Host ""

    Write-Host `
        "  Sumber:" `
        -ForegroundColor DarkGray

    Write-Host `
        "  $MicrosoftODTPage" `
        -ForegroundColor Cyan

    Write-Host ""

    try {

        $Page = Invoke-WebRequest `
            -Uri $MicrosoftODTPage `
            -UseBasicParsing

        $Links = @()

        foreach ($Link in $Page.Links) {

            if ($null -ne $Link.href) {

                $Href = [string]$Link.href

                if (
                    $Href -match "download\.microsoft\.com" -and
                    $Href -match "\.exe"
                ) {

                    $Links += $Href
                }
            }
        }

        $ODTLink = $Links |
            Where-Object {
                $_ -match "officedeploymenttool"
            } |
            Select-Object -First 1

        if (
            [string]::IsNullOrWhiteSpace(
                $ODTLink
            )
        ) {

            throw `
                "Link Office Deployment Tool tidak ditemukan."
        }

        if ($ODTLink.StartsWith("//")) {

            $ODTLink = `
                "https:$ODTLink"
        }

        if ($ODTLink.StartsWith("/")) {

            $ODTLink = `
                "https://www.microsoft.com$ODTLink"
        }

        $UriObject = [System.Uri]$ODTLink

        if (
            $UriObject.Host `
                -notmatch "microsoft\.com$"
        ) {

            throw `
                "Sumber Office Deployment Tool bukan domain Microsoft."
        }

        Write-Sukses `
            "Link resmi Microsoft ditemukan."

        $ODTInstaller = Join-Path `
            $WorkDirectory `
            "officedeploymenttool.exe"

        Write-Info `
            "Mengunduh Office Deployment Tool..."

        Invoke-WebRequest `
            -Uri $ODTLink `
            -OutFile $ODTInstaller `
            -UseBasicParsing

        if (-not (Test-Path $ODTInstaller)) {

            throw `
                "File Office Deployment Tool tidak ditemukan setelah download."
        }

        $FileSize = `
            (Get-Item $ODTInstaller).Length

        if ($FileSize -lt 100000) {

            throw `
                "File Office Deployment Tool terlalu kecil atau tidak valid."
        }

        Write-Sukses `
            "Office Deployment Tool berhasil diunduh."

        return $ODTInstaller
    }
    catch {

        Write-Gagal `
            "Gagal mengunduh Office Deployment Tool."

        Write-Host ""

        Write-Host `
            $_.Exception.Message `
            -ForegroundColor Red

        Write-Host ""

        Write-Peringatan `
            "Office Deployment Tool dapat diunduh manual dari Microsoft:"

        Write-Host ""

        Write-Host `
            $MicrosoftODTPage `
            -ForegroundColor Cyan

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

    Show-Step `
        -Number 6 `
        -Total 7 `
        -Title "MENYIAPKAN ODT" `
        -Description "Mengekstrak Office Deployment Tool."

    try {

        Write-Info `
            "Mengekstrak paket Office Deployment Tool..."

        $Process = Start-Process `
            -FilePath $Installer `
            -ArgumentList `
                "/quiet", `
                "/extract:`"$ODTDirectory`"" `
            -Wait `
            -PassThru `
            -WindowStyle Hidden

        if ($Process.ExitCode -ne 0) {

            throw `
                "ODT gagal diekstrak. Kode keluar: $($Process.ExitCode)"
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

        Write-Sukses `
            "setup.exe ditemukan."

        return $SetupFile
    }
    catch {

        Write-Gagal `
            "Gagal mengekstrak Office Deployment Tool."

        Write-Host ""

        Write-Host `
            $_.Exception.Message `
            -ForegroundColor Red

        exit 1
    }
}

# ============================================================
# DOWNLOAD OFFICE
# ============================================================

function Download-Office {

    param(
        [Parameter(Mandatory = $true)]
        [string]$SetupFile
    )

    Show-Step `
        -Number 7 `
        -Total 7 `
        -Title "MENGUNDUH OFFICE" `
        -Description "Mengunduh Microsoft Office melalui ODT."

    Write-Info `
        "Paket Office akan diunduh dari CDN Microsoft."

    Write-Host ""

    Write-Peringatan `
        "Ukuran download dapat mencapai beberapa GB."

    Write-Host ""

    Write-Info `
        "Menjalankan proses download ODT..."

    Write-Host ""

    $Process = Start-Process `
        -FilePath $SetupFile `
        -ArgumentList `
            "/download", `
            "`"$ConfigurationFile`"" `
        -Wait `
        -PassThru

    if ($Process.ExitCode -ne 0) {

        Write-Gagal `
            "Download Office gagal."

        Write-Host ""

        Write-Host `
            "Kode keluar: $($Process.ExitCode)" `
            -ForegroundColor Red

        exit 1
    }

    Write-Host ""

    Write-Sukses `
        "File Office berhasil diunduh."
}

# ============================================================
# INSTAL OFFICE
# ============================================================

function Install-Office {

    param(
        [Parameter(Mandatory = $true)]
        [string]$SetupFile
    )

    Show-Step `
        -Number 7 `
        -Total 7 `
        -Title "MEMASANG OFFICE" `
        -Description "Memasang Microsoft Office menggunakan ODT."

    Write-Peringatan `
        "Jangan matikan komputer selama proses instalasi."

    Write-Host ""

    Write-Info `
        "Memulai proses pemasangan Office..."

    Write-Host ""

    $Process = Start-Process `
        -FilePath $SetupFile `
        -ArgumentList `
            "/configure", `
            "`"$ConfigurationFile`"" `
        -Wait `
        -PassThru

    if ($Process.ExitCode -ne 0) {

        Write-Gagal `
            "Instalasi Office gagal."

        Write-Host ""

        Write-Host `
            "Kode keluar: $($Process.ExitCode)" `
            -ForegroundColor Red

        Write-Host ""

        Write-Peringatan `
            "Periksa log Office pada folder TEMP Windows."

        exit 1
    }

    Write-Host ""

    Write-Sukses `
        "Instalasi Office selesai."
}

# ============================================================
# SELESAI
# ============================================================

function Show-Finish {

    param(
        [Parameter(Mandatory = $true)]
        [array]$SelectedApps,

        [Parameter(Mandatory = $true)]
        [string]$Version,

        [Parameter(Mandatory = $true)]
        [string]$Edition
    )

    Clear-Host

    Write-Host ""

    Write-Host `
        "  +========================================================+" `
        -ForegroundColor Green

    Write-Host `
        "  |                                                        |" `
        -ForegroundColor Green

    Write-Host `
        "  |                 INSTALASI SELESAI                      |" `
        -ForegroundColor White

    Write-Host `
        "  |                                                        |" `
        -ForegroundColor Green

    Write-Host `
        "  +========================================================+" `
        -ForegroundColor Green

    Write-Host ""

    Write-Host `
        "  RGOAD / OFFICE INSTALLER" `
        -ForegroundColor Cyan

    Write-Host ""

    Write-Sukses `
        "Microsoft Office LTSC $Version berhasil dipasang."

    Write-Host ""

    Write-Host `
        "  Edisi       : " `
        -NoNewline `
        -ForegroundColor DarkGray

    Write-Host `
        $Edition `
        -ForegroundColor White

    Write-Host ""

    Write-Host `
        "  Aplikasi" `
        -ForegroundColor DarkGray

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
                "  +-- [OK] $($AppLabels[$AppId])" `
                -ForegroundColor Green
        }
    }

    Write-Host ""

    Write-Host `
        "  Aktivasi" `
        -ForegroundColor DarkGray

    Write-Host `
        "  Tidak dilakukan oleh RGOAD." `
        -ForegroundColor Yellow

    Write-Host ""

    Write-Host `
        "  Workspace" `
        -ForegroundColor DarkGray

    Write-Host `
        "  $WorkDirectory" `
        -ForegroundColor DarkGray

    Write-Host ""

    Write-Host `
        "  $RGOADDoubleLine" `
        -ForegroundColor DarkCyan

    Write-Host ""

    Write-Host `
        "  Deployment RGOAD berhasil diselesaikan." `
        -ForegroundColor Cyan

    Write-Host ""

    Pause-RGOAD
}

# ============================================================
# MAIN
# ============================================================

try {

    Initialize-RGOADConsole

    # --------------------------------------------------------
    # ADMINISTRATOR
    # --------------------------------------------------------

    Request-Administrator

    # --------------------------------------------------------
    # STARTUP
    # --------------------------------------------------------

    Show-RGOADLogo

    Write-Host `
        "  RGOAD Office Installer" `
        -ForegroundColor White

    Write-Host `
        "  Versi $RGOADVersion" `
        -ForegroundColor DarkGray

    Write-Host ""

    Write-Host `
        "  Utilitas deployment Microsoft Office LTSC." `
        -ForegroundColor Gray

    Write-Host `
        "  Menggunakan Office Deployment Tool resmi Microsoft." `
        -ForegroundColor Gray

    Write-Host ""

    Write-Host `
        "  DIDUKUNG" `
        -ForegroundColor DarkGray

    Write-Host `
        "  [>] Office LTSC 2024" `
        -ForegroundColor Gray

    Write-Host `
        "  [>] Office LTSC 2021" `
        -ForegroundColor Gray

    Write-Host `
        "  [>] Professional Plus / Standard" `
        -ForegroundColor Gray

    Write-Host `
        "  [>] 32-bit / 64-bit" `
        -ForegroundColor Gray

    Write-Host `
        "  [>] Bahasa Indonesia / English" `
        -ForegroundColor Gray

    Write-Host ""

    Write-Host `
        "  $RGOADLine" `
        -ForegroundColor DarkGray

    Write-Host ""

    Write-Info `
        "Memulai mesin deployment RGOAD..."

    Start-Sleep `
        -Milliseconds 500

    # --------------------------------------------------------
    # LANGKAH 1
    # --------------------------------------------------------

    Test-Windows

    # --------------------------------------------------------
    # LANGKAH 2
    # --------------------------------------------------------

    Test-Internet

    # --------------------------------------------------------
    # LANGKAH 3
    # --------------------------------------------------------

    Initialize-WorkDirectory

    # --------------------------------------------------------
    # PILIH VERSI
    # --------------------------------------------------------

    $OfficeVersion = `
        Select-OfficeVersion

    # --------------------------------------------------------
    # PILIH EDISI
    # --------------------------------------------------------

    $OfficeEdition = `
        Select-OfficeEdition

    # --------------------------------------------------------
    # PILIH APLIKASI
    # --------------------------------------------------------

    $SelectedApps = `
        Select-OfficeApps `
            -Version $OfficeVersion `
            -Edition $OfficeEdition

    # --------------------------------------------------------
    # PILIH ARSITEKTUR
    # --------------------------------------------------------

    $Architecture = `
        Select-Architecture

    # --------------------------------------------------------
    # PILIH BAHASA
    # --------------------------------------------------------

    $Language = `
        Select-Language

    # --------------------------------------------------------
    # PRODUCT ID
    # --------------------------------------------------------

    $ProductId = `
        Get-ProductId `
            -Version $OfficeVersion `
            -Edition $OfficeEdition

    # --------------------------------------------------------
    # LANGKAH 4
    # --------------------------------------------------------

    New-Configuration `
        -Version $OfficeVersion `
        -Edition $OfficeEdition `
        -Architecture $Architecture `
        -Language $Language `
        -SelectedApps $SelectedApps |
        Out-Null

    # --------------------------------------------------------
    # RINGKASAN
    # --------------------------------------------------------

    Show-Configuration `
        -Version $OfficeVersion `
        -Edition $OfficeEdition `
        -Architecture $Architecture `
        -Language $Language `
        -ProductId $ProductId `
        -SelectedApps $SelectedApps

    # --------------------------------------------------------
    # LANGKAH 5
    # --------------------------------------------------------

    $ODTInstaller = `
        Get-ODT

    # --------------------------------------------------------
    # LANGKAH 6
    # --------------------------------------------------------

    $SetupFile = `
        Expand-ODT `
            -Installer $ODTInstaller

    # --------------------------------------------------------
    # LANGKAH 7
    # --------------------------------------------------------

    Download-Office `
        -SetupFile $SetupFile

    # --------------------------------------------------------
    # INSTALASI
    # --------------------------------------------------------

    Install-Office `
        -SetupFile $SetupFile

    # --------------------------------------------------------
    # SELESAI
    # --------------------------------------------------------

    Show-Finish `
        -SelectedApps $SelectedApps `
        -Version $OfficeVersion `
        -Edition $OfficeEdition
}
catch {

    Clear-Host

    Write-Host ""

    Write-Host `
        "  +========================================================+" `
        -ForegroundColor Red

    Write-Host `
        "  |                    RGOAD ERROR                         |" `
        -ForegroundColor White

    Write-Host `
        "  +========================================================+" `
        -ForegroundColor Red

    Write-Host ""

    Write-Gagal `
        $_.Exception.Message

    Write-Host ""

    Write-Host `
        "  PEMECAHAN MASALAH" `
        -ForegroundColor Yellow

    Write-Host `
        "  Periksa dokumentasi repository:" `
        -ForegroundColor Gray

    Write-Host `
        "  docs\TROUBLESHOOTING.md" `
        -ForegroundColor Cyan

    Write-Host ""

    Write-Host `
        "  Workspace:" `
        -ForegroundColor DarkGray

    Write-Host `
        "  $WorkDirectory" `
        -ForegroundColor DarkGray

    Write-Host ""

    Pause-RGOAD

    exit 1
}