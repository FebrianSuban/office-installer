powershell
#Requires -Version 5.1

<#
.SYNOPSIS
    RGOAD Office Installer
    Installer Microsoft Office LTSC 2024 / LTSC 2021
    menggunakan Office Deployment Tool (ODT) resmi Microsoft.

.DESCRIPTION
    RGOAD Office Installer adalah installer berbasis PowerShell
    dengan antarmuka terminal bertema RGOAD.

    Fitur:
    - Office LTSC 2024
    - Office LTSC 2021
    - Professional Plus
    - Standard
    - Pemilihan aplikasi sesuai edisi
    - Pemilihan aplikasi individual
    - Select All
    - Clear All
    - Arsitektur 64-bit / 32-bit
    - Bahasa Indonesia / English
    - Download ODT resmi Microsoft
    - Membuat configuration.xml otomatis
    - Download Office melalui ODT
    - Install Office melalui ODT
    - Tidak memasukkan Product Key
    - Tidak melakukan aktivasi
    - Tidak menggunakan KMS
    - Tidak menggunakan crack
    - Tidak menggunakan patch
    - Tidak menggunakan loader
    - Tidak melakukan bypass lisensi

.PRODUCT MATRIX

    Office LTSC 2024 Standard:
        - Word
        - Excel
        - PowerPoint
        - Outlook
        - OneNote

    Office LTSC 2024 Professional Plus:
        - Word
        - Excel
        - PowerPoint
        - Outlook
        - OneNote
        - Access

    Office LTSC 2021 Standard:
        - Word
        - Excel
        - PowerPoint
        - Outlook
        - OneNote
        - Publisher

    Office LTSC 2021 Professional Plus:
        - Word
        - Excel
        - PowerPoint
        - Outlook
        - OneNote
        - Access
        - Publisher

.NOTES
    Theme:
        RGOAD

    Installer ini hanya menangani deployment.

    Lisensi dan aktivasi Office harus dilakukan secara sah
    menggunakan lisensi yang sesuai dengan edisi Office.
#>

$ErrorActionPreference = "Stop"

# ============================================================
# RGOAD CONFIGURATION
# ============================================================

$RGOADName = "RGOAD"
$RGOADVersion = "1.0.0"
$RGOADTagline = "OFFICE DEPLOYMENT SYSTEM"

# ============================================================
# KONFIGURASI REPOSITORY
# ============================================================

$RepositoryScriptUrl = "https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1"

$MicrosoftODTPage = "https://www.microsoft.com/download/details.aspx?id=49117"

$WorkDirectory = Join-Path $env:TEMP "Office-Installer"

$ODTDirectory = Join-Path $WorkDirectory "ODT"

$ConfigurationFile = Join-Path $WorkDirectory "configuration.xml"

# ============================================================
# WARNA TEMA RGOAD
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

$RGOADLine = "────────────────────────────────────────────────────────────"
$RGOADDoubleLine = "════════════════════════════════════════════════════════════"

# ============================================================
# FUNGSI LOGO RGOAD
# ============================================================

function Show-RGOADLogo {

    Clear-Host

    Write-Host ""
    Write-Host "  ██████╗  ██████╗  ██████╗  █████╗ ██████╗ " -ForegroundColor Cyan
    Write-Host "  ██╔══██╗██╔════╝ ██╔════╝ ██╔══██╗██╔══██╗" -ForegroundColor Cyan
    Write-Host "  ██████╔╝██║  ███╗██║  ███╗███████║██║  ██║" -ForegroundColor Cyan
    Write-Host "  ██╔══██╗██║   ██║██║   ██║██╔══██║██║  ██║" -ForegroundColor Cyan
    Write-Host "  ██║  ██║╚██████╔╝╚██████╔╝██║  ██║██████╔╝" -ForegroundColor Cyan
    Write-Host "  ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═════╝ " -ForegroundColor Cyan

    Write-Host ""
    Write-Host "                 $RGOADName" -ForegroundColor White
    Write-Host "              $RGOADTagline" -ForegroundColor DarkCyan
    Write-Host ""
    Write-Host "  $RGOADLine" -ForegroundColor DarkCyan
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
    Write-Host "  ┌────────────────────────────────────────────────────────┐" -ForegroundColor DarkCyan
    Write-Host "  │  RGOAD  /  OFFICE INSTALLER                           │" -ForegroundColor Cyan
    Write-Host "  ├────────────────────────────────────────────────────────┤" -ForegroundColor DarkCyan
    Write-Host "  │  $($Title.PadRight(54).Substring(0,54))│" -ForegroundColor White

    if (-not [string]::IsNullOrWhiteSpace($Subtitle)) {

        Write-Host "  │  $($Subtitle.PadRight(54).Substring(0,54))│" -ForegroundColor DarkGray
    }

    Write-Host "  └────────────────────────────────────────────────────────┘" -ForegroundColor DarkCyan
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

    Write-Host "  [✓] " -NoNewline -ForegroundColor Green
    Write-Host $Pesan -ForegroundColor Gray
}

