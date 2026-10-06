#Requires -Version 5.1

<#
.SYNOPSIS
    RGOAD Office Installer

.DESCRIPTION
    Installer Microsoft Office LTSC menggunakan
    Microsoft Office Deployment Tool (ODT).

    Fitur:
    - Office LTSC 2024
    - Office LTSC 2021
    - Professional Plus / Standard
    - Pilihan aplikasi
    - 64-bit / 32-bit
    - Bahasa Indonesia / English
    - Download ODT otomatis
    - Download Office melalui ODT
    - Install Office melalui ODT
    - Automatic UAC elevation
    - RGOAD themed interface

.NOTES
    Project : RGOAD Office Installer
    Version : 1.1.0
    Author  : Febrian Suban

    Tidak menyediakan:
    - Product key
    - Crack
    - KMS
    - Loader
    - Bypass activation
    - Patch
#>

# ============================================================
# CONFIGURATION
# ============================================================

$RGOADName = "RGOAD"
$RGOADVersion = "1.1.0"
$RGOADTagline = "OFFICE DEPLOYMENT SYSTEM"
$RGOADLine = "=============================================="

$RepositoryScriptUrl = "https://raw.githubusercontent.com/FebrianSuban/office-installer/main/Install-Office.ps1"

$MicrosoftODTPage = "https://www.microsoft.com/download/details.aspx?id=49117"

$Workspace = Join-Path $env:TEMP "Office-Installer"
$ODTDirectory = Join-Path $Workspace "ODT"
$ConfigurationFile = Join-Path $Workspace "configuration.xml"
$ElevatedScript = Join-Path $Workspace "Install-Office-Elevated.ps1"

$ScriptVersion = $RGOADVersion


# ============================================================
# THEME
# ============================================================

$ColorPrimary = "Cyan"
$ColorSecondary = "DarkCyan"
$ColorAccent = "Blue"
$ColorSuccess = "Green"
$ColorWarning = "Yellow"
$ColorError = "Red"
$ColorMuted = "DarkGray"
$ColorText = "White"


# ============================================================
# LOGO RGOAD
# ============================================================

function Show-RGOADLogo {

    Clear-Host

    Write-Host ""

    Write-Host "  ██████╗   ██████╗   ██████╗   █████╗  ██████╗ " `
        -ForegroundColor Cyan

    Write-Host "  ██╔══██╗ ██╔════╝  ██╔═══██╗ ██╔══██╗ ██╔══██╗" `
        -ForegroundColor Cyan

    Write-Host "  ██║  ██║ ██║  ███╗ ██║   ██║ ███████║ ██║  ██║" `
        -ForegroundColor Cyan

    Write-Host "  ██║  ██║ ██║   ██║ ██║   ██║ ██╔══██║ ██║  ██║" `
        -ForegroundColor Cyan

    Write-Host "  ╚█████╔╝ ╚██████╔╝ ╚██████╔╝ ██║  ██║ ██████╔╝" `
        -ForegroundColor Cyan

    Write-Host "   ╚════╝   ╚═════╝   ╚═════╝  ╚═╝  ╚═╝ ╚═════╝ " `
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
# BASIC FUNCTIONS
# ============================================================

function Pause-RGOAD {
    Write-Host ""
    Write-Host "Press ENTER to continue..." -ForegroundColor $ColorMuted
    Read-Host
}


function Write-RGOADHeader {
    param(
        [string]$Title
    )

    Write-Host ""
    Write-Host "  $Title" -ForegroundColor $ColorPrimary
    Write-Host "  $RGOADLine" -ForegroundColor $ColorSecondary
    Write-Host ""
}


function Write-RGOADInfo {
    param(
        [string]$Message
    )

    Write-Host "  [INFO] " -NoNewline -ForegroundColor $ColorPrimary
    Write-Host $Message -ForegroundColor $ColorText
}


function Write-RGOADSuccess {
    param(
        [string]$Message
    )

    Write-Host "  [OK]   " -NoNewline -ForegroundColor $ColorSuccess
    Write-Host $Message -ForegroundColor $ColorText
}


function Write-RGOADWarning {
    param(
        [string]$Message
    )

    Write-Host "  [WARN] " -NoNewline -ForegroundColor $ColorWarning
    Write-Host $Message -ForegroundColor $ColorText
}


function Write-RGOADError {
    param(
        [string]$Message
    )

    Write-Host "  [ERROR] " -NoNewline -ForegroundColor $ColorError
    Write-Host $Message -ForegroundColor $ColorText
}


function Test-Administrator {

    $currentIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()

    $principal = New-Object Security.Principal.WindowsPrincipal($currentIdentity)

    return $principal.IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator
    )
}


