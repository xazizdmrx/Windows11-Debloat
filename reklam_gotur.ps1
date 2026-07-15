# ==========================================
# Windows 11 Reklam ve Önerileri Kapat
# ==========================================

Write-Host ""
Write-Host "Windows 11 ayarlari uygulanıyor..." -ForegroundColor Cyan
Write-Host ""

# Yönetici kontrolü
if (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
    [Security.Principal.WindowsBuiltInRole]::Administrator))
{
    Write-Host "Bu script yönetici olarak çalıştırılmalıdır." -ForegroundColor Red
    Pause
    exit
}

function Set-Dword {
    param($Path,$Name,$Value)

    if (!(Test-Path $Path)) {
        New-Item -Path $Path -Force | Out-Null
    }

    New-ItemProperty `
        -Path $Path `
        -Name $Name `
        -Value $Value `
        -PropertyType DWord `
        -Force | Out-Null
}

####################################################
# Search Highlights
####################################################

Set-Dword "HKCU:\Software\Microsoft\Windows\CurrentVersion\SearchSettings" "IsDynamicSearchBoxEnabled" 0

####################################################
# Bing Search
####################################################

Set-Dword "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "BingSearchEnabled" 0
Set-Dword "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" "CortanaConsent" 0

####################################################
# Search Box Suggestions
####################################################

Set-Dword "HKCU:\Software\Policies\Microsoft\Windows\Explorer" "DisableSearchBoxSuggestions" 1

####################################################
# Consumer Features
####################################################

Set-Dword "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" "DisableWindowsConsumerFeatures" 1

####################################################
# Spotlight
####################################################

Set-Dword "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "RotatingLockScreenEnabled" 0
Set-Dword "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "RotatingLockScreenOverlayEnabled" 0

####################################################
# Content Suggestions
####################################################

$cdm = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"

$values = @(
"ContentDeliveryAllowed",
"FeatureManagementEnabled",
"OemPreInstalledAppsEnabled",
"PreInstalledAppsEnabled",
"PreInstalledAppsEverEnabled",
"SilentInstalledAppsEnabled",
"SoftLandingEnabled",
"SubscribedContent-338387Enabled",
"SubscribedContent-338388Enabled",
"SubscribedContent-338389Enabled",
"SubscribedContent-338393Enabled",
"SubscribedContent-353694Enabled",
"SubscribedContent-353696Enabled",
"SubscribedContentEnabled",
"SystemPaneSuggestionsEnabled"
)

foreach($v in $values)
{
    Set-Dword $cdm $v 0
}

####################################################
# Explorer Suggestions
####################################################

Set-Dword "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "ShowSyncProviderNotifications" 0

####################################################
# Widgets
####################################################

Set-Dword "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" "AllowNewsAndInterests" 0

####################################################
# Copilot
####################################################

Set-Dword "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" "TurnOffWindowsCopilot" 1

####################################################
# Telemetry
####################################################

Set-Dword "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" "AllowTelemetry" 0

####################################################
# Feedback
####################################################

Set-Dword "HKCU:\Software\Microsoft\Siuf\Rules" "NumberOfSIUFInPeriod" 0

####################################################
# Tailored Experiences
####################################################

Set-Dword "HKCU:\Software\Microsoft\Windows\CurrentVersion\Privacy" "TailoredExperiencesWithDiagnosticDataEnabled" 0

####################################################
# Advertising ID
####################################################

Set-Dword "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" "Enabled" 0

####################################################
# Suggested Apps
####################################################

Set-Dword "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-310093Enabled" 0
Set-Dword "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" "SubscribedContent-338393Enabled" 0

####################################################
# Start Menu Suggestions
####################################################

Set-Dword "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "Start_IrisRecommendations" 0

####################################################
# Restart Explorer
####################################################

Write-Host ""
Write-Host "Explorer yeniden başlatılıyor..." -ForegroundColor Yellow

Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Process explorer.exe

Write-Host ""
Write-Host "İşlem tamamlandı." -ForegroundColor Green
Write-Host ""
Write-Host "Bilgisayarı yeniden başlatman önerilir."
Pause