function Write-Info {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Pesan
    )

    Write-Host "  [•] " -NoNewline -ForegroundColor Cyan
    Write-Host $Pesan -ForegroundColor Gray
}

function Write-Peringatan {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Pesan
    )

    Write-Host "  [!] " -NoNewline -ForegroundColor Yellow
    Write-Host $Pesan -ForegroundColor Yellow
}

function Write-Gagal {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Pesan
    )

    Write-Host "  [×] " -NoNewline -ForegroundColor Red
    Write-Host $Pesan -ForegroundColor Red
}

# ============================================================
# STEP INDICATOR
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
    Write-Host "  $RGOADLine" -ForegroundColor DarkGray

    Write-Host ""
    Write-Host "  STEP $Number/$Total  " -NoNewline -ForegroundColor Cyan
    Write-Host $Title -ForegroundColor White

    if (-not [string]::IsNullOrWhiteSpace($Description)) {

        Write-Host "  $Description" -ForegroundColor DarkGray
    }

    Write-Host ""
}

# ============================================================
# PROGRESS BAR
# ============================================================

function Show-RGOADProgress {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Label,

        [int]$Percent = 0
    )

    if ($Percent -lt 0) {
        $Percent = 0
    }

    if ($Percent -gt 100) {
        $Percent = 100
    }

    $Width = 36

    $Filled = [math]::Floor(
        ($Percent / 100) * $Width
    )

    $Empty = $Width - $Filled

    $Bar = (
        ("█" * $Filled) +
        ("░" * $Empty)
    )

    Write-Host ""
    Write-Host "  $Label" -ForegroundColor Gray
    Write-Host "  [$Bar] $Percent%" -ForegroundColor Cyan
    Write-Host ""
}

# ============================================================
# PAUSE
# ============================================================

function Pause-RGOAD {

    Write-Host ""
    Read-Host "  Tekan ENTER untuk melanjutkan"
}

# ============================================================
# ADMINISTRATOR
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

function Request-Administrator {

    if (Test-Administrator) {

        return
    }

    Show-RGOADLogo

    Write-Peringatan `
        "Hak Administrator diperlukan untuk deployment Office."

    Write-Host ""
    Write-Host "  Windows akan menampilkan jendela UAC." `
        -ForegroundColor Yellow

    Write-Host ""

    try {

        # ----------------------------------------------------
        # FILE PS1
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
        # IRM | IEX
        # ----------------------------------------------------

        if (
            [string]::IsNullOrWhiteSpace(
                $RepositoryScriptUrl
            )
        ) {

            Write-Gagal `
                "URL repository belum dikonfigurasi."

            exit 1
        }

        $ElevatedScript = Join-Path `
            $env:TEMP `
            "Office-Installer-Elevated.ps1"

        Write-Info `
            "Mengunduh salinan installer untuk elevasi..."

        Invoke-WebRequest `
            -Uri $RepositoryScriptUrl `
            -OutFile $ElevatedScript `
            -UseBasicParsing

        if (-not (Test-Path $ElevatedScript)) {

            throw `
                "Script elevated gagal diunduh."
        }

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

        Write-Gagal `
            "Gagal mendapatkan hak Administrator."

        Write-Host ""
        Write-Host $_.Exception.Message `
            -ForegroundColor Red

        Write-Host ""

        exit 1
    }
}

# ============================================================
# WINDOWS CHECK
# ============================================================

function Test-Windows {

    Show-Step `
        -Number 1 `
        -Total 7 `
        -Title "SYSTEM CHECK" `
        -Description "Memeriksa lingkungan Windows."

    try {

        $OS = Get-CimInstance Win32_OperatingSystem

        if (
            $OS.Caption `
                -notmatch "Windows 10|Windows 11|Windows Server"
        ) {

            Write-Gagal `
                "Sistem operasi tidak didukung."

            Write-Host ""
            Write-Host "  Detected: $($OS.Caption)" `
                -ForegroundColor Yellow

            exit 1
        }

        Write-Sukses `
            "Windows terdeteksi: $($OS.Caption)"

        if (Test-Administrator) {

            Write-Sukses `
                "Administrator privilege: tersedia."
        }
    }
    catch {

        Write-Gagal `
            "Tidak dapat membaca informasi Windows."

        throw
    }
}

# ============================================================
# INTERNET CHECK
# ============================================================

function Test-Internet {

    Write-Info `
        "Memeriksa koneksi ke Microsoft..."

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
                "Microsoft tidak dapat diakses."
        }
    }
    catch {

        Write-Gagal `
            "Tidak dapat mengakses Microsoft."

        Write-Host ""
        Write-Host "  Pastikan:" `
            -ForegroundColor Yellow

        Write-Host "  • Internet aktif."
        Write-Host "  • Tidak menggunakan captive portal."
        Write-Host "  • Firewall tidak memblokir PowerShell."
        Write-Host ""

        exit 1
    }
}

# ============================================================
# WORK DIRECTORY
# ============================================================

function Initialize-WorkDirectory {

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
                "Workspace lama tidak dapat dibersihkan sepenuhnya."
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

    Write-Sukses `
        "Workspace siap."
}

# ============================================================
# GENERIC MENU
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

    for (
        $i = 0;
        $i -lt $Options.Count;
        $i++
    ) {

        $Number = $i + 1
        $Label = $Options[$i].Label

        Write-Host `
            "  [$Number] " `
            -NoNewline `
            -ForegroundColor Cyan

        Write-Host `
            $Label `
            -ForegroundColor White
    }

    Write-Host ""
    Write-Host "  $RGOADLine" `
        -ForegroundColor DarkGray

    Write-Host ""

    while ($true) {

        $InputUser = Read-Host "  › Select"

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

                return $Options[$Number - 1].Value
            }
        }

        Write-Peringatan `
            "Pilihan tidak valid."

        Start-Sleep -Milliseconds 700
    }
}

# ============================================================
# OFFICE VERSION
# ============================================================

function Select-OfficeVersion {

    $Options = @(

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
        -Title "SELECT OFFICE VERSION" `
        -Description "Choose the Long-Term Servicing Channel version." `
        -Options $Options
}

# ============================================================
# OFFICE EDITION
# ============================================================

function Select-OfficeEdition {

    $Options = @(

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
        -Title "SELECT OFFICE EDITION" `
        -Description "Choose the Office volume edition." `
        -Options $Options
}

# ============================================================
# APPLICATION MENU
# ============================================================

function Select-OfficeApps {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Version,

        [Parameter(Mandatory = $true)]
        [string]$Edition
    )

    $OfficeApps = @()

    # --------------------------------------------------------
    # BASIC APPS
    # --------------------------------------------------------

    $OfficeApps += [PSCustomObject]@{
        Id = "Word"
        Label = "Microsoft Word"
        Description = "Documents & writing"
    }

    $OfficeApps += [PSCustomObject]@{
        Id = "Excel"
        Label = "Microsoft Excel"
        Description = "Spreadsheets & data"
    }

    $OfficeApps += [PSCustomObject]@{
        Id = "PowerPoint"
        Label = "Microsoft PowerPoint"
        Description = "Presentations"
    }

    $OfficeApps += [PSCustomObject]@{
        Id = "Outlook"
        Label = "Microsoft Outlook"
        Description = "Mail, calendar & contacts"
    }

    $OfficeApps += [PSCustomObject]@{
        Id = "OneNote"
        Label = "Microsoft OneNote"
        Description = "Digital notes"
    }

    # --------------------------------------------------------
    # ACCESS
    # PROFESSIONAL PLUS ONLY
    # --------------------------------------------------------

    if ($Edition -eq "ProPlus") {

        $OfficeApps += [PSCustomObject]@{
            Id = "Access"
            Label = "Microsoft Access"
            Description = "Database management"
        }
    }

    # --------------------------------------------------------
    # PUBLISHER
    # LTSC 2021 ONLY
    # --------------------------------------------------------

    if ($Version -eq "2021") {

        $OfficeApps += [PSCustomObject]@{
            Id = "Publisher"
            Label = "Microsoft Publisher"
            Description = "Desktop publishing"
        }
    }

    $SelectedApps = @()

    $SelectAllNumber = $OfficeApps.Count + 1
    $ClearAllNumber = $OfficeApps.Count + 2

    while ($true) {

        Clear-Host

        Show-RGOADLogo

        Show-RGOADHeader `
            -Title "APPLICATIONS" `
            -Subtitle "Office LTSC $Version • $Edition"

        Write-Host `
            "  Select the applications you want to install." `
            -ForegroundColor Gray

        Write-Host `
            "  Use a number to toggle an application." `
            -ForegroundColor DarkGray

        Write-Host ""

        # ----------------------------------------------------
        # APPLICATION LIST
        # ----------------------------------------------------

        for (
            $i = 0;
            $i -lt $OfficeApps.Count;
            $i++
        ) {

            $App = $OfficeApps[$i]

            if (
                $SelectedApps -contains $App.Id
            ) {

                $Symbol = "●"
                $Color = "Green"
            }
            else {

                $Symbol = "○"
                $Color = "DarkGray"
            }

            Write-Host `
                "  [$($i + 1)] " `
                -NoNewline `
                -ForegroundColor Cyan

            Write-Host `
                "$Symbol  " `
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

        # ----------------------------------------------------
        # SELECT ALL
        # ----------------------------------------------------

        if (
            $SelectedApps.Count -eq
            $OfficeApps.Count
        ) {

            Write-Host `
                "  [$SelectAllNumber] " `
                -NoNewline `
                -ForegroundColor Cyan

            Write-Host `
                "◉  Select All" `
                -ForegroundColor Green
        }
        else {

            Write-Host `
                "  [$SelectAllNumber] " `
                -NoNewline `
                -ForegroundColor Cyan

            Write-Host `
                "○  Select All" `
                -ForegroundColor White
        }

        # ----------------------------------------------------
        # CLEAR ALL
        # ----------------------------------------------------

        Write-Host `
            "  [$ClearAllNumber] " `
            -NoNewline `
            -ForegroundColor Cyan

        Write-Host `
            "○  Clear All" `
            -ForegroundColor Yellow

        # ----------------------------------------------------
        # CONTINUE
        # ----------------------------------------------------

        Write-Host `
            "  [0] " `
            -NoNewline `
            -ForegroundColor Cyan

        Write-Host `
            "→  Continue" `
            -ForegroundColor White

        Write-Host ""
        Write-Host `
            "  Selected: " `
            -NoNewline `
            -ForegroundColor DarkGray

        Write-Host `
            "$($SelectedApps.Count) application(s)" `
            -ForegroundColor Green

        Write-Host ""

        $InputUser = Read-Host "  › Select"

        # ----------------------------------------------------
        # CONTINUE
        # ----------------------------------------------------

        if ($InputUser -eq "0") {

            if ($SelectedApps.Count -eq 0) {

                Write-Peringatan `
                    "Pilih minimal satu aplikasi."

                Start-Sleep -Milliseconds 900

                continue
            }

            return @($SelectedApps)
        }

        # ----------------------------------------------------
        # SELECT ALL
        # ----------------------------------------------------

        if ($InputUser -eq "$SelectAllNumber") {

            $SelectedApps = @(
                $OfficeApps |
                    ForEach-Object {
                        $_.Id
                    }
            )

            continue
        }

        # ----------------------------------------------------
        # CLEAR ALL
        # ----------------------------------------------------

        if ($InputUser -eq "$ClearAllNumber") {

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

        Start-Sleep -Milliseconds 700
    }
}

# ============================================================
# ARCHITECTURE
# ============================================================

function Select-Architecture {

    $Options = @(

        [PSCustomObject]@{
            Label = "64-bit  •  Recommended"
            Value = "64"
        }

        [PSCustomObject]@{
            Label = "32-bit"
            Value = "32"
        }
    )

    return Show-Menu `
        -Title "SELECT ARCHITECTURE" `
        -Description "Choose the Office architecture." `
        -Options $Options
}

# ============================================================
# LANGUAGE
# ============================================================

function Select-Language {

    $Options = @(

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
        -Title "SELECT LANGUAGE" `
        -Description "Choose the Office display language." `
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
# CONFIGURATION XML
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
        -Number 5 `
        -Total 7 `
        -Title "CONFIGURATION" `
        -Description "Generating Office Deployment Tool configuration."

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

    Write-Sukses `
        "configuration.xml berhasil dibuat."

    Write-Host ""
    Write-Host "  Product : $ProductId" `
        -ForegroundColor Gray

    Write-Host "  Channel : $Channel" `
        -ForegroundColor Gray

    Write-Host "  Arch    : $Architecture-bit" `
        -ForegroundColor Gray

    Write-Host "  Language: $Language" `
        -ForegroundColor Gray

    return $ProductId
}

# ============================================================
# CONFIGURATION SUMMARY
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
        -Title "INSTALLATION SUMMARY" `
        -Subtitle "Review your configuration before deployment."

    $Channel = Get-Channel `
        -Version $Version

    Write-Host "  VERSION" `
        -ForegroundColor DarkGray

    Write-Host `
        "  Office LTSC $Version" `
        -ForegroundColor White

    Write-Host ""

    Write-Host "  EDITION" `
        -ForegroundColor DarkGray

    Write-Host `
        "  $Edition" `
        -ForegroundColor White

    Write-Host ""

    Write-Host "  PRODUCT" `
        -ForegroundColor DarkGray

    Write-Host `
        "  $ProductId" `
        -ForegroundColor Cyan

    Write-Host ""

    Write-Host "  CHANNEL" `
        -ForegroundColor DarkGray

    Write-Host `
        "  $Channel" `
        -ForegroundColor White

    Write-Host ""

    Write-Host "  ARCHITECTURE" `
        -ForegroundColor DarkGray

    Write-Host `
        "  $Architecture-bit" `
        -ForegroundColor White

    Write-Host ""

    Write-Host "  LANGUAGE" `
        -ForegroundColor DarkGray

    Write-Host `
        "  $Language" `
        -ForegroundColor White

    Write-Host ""

    Write-Host `
        "  APPLICATIONS" `
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

        Write-Host "  ├─ ✓ " `
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
        "  ACTIVATION" `
        -ForegroundColor DarkGray

    Write-Host `
        "  Disabled / Not performed" `
        -ForegroundColor Yellow

    Write-Host ""
    Write-Host "  $RGOADLine" `
        -ForegroundColor DarkGray

    Write-Host ""

    Write-Host `
        "  [Y] " `
        -NoNewline `
        -ForegroundColor Green

    Write-Host `
        "Continue installation" `
        -ForegroundColor White

    Write-Host `
        "  [N] " `
        -NoNewline `
        -ForegroundColor Red

    Write-Host `
        "Cancel" `
        -ForegroundColor White

    Write-Host ""

    while ($true) {

        $Confirmation = Read-Host "  › Continue"

        if ($Confirmation -match "^[Yy]$") {

            return
        }

        if ($Confirmation -match "^[Nn]$") {

            Write-Host ""

            Write-Info `
                "Installation cancelled."

            exit 0
        }

        Write-Peringatan `
            "Masukkan Y atau N."
    }
}

# ============================================================
# DOWNLOAD ODT
# ============================================================

function Get-ODT {

    Show-Step `
        -Number 6 `
        -Total 7 `
        -Title "MICROSOFT ODT" `
        -Description "Downloading the official Office Deployment Tool."

    Write-Info `
        "Microsoft ODT page:"

    Write-Host ""
    Write-Host `
        "  $MicrosoftODTPage" `
        -ForegroundColor DarkGray

    Write-Host ""

    try {

        Write-Info `
            "Mencari download link ODT resmi..."

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

            $ODTLink = "https:$ODTLink"
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
                "Sumber ODT bukan domain Microsoft."
        }

        Write-Sukses `
            "Official Microsoft ODT link ditemukan."

        $ODTInstaller = Join-Path `
            $WorkDirectory `
            "officedeploymenttool.exe"

        Write-Info `
            "Downloading ODT..."

        Invoke-WebRequest `
            -Uri $ODTLink `
            -OutFile $ODTInstaller `
            -UseBasicParsing

        if (-not (Test-Path $ODTInstaller)) {

            throw `
                "File ODT tidak ditemukan."
        }

        $FileSize = `
            (Get-Item $ODTInstaller).Length

        if ($FileSize -lt 100000) {

            throw `
                "File ODT terlalu kecil atau tidak valid."
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
            "ODT dapat diunduh secara manual dari Microsoft."

        Write-Host ""

        Write-Host `
            $MicrosoftODTPage `
            -ForegroundColor Cyan

        exit 1
    }
}