# ============================================================
# UAC ELEVATION
# ============================================================

function Start-RGOADElevated {

    if (Test-Administrator) {
        return
    }

    Show-RGOADLogo

    Write-RGOADInfo "Administrator privileges are required."
    Write-RGOADInfo "Requesting UAC elevation..."
    Write-Host ""

    try {

        $scriptPath = $MyInvocation.MyCommand.Path

        if ([string]::IsNullOrWhiteSpace($scriptPath)) {

            Write-RGOADInfo "Creating temporary elevated script..."

            $currentScript = $MyInvocation.ScriptName

            if ([string]::IsNullOrWhiteSpace($currentScript)) {
                throw "Unable to determine current script path."
            }

            Copy-Item `
                -Path $currentScript `
                -Destination $ElevatedScript `
                -Force

            $scriptPath = $ElevatedScript
        }

        $arguments = @(
            "-NoProfile"
            "-ExecutionPolicy"
            "Bypass"
            "-File"
            "`"$scriptPath`""
            "-RGOADElevated"
        )

        Start-Process `
            -FilePath "powershell.exe" `
            -ArgumentList ($arguments -join " ") `
            -Verb RunAs

        exit

    }
    catch {

        Write-RGOADError "Failed to request administrator privileges."
        Write-RGOADError $_.Exception.Message

        Pause-RGOAD
        exit 1
    }
}


# ============================================================
# SYSTEM CHECK
# ============================================================

function Test-RGOADSystem {

    Write-RGOADHeader "SYSTEM CHECK"

    Write-RGOADInfo "Checking Windows version..."

    try {

        $os = Get-CimInstance Win32_OperatingSystem

        Write-RGOADSuccess "$($os.Caption)"

    }
    catch {

        Write-RGOADWarning "Unable to read Windows version."
    }


    Write-RGOADInfo "Checking PowerShell..."

    $psVersion = $PSVersionTable.PSVersion.ToString()

    Write-RGOADSuccess "PowerShell $psVersion"


    Write-RGOADInfo "Checking administrator privileges..."

    if (Test-Administrator) {

        Write-RGOADSuccess "Administrator privileges detected."

    }
    else {

        Write-RGOADError "Administrator privileges are required."
        return $false
    }


    Write-RGOADInfo "Checking internet connectivity..."

    try {

        $test = Invoke-WebRequest `
            -Uri "https://www.microsoft.com" `
            -Method Head `
            -UseBasicParsing `
            -TimeoutSec 15

        if ($test.StatusCode -ge 200 -and $test.StatusCode -lt 400) {

            Write-RGOADSuccess "Internet connection available."

        }
        else {

            Write-RGOADWarning "Microsoft website returned HTTP $($test.StatusCode)."
        }

    }
    catch {

        Write-RGOADError "Internet connection is unavailable."
        return $false
    }


    return $true
}


# ============================================================
# WORKSPACE
# ============================================================

function Initialize-RGOADWorkspace {

    Write-RGOADHeader "WORKSPACE"

    try {

        if (Test-Path $Workspace) {

            Write-RGOADInfo "Cleaning previous workspace..."

            Remove-Item `
                -Path $Workspace `
                -Recurse `
                -Force `
                -ErrorAction SilentlyContinue
        }

        New-Item `
            -ItemType Directory `
            -Path $Workspace `
            -Force | Out-Null

        New-Item `
            -ItemType Directory `
            -Path $ODTDirectory `
            -Force | Out-Null

        Write-RGOADSuccess "Workspace created."

        Write-RGOADInfo "Location: $Workspace"

        return $true

    }
    catch {

        Write-RGOADError "Unable to create workspace."
        Write-RGOADError $_.Exception.Message

        return $false
    }
}


# ============================================================
# OFFICE VERSION MENU
# ============================================================

function Select-OfficeVersion {

    Write-RGOADHeader "OFFICE VERSION"

    Write-Host "  [1] Microsoft Office LTSC 2024" -ForegroundColor $ColorText
    Write-Host "  [2] Microsoft Office LTSC 2021" -ForegroundColor $ColorText
    Write-Host ""

    while ($true) {

        $choice = Read-Host "  Select version"

        switch ($choice) {

            "1" {
                return "2024"
            }

            "2" {
                return "2021"
            }

            default {
                Write-RGOADWarning "Invalid selection."
            }
        }
    }
}


# ============================================================
# OFFICE EDITION MENU
# ============================================================

function Select-OfficeEdition {

    param(
        [string]$Version
    )

    Write-RGOADHeader "OFFICE EDITION"

    Write-Host "  [1] Professional Plus" -ForegroundColor $ColorText
    Write-Host "  [2] Standard" -ForegroundColor $ColorText
    Write-Host ""

    while ($true) {

        $choice = Read-Host "  Select edition"

        switch ($choice) {

            "1" {

                if ($Version -eq "2024") {
                    return "ProPlus2024Volume"
                }

                return "ProPlus2021Volume"
            }

            "2" {

                if ($Version -eq "2024") {
                    return "Standard2024Volume"
                }

                return "Standard2021Volume"
            }

            default {
                Write-RGOADWarning "Invalid selection."
            }
        }
    }
}


# ============================================================
# OFFICE EDITION NAME
# ============================================================

function Get-EditionName {

    param(
        [string]$ProductID
    )

    switch ($ProductID) {

        "ProPlus2024Volume" {
            return "Professional Plus 2024"
        }

        "Standard2024Volume" {
            return "Standard 2024"
        }

        "ProPlus2021Volume" {
            return "Professional Plus 2021"
        }

        "Standard2021Volume" {
            return "Standard 2021"
        }

        default {
            return $ProductID
        }
    }
}


# ============================================================
# APPLICATION LIST
# ============================================================

function Get-OfficeApplications {

    param(
        [string]$Version,
        [string]$ProductID
    )

    $apps = @(
        "Word",
        "Excel",
        "PowerPoint",
        "Outlook",
        "OneNote"
    )

    if ($ProductID -like "ProPlus*") {

        $apps += "Access"
    }

    if ($Version -eq "2021") {

        $apps += "Publisher"
    }

    return $apps
}


# ============================================================
# APPLICATION SELECTION
# ============================================================

function Select-OfficeApplications {

    param(
        [string]$Version,
        [string]$ProductID
    )

    $applications = Get-OfficeApplications `
        -Version $Version `
        -ProductID $ProductID

    $selected = @()

    while ($true) {

        Write-RGOADHeader "APPLICATION SELECTION"

        Write-Host "  Available applications:" -ForegroundColor $ColorText
        Write-Host ""

        for ($i = 0; $i -lt $applications.Count; $i++) {

            $number = $i + 1

            Write-Host `
                "  [$number] $($applications[$i])" `
                -ForegroundColor $ColorText
        }

        Write-Host ""
        Write-Host "  [A] Select all" -ForegroundColor $ColorSuccess
        Write-Host "  [D] Done" -ForegroundColor $ColorPrimary
        Write-Host ""

        if ($selected.Count -gt 0) {

            Write-Host "  Selected:" -ForegroundColor $ColorSecondary

            foreach ($item in $selected) {

                Write-Host `
                    "    - $item" `
                    -ForegroundColor $ColorSuccess
            }

            Write-Host ""
        }

        $choice = Read-Host "  Select application"

        if ($choice -match "^[Aa]$") {

            $selected = @($applications)

            continue
        }

        if ($choice -match "^[Dd]$") {

            if ($selected.Count -eq 0) {

                Write-RGOADWarning "Select at least one application."

                continue
            }

            return $selected
        }

        if ($choice -match "^\d+$") {

            $index = [int]$choice - 1

            if (
                $index -ge 0 -and
                $index -lt $applications.Count
            ) {

                $app = $applications[$index]

                if ($selected -contains $app) {

                    $selected = @(
                        $selected | Where-Object {
                            $_ -ne $app
                        }
                    )

                    Write-RGOADInfo "$app removed."

                }
                else {

                    $selected += $app

                    Write-RGOADSuccess "$app selected."
                }

            }
            else {

                Write-RGOADWarning "Invalid application number."
            }

        }
        else {

            Write-RGOADWarning "Invalid selection."
        }
    }
}


# ============================================================
# ARCHITECTURE
# ============================================================

function Select-OfficeArchitecture {

    Write-RGOADHeader "ARCHITECTURE"

    Write-Host "  [1] 64-bit (Recommended)" -ForegroundColor $ColorText
    Write-Host "  [2] 32-bit" -ForegroundColor $ColorText
    Write-Host ""

    while ($true) {

        $choice = Read-Host "  Select architecture"

        switch ($choice) {

            "1" {
                return "64"
            }

            "2" {
                return "32"
            }

            default {
                Write-RGOADWarning "Invalid selection."
            }
        }
    }
}


# ============================================================
# LANGUAGE
# ============================================================

function Select-OfficeLanguage {

    Write-RGOADHeader "LANGUAGE"

    Write-Host "  [1] Bahasa Indonesia" -ForegroundColor $ColorText
    Write-Host "  [2] English" -ForegroundColor $ColorText
    Write-Host ""

    while ($true) {

        $choice = Read-Host "  Select language"

        switch ($choice) {

            "1" {
                return "id-id"
            }

            "2" {
                return "en-us"
            }

            default {
                Write-RGOADWarning "Invalid selection."
            }
        }
    }
}


# ============================================================
# CHANNEL
# ============================================================

function Get-OfficeChannel {

    param(
        [string]$Version
    )

    if ($Version -eq "2024") {
        return "PerpetualVL2024"
    }

    return "PerpetualVL2021"
}


# ============================================================
# EXCLUDE APP XML
# ============================================================

function Get-ExcludeAppXml {

    param(
        [string[]]$AvailableApps,
        [string[]]$SelectedApps
    )

    $xml = ""

    foreach ($app in $AvailableApps) {

        if ($SelectedApps -notcontains $app) {

            $xml += "      <ExcludeApp ID=`"$app`" />`r`n"
        }
    }

    return $xml
}


