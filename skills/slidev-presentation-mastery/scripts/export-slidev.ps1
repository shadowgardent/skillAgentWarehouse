<#
.SYNOPSIS
    Export a Slidev presentation to PDF, PPTX, PNG, or build as a Single-Page Application (SPA).
.PARAMETER EntryFile
    Path to the Markdown entry file (defaults to "slides.md").
.PARAMETER Format
    Export target format: "pdf", "pptx", "png", "md", or "spa" (defaults to "pdf").
.PARAMETER Output
    Custom output filename or directory path.
.PARAMETER WithClicks
    Export every v-click step as an individual page/slide.
.PARAMETER Dark
    Force rendering in dark mode.
.PARAMETER Range
    Page ranges to export, e.g. "1,3-5,8".
.PARAMETER Timeout
    Timeout in milliseconds per slide page (defaults to 60000).
.EXAMPLE
    .\export-slidev.ps1 -EntryFile "slides.md" -Format "pdf" -WithClicks -Dark
.EXAMPLE
    .\export-slidev.ps1 -EntryFile "slides.md" -Format "pptx" -Output "executive-deck.pptx"
#>

param(
    [Parameter(Mandatory = $false)]
    [string]$EntryFile = "slides.md",

    [Parameter(Mandatory = $false)]
    [ValidateSet("pdf", "pptx", "png", "md", "spa")]
    [string]$Format = "pdf",

    [Parameter(Mandatory = $false)]
    [string]$Output = "",

    [Parameter(Mandatory = $false)]
    [switch]$WithClicks,

    [Parameter(Mandatory = $false)]
    [switch]$Dark,

    [Parameter(Mandatory = $false)]
    [string]$Range = "",

    [Parameter(Mandatory = $false)]
    [int]$Timeout = 60000
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $EntryFile)) {
    Write-Error "❌ Slidev entry file not found: $EntryFile"
    exit 1
}

if ($Format -eq "spa") {
    $cmdArgs = @("slidev", "build", $EntryFile)
    if ($Output -ne "") {
        $cmdArgs += @("--out", $Output)
    }
    Write-Host "🌐 [Park / Slidev Specialist] Building Static SPA from $EntryFile..." -ForegroundColor Cyan
    & npx @cmdArgs
    Write-Host "✅ SPA build completed!" -ForegroundColor Green
    exit 0
}

$exportArgs = @("slidev", "export", $EntryFile, "--format", $Format, "--timeout", "$Timeout")

if ($WithClicks) {
    $exportArgs += "--with-clicks"
}
if ($Dark) {
    $exportArgs += "--dark"
}
if ($Output -ne "") {
    $exportArgs += @("--output", $Output)
}
if ($Range -ne "") {
    $exportArgs += @("--range", $Range)
}

Write-Host "🎬 [Park / Slidev Specialist] Exporting '$EntryFile' to format '$Format'..." -ForegroundColor Cyan
& npx @exportArgs
Write-Host "✅ Export finished successfully!" -ForegroundColor Green