# ============================================================
# EXTRACT ODT
# ============================================================

function Expand-ODT {

    param(
        [Parameter(Mandatory = $true)]
        [string]$Installer
    )

    Show-Step `
        -Number 6 `
        -Total 7 `
        -Title "PREPARING ODT" `
        -Description "Extracting the Office Deployment Tool."

    try {

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
                "ODT gagal diekstrak. Exit Code: $($Process.ExitCode)"
        }

        $SetupFile = Join-Path `
            $ODTDirectory `
            "setup.exe"

        if (-not (Test-Path $SetupFile)) {

            throw `
                "setup.exe tidak ditemukan."
        }

        Write-Sukses `
            "ODT berhasil diekstrak."

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
        -Title "DOWNLOADING OFFICE" `
        -Description "Downloading Office files through Microsoft ODT."

    Write-Info `
        "Office akan diunduh dari CDN Microsoft."

    Write-Host ""
    Write-Peringatan `
        "Ukuran download dapat mencapai beberapa GB."

    Write-Host ""

    Show-RGOADProgress `
        -Label "Download initialized" `
        -Percent 10

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
            "Exit Code: $($Process.ExitCode)" `
            -ForegroundColor Red

        exit 1
    }

    Show-RGOADProgress `
        -Label "Office package downloaded" `
        -Percent 100

    Write-Sukses `
        "File Office berhasil diunduh."
}

# ============================================================
# INSTALL OFFICE
# ============================================================

function Install-Office {

    param(
        [Parameter(Mandatory = $true)]
        [string]$SetupFile
    )

    Show-Step `
        -Number 7 `
        -Total 7 `
        -Title "INSTALLING OFFICE" `
        -Description "Deploying Microsoft Office using ODT."

    Write-Host ""

    Write-Peringatan `
        "Jangan matikan komputer selama proses instalasi."

    Write-Host ""

    Show-RGOADProgress `
        -Label "Starting Office deployment" `
        -Percent 10

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
            "Exit Code: $($Process.ExitCode)" `
            -ForegroundColor Red

        Write-Host ""

        Write-Peringatan `
            "Periksa log Office di folder TEMP Windows."

        exit 1
    }

    Show-RGOADProgress `
        -Label "Office deployment completed" `
        -Percent 100

    Write-Sukses `
        "Instalasi Office selesai."
}

# ============================================================
# FINISH
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
    Write-Host "  ╔════════════════════════════════════════════════════════╗" `
        -ForegroundColor Green

    Write-Host "  ║                                                        ║" `
        -ForegroundColor Green

    Write-Host "  ║                 DEPLOYMENT COMPLETE                    ║" `
        -ForegroundColor White

    Write-Host "  ║                                                        ║" `
        -ForegroundColor Green

    Write-Host "  ╚════════════════════════════════════════════════════════╝" `
        -ForegroundColor Green

    Write-Host ""

    Write-Host "  RGOAD / OFFICE INSTALLER" `
        -ForegroundColor Cyan

    Write-Host ""

    Write-Sukses `
        "Microsoft Office LTSC $Version berhasil dipasang."

    Write-Host ""

    Write-Host `
        "  Edition : " `
        -NoNewline `
        -ForegroundColor DarkGray

    Write-Host `
        $Edition `
        -ForegroundColor White

    Write-Host ""

    Write-Host `
        "  Applications" `
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
                "  ├─ ✓ $($AppLabels[$AppId])" `
                -ForegroundColor Green
        }
    }

    Write-Host ""

    Write-Host `
        "  Activation" `
        -ForegroundColor DarkGray

    Write-Host `
        "  Not performed by RGOAD." `
        -ForegroundColor Yellow

    Write-Host ""

    Write-Host `
        "  Workspace" `
        -ForegroundColor DarkGray

    Write-Host `
        "  $WorkDirectory" `
        -ForegroundColor DarkGray

    Write-Host ""

    Write-Host "  $RGOADDoubleLine" `
        -ForegroundColor DarkCyan

    Write-Host ""

    Write-Host `
        "  RGOAD deployment finished successfully." `
        -ForegroundColor Cyan

    Write-Host ""

    Pause-RGOAD
}

# ============================================================
# MAIN
# ============================================================

try {

    # --------------------------------------------------------
    # ADMINISTRATOR
    # --------------------------------------------------------

    Request-Administrator

    # --------------------------------------------------------
    # INITIAL SCREEN
    # --------------------------------------------------------

    Show-RGOADLogo

    Write-Host `
        "  RGOAD Office Installer" `
        -ForegroundColor White

    Write-Host `
        "  Version $RGOADVersion" `
        -ForegroundColor DarkGray

    Write-Host ""

    Write-Host `
        "  Deploy Microsoft Office LTSC with a clean" `
        -ForegroundColor Gray

    Write-Host `
        "  and interactive PowerShell experience." `
        -ForegroundColor Gray

    Write-Host ""

    Write-Host `
        "  Supported:" `
        -ForegroundColor DarkGray

    Write-Host `
        "  • Office LTSC 2024" `
        -ForegroundColor Gray

    Write-Host `
        "  • Office LTSC 2021" `
        -ForegroundColor Gray

    Write-Host `
        "  • Professional Plus / Standard" `
        -ForegroundColor Gray

    Write-Host ""

    Write-Host `
        "  $RGOADLine" `
        -ForegroundColor DarkGray

    Write-Host ""

    Write-Info `
        "Initializing RGOAD deployment engine..."

    Start-Sleep -Milliseconds 500

    # --------------------------------------------------------
    # SYSTEM
    # --------------------------------------------------------

    Test-Windows

    # --------------------------------------------------------
    # INTERNET
    # --------------------------------------------------------

    Test-Internet

    # --------------------------------------------------------
    # WORKSPACE
    # --------------------------------------------------------

    Initialize-WorkDirectory

    # --------------------------------------------------------
    # VERSION
    # --------------------------------------------------------

    $OfficeVersion = Select-OfficeVersion

    # --------------------------------------------------------
    # EDITION
    # --------------------------------------------------------

    $OfficeEdition = Select-OfficeEdition

    # --------------------------------------------------------
    # APPLICATIONS
    # --------------------------------------------------------

    $SelectedApps = Select-OfficeApps `
        -Version $OfficeVersion `
        -Edition $OfficeEdition

    # --------------------------------------------------------
    # ARCHITECTURE
    # --------------------------------------------------------

    $Architecture = Select-Architecture

    # --------------------------------------------------------
    # LANGUAGE
    # --------------------------------------------------------

    $Language = Select-Language

    # --------------------------------------------------------
    # PRODUCT
    # --------------------------------------------------------

    $ProductId = Get-ProductId `
        -Version $OfficeVersion `
        -Edition $OfficeEdition

    # --------------------------------------------------------
    # CONFIGURATION
    # --------------------------------------------------------

    New-Configuration `
        -Version $OfficeVersion `
        -Edition $OfficeEdition `
        -Architecture $Architecture `
        -Language $Language `
        -SelectedApps $SelectedApps |
        Out-Null

    # --------------------------------------------------------
    # SUMMARY
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
    # EXTRACT ODT
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
    # FINISH
    # --------------------------------------------------------

    Show-Finish `
        -SelectedApps $SelectedApps `
        -Version $OfficeVersion `
        -Edition $OfficeEdition
}
catch {

    Clear-Host

    Write-Host ""
    Write-Host "  ╔════════════════════════════════════════════════════════╗" `
        -ForegroundColor Red

    Write-Host "  ║                    RGOAD ERROR                         ║" `
        -ForegroundColor White

    Write-Host "  ╚════════════════════════════════════════════════════════╝" `
        -ForegroundColor Red

    Write-Host ""

    Write-Gagal `
        $_.Exception.Message

    Write-Host ""

    Write-Host `
        "  Troubleshooting:" `
        -ForegroundColor Yellow

    Write-Host `
        "  docs\TROUBLESHOOTING.md" `
        -ForegroundColor Cyan

    Write-Host ""

    Write-Host `
        "  Workspace:" `
        -ForegroundColor DarkGray

    Write-Host `
        $WorkDirectory `
        -ForegroundColor DarkGray

    Write-Host ""

    Pause-RGOAD

    exit 1
}