# ============================================================
# CREATE ODT CONFIGURATION
# ============================================================

function New-Configuration {

    param(
        [string]$Version,
        [string]$ProductID,
        [string[]]$SelectedApps,
        [string]$Architecture,
        [string]$Language
    )

    Write-RGOADHeader "CONFIGURATION"

    $channel = Get-OfficeChannel -Version $Version

    $availableApps = Get-OfficeApplications `
        -Version $Version `
        -ProductID $ProductID

    $excludeApps = Get-ExcludeAppXml `
        -AvailableApps $availableApps `
        -SelectedApps $SelectedApps

    $xmlArchitecture = $Architecture

    $configuration = @"
<Configuration>
  <Add OfficeClientEdition="$xmlArchitecture" Channel="$channel">
    <Product ID="$ProductID">
      <Language ID="$Language" />
$excludeApps    </Product>
  </Add>

  <RemoveMSI />

  <Display Level="Full" AcceptEULA="TRUE" />

  <Property Name="AUTOACTIVATE" Value="0" />

  <Updates Enabled="TRUE" />
</Configuration>
"@

    try {

        Set-Content `
            -Path $ConfigurationFile `
            -Value $configuration `
            -Encoding UTF8

        Write-RGOADSuccess "Configuration file created."
        Write-RGOADInfo "File: $ConfigurationFile"

        return $true
    }
    catch {

        Write-RGOADError "Failed to create configuration file."
        Write-RGOADError $_.Exception.Message

        return $false
    }
}


# ============================================================
# DOWNLOAD ODT
# ============================================================

function Get-ODT {

    Write-RGOADHeader "OFFICE DEPLOYMENT TOOL"

    Write-RGOADInfo "Opening Microsoft ODT download page..."

    try {

        $page = Invoke-WebRequest `
            -Uri $MicrosoftODTPage `
            -UseBasicParsing

        $links = $page.Links |
            Where-Object {
                $_.href -and
                $_.href -match "\.exe"
            }

        $downloadUrl = $null

        foreach ($link in $links) {

            try {

                $uri = [System.Uri]$link.href

                if (
                    $uri.Host -like "*microsoft.com" -or
                    $uri.Host -like "*officecdn.microsoft.com"
                ) {

                    $downloadUrl = $link.href
                    break
                }

            }
            catch {
            }
        }

        if ([string]::IsNullOrWhiteSpace($downloadUrl)) {

            throw "Microsoft Office Deployment Tool download link was not found."
        }

        $odtInstaller = Join-Path `
            $Workspace `
            "officedeploymenttool.exe"

        Write-RGOADInfo "Downloading Microsoft Office Deployment Tool..."

        Invoke-WebRequest `
            -Uri $downloadUrl `
            -OutFile $odtInstaller `
            -UseBasicParsing

        if (-not (Test-Path $odtInstaller)) {

            throw "ODT installer was not downloaded."
        }

        Write-RGOADSuccess "ODT downloaded."

        return $odtInstaller

    }
    catch {

        Write-RGOADError "Failed to download Microsoft Office Deployment Tool."
        Write-RGOADError $_.Exception.Message

        return $null
    }
}


