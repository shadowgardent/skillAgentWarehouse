# Automated Installer for Baan Builders Squad & Skills (Windows PowerShell)
$ErrorActionPreference = "Stop"

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " 🏠 Baan Builders Squad (ทีมงานสร้างบ้าน) - Installer" -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan

$geminiDir = Join-Path $HOME ".gemini"
$configDir = Join-Path $geminiDir "config"
$targetAgents = Join-Path $configDir "agents"
$targetSkills = Join-Path $configDir "skills"
$scriptRoot = $PSScriptRoot

if (-not (Test-Path $configDir)) {
    New-Item -ItemType Directory -Path $configDir -Force | Out-Null
}

Write-Host "`n[1/4] Installing Agents Config..." -ForegroundColor Yellow
if (-not (Test-Path $targetAgents)) { New-Item -ItemType Directory -Path $targetAgents -Force | Out-Null }
Copy-Item -Path "$scriptRoot\agents\*" -Destination $targetAgents -Recurse -Force
Write-Host "  -> Installed agents: บอส (TL), ด็อบบี้ (UX/UI), จิมมี่ (BE), ไมค์ไทสัน (QA), พาร์ค (Slidev)" -ForegroundColor Green

Write-Host "`n[2/4] Installing Skills (11 Enterprise Skills)..." -ForegroundColor Yellow
if (-not (Test-Path $targetSkills)) { New-Item -ItemType Directory -Path $targetSkills -Force | Out-Null }
Copy-Item -Path "$scriptRoot\skills\*" -Destination $targetSkills -Recurse -Force
Write-Host "  -> Installed 11 skills to $targetSkills" -ForegroundColor Green

Write-Host "`n[3/4] Installing Global Operational Rules & Learning Base..." -ForegroundColor Yellow
Copy-Item -Path "$scriptRoot\rules\GEMINI.md" -Destination "$geminiDir\GEMINI.md" -Force
Copy-Item -Path "$scriptRoot\rules\AGENTS.md" -Destination "$configDir\AGENTS.md" -Force
if (-not (Test-Path "$configDir\LESSONS_LEARNED.md")) {
    Copy-Item -Path "$scriptRoot\LESSONS_LEARNED.md" -Destination "$configDir\LESSONS_LEARNED.md" -Force
}
Write-Host "  -> Enforced 3 Core Mandatory Rules & Continuous Self-Improvement loop" -ForegroundColor Green

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host " 🎉 Installation Complete! Ready to build with your AI Squad." -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan
