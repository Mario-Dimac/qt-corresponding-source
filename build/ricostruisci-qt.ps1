# Ricostruisce Qt dalle ricette fissate, senza usare la cache dei pacchetti binari.
param([Parameter(Mandatory)][string]$Destination)
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$destinationPath = [IO.Path]::GetFullPath($Destination)
# Una directory nuova evita di alterare installazioni vcpkg gia presenti.
if (Test-Path -LiteralPath $destinationPath) { throw 'Scegliere una directory di destinazione non esistente.' }
& (Join-Path $PSScriptRoot 'verifica-archivi.ps1')
$cmakeVersion = & cmake --version
if ($LASTEXITCODE -ne 0 -or $cmakeVersion[0] -notmatch '^cmake version 4\.4\.3$') {
    throw 'Mettere CMake 4.4.3 nel PATH prima delle altre versioni.'
}
New-Item -ItemType Directory -Path $destinationPath | Out-Null
& tar -xf (Join-Path $root 'sources/vcpkg-3aea538b2bb21a586502c67b00eb474fdd2e3098.tar.gz') -C $destinationPath
if ($LASTEXITCODE -ne 0) { throw 'Estrazione dello snapshot vcpkg fallita.' }
# Le ricette applicano automaticamente le patch Qt nell'ordine originale.
New-Item -ItemType Directory -Force (Join-Path $destinationPath 'downloads') | Out-Null
Get-ChildItem -LiteralPath (Join-Path $root 'sources') -File |
    Where-Object Name -NotLike 'vcpkg-*' |
    Copy-Item -Destination (Join-Path $destinationPath 'downloads')
& (Join-Path $destinationPath 'bootstrap-vcpkg.bat') -disableMetrics
if ($LASTEXITCODE -ne 0) { throw 'Bootstrap vcpkg fallito.' }
# Sono esattamente le feature registrate nell'ABI della build Qt pubblicata.
& (Join-Path $destinationPath 'vcpkg.exe') install --classic --no-binarycaching `
    'qtbase[core,doubleconversion,gui,widgets,network,jpeg,png,thread]:x64-windows'
if ($LASTEXITCODE -ne 0) { throw 'Compilazione Qt fallita: consultare buildtrees/qtbase.' }
Write-Host "Qt ricostruito in $destinationPath/installed/x64-windows"