# ============================================================
# EXTRACT ODT
# ============================================================

function Expand-ODT {

    param(
        [string]$ODTInstaller
    )

    Write-RGOADHeader "EXTRACT ODT"

    try {

        Write-RGOADInfo "Extracting Office Deployment Tool..."

        $process = Start-Process `
            -FilePath $ODTInstaller `
            -ArgumentList "/quiet", "/extract:$ODTDirectory" `
            -Wait `
            -PassThru

        if ($process.ExitCode -ne 0) {

            throw "ODT extraction failed with exit code $($process.ExitCode)."
        }

        $setup = Join-Path `
            $ODTDirectory `
            "setup.exe"

        if (-not (Test-Path $setup)) {

            throw "setup.exe was not found after extraction."
        }

        Write-RGOADSuccess "ODT extracted successfully."

        return $setup

    }
    catch {

        Write-RGOADError "Failed to extract ODT."
        Write-RGOADError $_.Exception.Message

        return $null
    }
}


# ============================================================
# DOWNLOAD OFFICE
# ============================================================

function Download-Office {

    param(
        [string]$SetupPath
    )

    Write-RGOADHeader "DOWNLOAD OFFICE"

    Write-RGOADInfo "Downloading Microsoft Office installation files..."
    Write-RGOADInfo "This process may take some time depending on your internet speed."
    Write-Host ""

    try {

        $arguments = @(
            "/download"
            "`"$ConfigurationFile`""
        )

        $process = Start-Process `
            -FilePath $SetupPath `
            -ArgumentList ($arguments -join " ") `
            -Wait `
            -PassThru

        if ($process.ExitCode -ne 0) {

            throw "Office download failed with exit code $($process.ExitCode)."
        }

        Write-RGOADSuccess "Office installation files downloaded successfully."

        return $true

    }
    catch {

        Write-RGOADError "Failed to download Office."
        Write-RGOADError $_.Exception.Message

        return $false
    }
}


# ============================================================
# INSTALL OFFICE
# ============================================================

function Install-Office {

    param(
        [string]$SetupPath
    )

    Write-RGOADHeader "INSTALL OFFICE"

    Write-RGOADInfo "Starting Microsoft Office installation..."
    Write-RGOADInfo "Please do not close this window."
    Write-Host ""

    try {

        $arguments = @(
            "/configure"
            "`"$ConfigurationFile`""
        )

        $process = Start-Process `
            -FilePath $SetupPath `
            -ArgumentList ($arguments -join " ") `
            -Wait `
            -PassThru

        if ($process.ExitCode -ne 0) {

            throw "Office installation failed with exit code $($process.ExitCode)."
        }

        Write-RGOADSuccess "Microsoft Office installation completed."

        return $true

    }
    catch {

        Write-RGOADError "Office installation failed."
        Write-RGOADError $_.Exception.Message

        return $false
    }
}


