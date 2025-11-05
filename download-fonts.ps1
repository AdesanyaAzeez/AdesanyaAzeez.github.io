<#
PowerShell helper to download Inter woff2 font files used by the static-site.
This script fetches the Google Fonts CSS for Inter and downloads referenced woff2 files into static-site/fonts.
Run from the static-site folder: `.
un-download-fonts.ps1` or `.
un-download-fonts.ps1 -Clean` to re-download.
#>

param(
  [switch]$Clean
)

$cssUrl = "https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700;800&display=swap"
$fontsDir = Join-Path (Get-Location) 'fonts'

if ($Clean -and (Test-Path $fontsDir)) { Remove-Item $fontsDir -Recurse -Force }
if (-not (Test-Path $fontsDir)) { New-Item -ItemType Directory -Path $fontsDir | Out-Null }

Write-Output "Downloading font CSS..."
$headers = @{ 'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)' }
$css = (Invoke-WebRequest -Uri $cssUrl -Headers $headers -UseBasicParsing).Content

# extract woff2 urls
[regex]$re = "url\((https://[^)]+\.woff2)\)"
$woffUrls = $re.Matches($css) | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique

foreach ($u in $woffUrls) {
  $fname = [IO.Path]::GetFileName($u.Split('?')[0])
  $target = Join-Path $fontsDir $fname
  Write-Output "Downloading $fname..."
  Invoke-WebRequest -Uri $u -OutFile $target -Headers $headers -UseBasicParsing
}

Write-Output "Downloaded fonts to $fontsDir"
Write-Output "Files downloaded (check and rename to the Inter-<weight>.woff2 names expected by styles.css):"
Get-ChildItem -Path $fontsDir -Filter '*.woff2' | ForEach-Object { Write-Output " - $($_.Name)" }

