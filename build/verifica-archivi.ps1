# Verifica tutti gli archivi prima di usarli per la ricostruzione.
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
foreach ($line in Get-Content -LiteralPath (Join-Path $root 'SHA256SUMS.txt')) {
    if ($line -notmatch '^([0-9a-f]{64})  (.+)$') { throw "Riga hash non valida: $line" }
    $expected = $Matches[1]
    $relative = $Matches[2]
    $actual = (Get-FileHash -LiteralPath (Join-Path $root $relative) -Algorithm SHA256).Hash.ToLowerInvariant()
    if ($actual -ne $expected) { throw "Hash SHA256 differente: $relative" }
}
Write-Host 'Integrita degli archivi verificata.'