# ============================================================
# CONFIRMATION
# ============================================================

function Confirm-Installation {

    param(
        [string]$Version,
        [string]$ProductID,
        [string[]]$SelectedApps,
        [string]$Architecture,
        [string]$Language
    )

    $editionName = Get-EditionName -ProductID $ProductID

    $languageName = switch ($Language) {
        "id-id" { "Bahasa Indonesia" }
        "en-us" { "English" }
        default { $Language }
    }

    Write-RGOADHeader "INSTALLATION SUMMARY"

    Write-Host "  Office Version : " -NoNewline -ForegroundColor $ColorSecondary
    Write-Host "Office LTSC $Version" -ForegroundColor $ColorText

    Write-Host "  Edition        : " -NoNewline -ForegroundColor $ColorSecondary
    Write-Host $editionName -ForegroundColor $ColorText

    Write-Host "  Architecture   : " -NoNewline -ForegroundColor $ColorSecondary
    Write-Host "$Architecture-bit" -ForegroundColor $ColorText

    Write-Host "  Language       : " -NoNewline -ForegroundColor $ColorSecondary
    Write-Host $languageName -ForegroundColor $ColorText

    Write-Host "  Applications   : " -ForegroundColor $ColorSecondary

    foreach ($app in $SelectedApps) {

        Write-Host "                   - $app" -ForegroundColor $ColorText
    }

    Write-Host ""

    Write-Host "  Installation files will be downloaded from Microsoft." `
        -ForegroundColor $ColorMuted

    Write-Host ""

    while ($true) {

        $answer = Read-Host "  Continue installation? [Y/N]"

        if ($answer -match "^[Yy]$") {
            return $true
        }

        if ($answer -match "^[Nn]$") {
            return $false
        }

        Write-RGOADWarning "Please enter Y or N."
    }
}


# ============================================================
# FINISH SCREEN
# ============================================================

function Show-RGOADSuccess {

    Show-RGOADLogo

    Write-Host ""
    Write-Host "  INSTALLATION COMPLETED" -ForegroundColor $ColorSuccess
    Write-Host "  $RGOADLine" -ForegroundColor $ColorSecondary
    Write-Host ""

    Write-Host "  Microsoft Office has been installed successfully." `
        -ForegroundColor $ColorText

    Write-Host ""

    Write-Host "  You can now open:" -ForegroundColor $ColorSecondary
    Write-Host "    Word" -ForegroundColor $ColorText
    Write-Host "    Excel" -ForegroundColor $ColorText
    Write-Host "    PowerPoint" -ForegroundColor $ColorText
    Write-Host "    Outlook" -ForegroundColor $ColorText
    Write-Host "    OneNote" -ForegroundColor $ColorText

    Write-Host ""

    Write-Host "  RGOAD $RGOADVersion" -ForegroundColor $ColorMuted

    Write-Host ""

    Pause-RGOAD
}


