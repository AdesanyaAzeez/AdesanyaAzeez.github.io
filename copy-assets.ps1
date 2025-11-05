param(
  [string]$Source = "..\src\assets",
  [string]$Destination = ".\assets"
)

Write-Output "Copying assets from '$Source' to '$Destination'..."

if (-not (Test-Path $Source)) {
  Write-Error "Source path '$Source' not found. Make sure you run this script from the 'static-site' folder inside the repo root.";
  exit 1
}

if (-not (Test-Path $Destination)) {
  New-Item -ItemType Directory -Path $Destination | Out-Null
}

Get-ChildItem -Path $Source -File | ForEach-Object {
  Copy-Item -Path $_.FullName -Destination (Join-Path $Destination $_.Name) -Force
  Write-Output "Copied $($_.Name)"
}

Write-Output "All done. Assets copied to $Destination"
