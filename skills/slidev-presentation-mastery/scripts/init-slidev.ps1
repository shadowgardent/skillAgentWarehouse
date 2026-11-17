<#
.SYNOPSIS
    Initialize a new Slidev Presentation workspace with recommended themes, folder structure, and Playwright exporter.
.DESCRIPTION
    Creates package.json, standard directories (components, layouts, public, snippets, setup, styles),
    uno.config.ts, global-bottom.vue, and a starter slides.md, then optionally installs dependencies.
.PARAMETER ProjectDir
    Target directory for the Slidev project (defaults to "./presentation").
.PARAMETER InstallPlaywright
    Switch to also install playwright-chromium for PDF/PPTX/PNG exporting.
.PARAMETER SkipInstall
    Switch to only scaffold files without running npm install.
.EXAMPLE
    .\init-slidev.ps1 -ProjectDir ".\docs\architecture-slides" -InstallPlaywright
#>

param(
    [Parameter(Mandatory = $false)]
    [string]$ProjectDir = ".\presentation",

    [Parameter(Mandatory = $false)]
    [switch]$InstallPlaywright,

    [Parameter(Mandatory = $false)]
    [switch]$SkipInstall
)

$ErrorActionPreference = "Stop"

Write-Host "🎬 [Park / Slidev Specialist] Initializing Slidev workspace at: $ProjectDir" -ForegroundColor Cyan

# 1. Create standard directory tree
$ subDirs = @("components", "layouts", "public", "snippets", "setup", "styles", "pages")
foreach ($dir in $subDirs) {
    $fullPath = Join-Path $ProjectDir $dir
    if (-not (Test-Path $fullPath)) {
        New-Item -ItemType Directory -Path $fullPath -Force | Out-Null
    }
}

# 2. Create package.json
$packageJsonPath = Join-Path $ProjectDir "package.json"
$packageJsonContent = @"
{
  "name": "slidev-presentation-deck",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "slidev slides.md --open",
    "build": "slidev build slides.md",
    "export": "slidev export slides.md",
    "export:clicks": "slidev export slides.md --with-clicks",
    "export:pptx": "slidev export slides.md --format pptx",
    "export:png": "slidev export slides.md --format png",
    "format": "slidev format slides.md"
  },
  "dependencies": {
    "@slidev/cli": "^51.0.0",
    "@slidev/theme-default": "latest",
    "@slidev/theme-seriph": "latest",
    "vue": "^3.5.0"
  },
  "devDependencies": {
    "@iconify-json/carbon": "latest",
    "@iconify-json/mdi": "latest",
    "@iconify-json/logos": "latest"
  }
}
"@
Set-Content -Path $packageJsonPath -Value $packageJsonContent -Encoding UTF8

# 3. Create uno.config.ts
$unoConfigPath = Join-Path $ProjectDir "uno.config.ts"
$unoConfigContent = @"
import { defineConfig } from 'unocss'

export default defineConfig({
  shortcuts: {
    'glass-card': 'bg-white/5 dark:bg-slate-900/60 backdrop-blur-md border border-white/10 dark:border-slate-700/60 rounded-2xl shadow-xl p-6',
    'badge-pill': 'inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-mono uppercase tracking-wider bg-sky-500/10 text-sky-400 border border-sky-500/25',
    'text-gradient-sky': 'bg-gradient-to-r from-sky-400 via-cyan-300 to-indigo-400 bg-clip-text text-transparent',
    'stat-value': 'text-5xl font-extrabold tracking-tight text-gradient-sky',
    'stat-label': 'text-xs font-medium uppercase tracking-widest opacity-60 mt-1',
  },
})
"@
Set-Content -Path $unoConfigPath -Value $unoConfigContent -Encoding UTF8

# 4. Create global-bottom.vue
$globalBottomPath = Join-Path $ProjectDir "global-bottom.vue"
$globalBottomContent = @"
<template>
  <footer
    v-if="`$nav.currentLayout !== 'cover' && `$nav.currentLayout !== 'end'"
    class="absolute bottom-0 left-0 right-0 px-8 py-3 flex justify-between items-center text-xs opacity-50 pointer-events-none z-10"
  >
    <div class="font-mono">{{ `$slidev.configs.title }}</div>
    <div class="font-mono">{{ `$nav.currentPage }} / {{ `$nav.total }}</div>
  </footer>
</template>
"@
Set-Content -Path $globalBottomPath -Value $globalBottomContent -Encoding UTF8

# 5. Create starter slides.md if it doesn't exist
$slidesPath = Join-Path $ProjectDir "slides.md"
if (-not (Test-Path $slidesPath)) {
    $slidesContent = @"
---
theme: seriph
title: Slidev Masterclass Presentation
aspectRatio: 16/9
canvasWidth: 980
colorSchema: dark
transition: slide-left
mdc: true
fonts:
  sans: 'Inter, Noto Sans Thai'
  mono: 'JetBrains Mono'
---

<div class="badge-pill mb-4">Slidev Presentation</div>

# Welcome to Slidev
Interactive Markdown Presentations Powered by Vue 3 & Vite

---
layout: two-cols
layoutClass: gap-8
---

# Key Highlights

<v-clicks>

- **Markdown First**: Focus on your storytelling
- **Shiki Magic Move**: Smooth code transitions
- **Vue 3 & UnoCSS**: Glassmorphic cards & components

</v-clicks>

::right::

<div v-click class="glass-card text-center">
  <div class="stat-value">100%</div>
  <div class="stat-label">Developer Happiness</div>
</div>
"@
    Set-Content -Path $slidesPath -Value $slidesContent -Encoding UTF8
}

# 6. Install dependencies unless skipped
if (-not $SkipInstall) {
    Push-Location $ProjectDir
    try {
        Write-Host "📦 Installing Slidev packages..." -ForegroundColor Yellow
        npm install
        if ($InstallPlaywright) {
            Write-Host "🎭 Installing playwright-chromium for PDF/PPTX export..." -ForegroundColor Yellow
            npm install -D playwright-chromium
        }
    }
    finally {
        Pop-Location
    }
}

Write-Host "✅ Slidev project initialized successfully at: $ProjectDir" -ForegroundColor Green
Write-Host "👉 Run 'npm run dev' inside '$ProjectDir' to start presenting!" -ForegroundColor Cyan