# ============================================================
# ERROR SCREEN
# ============================================================

function Show-RGOADError {

    param(
        [string]$Message
    )

    Show-RGOADLogo

    Write-Host ""
    Write-Host "  INSTALLATION FAILED" -ForegroundColor $ColorError
    Write-Host "  $RGOADLine" -ForegroundColor $ColorSecondary
    Write-Host ""

    Write-RGOADError $Message

    Write-Host ""

    Write-Host "  Workspace:" -ForegroundColor $ColorSecondary
    Write-Host "  $Workspace" -ForegroundColor $ColorText

    Write-Host ""

    Pause-RGOAD
}


# ============================================================
# MAIN
# ============================================================

function Start-RGOAD {

    Show-RGOADLogo

    Write-Host "  Microsoft Office LTSC Installer" `
        -ForegroundColor $ColorText

    Write-Host ""

    Write-Host "  Version : $RGOADVersion" `
        -ForegroundColor $ColorMuted

    Write-Host "  Project : $RGOADName" `
        -ForegroundColor $ColorMuted

    Write-Host ""

    if (-not (Test-RGOADSystem)) {

        Show-RGOADError `
            "System requirements or internet connectivity check failed."

        return
    }

    if (-not (Initialize-RGOADWorkspace)) {

        Show-RGOADError `
            "Unable to initialize installer workspace."

        return
    }

    $version = Select-OfficeVersion

    $productID = Select-OfficeEdition `
        -Version $version

    $selectedApps = Select-OfficeApplications `
        -Version $version `
        -ProductID $productID

    $architecture = Select-OfficeArchitecture

    $language = Select-OfficeLanguage

    Show-RGOADLogo

    if (-not (
        Confirm-Installation `
            -Version $version `
            -ProductID $productID `
            -SelectedApps $selectedApps `
            -Architecture $architecture `
            -Language $language
    )) {

        Write-Host ""
        Write-RGOADWarning "Installation cancelled by user."
        Write-Host ""

        Pause-RGOAD

        return
    }

    if (-not (
        New-Configuration `
            -Version $version `
            -ProductID $productID `
            -SelectedApps $selectedApps `
            -Architecture $architecture `
            -Language $language
    )) {

        Show-RGOADError `
            "Failed to generate Office Deployment Tool configuration."

        return
    }

    $odtInstaller = Get-ODT

    if ([string]::IsNullOrWhiteSpace($odtInstaller)) {

        Show-RGOADError `
            "Microsoft Office Deployment Tool could not be downloaded."

        return
    }

    $setupPath = Expand-ODT `
        -ODTInstaller $odtInstaller

    if ([string]::IsNullOrWhiteSpace($setupPath)) {

        Show-RGOADError `
            "Microsoft Office Deployment Tool could not be extracted."

        return
    }

    if (-not (
        Download-Office `
            -SetupPath $setupPath
    )) {

        Show-RGOADError `
            "Office installation files could not be downloaded."

        return
    }

    if (-not (
        Install-Office `
            -SetupPath $setupPath
    )) {

        Show-RGOADError `
            "Microsoft Office installation failed."

        return
    }

    Show-RGOADSuccess
}


# ============================================================
# ENTRY POINT
# ============================================================

try {

    Start-RGOADElevated

    Start-RGOAD

}
catch {

    Show-RGOADError `
        $_.Exception.Message

    exit 1
}
finally {

    if (
        $ElevatedScript -and
        (Test-Path $ElevatedScript)
    ) {

        Remove-Item `
            -Path $ElevatedScript `
            -Force `
            -ErrorAction SilentlyContinue
    }
}