#!/usr/bin/env bash
# ==============================================================================
# init-slidev.sh — Initialize a new Slidev Presentation workspace
# Author: Park (Slidev Specialist)
# Usage: ./init-slidev.sh [project-dir] [--with-playwright] [--skip-install]
# ==============================================================================

set -euo pipefail

PROJECT_DIR="${1:-./presentation}"
INSTALL_PLAYWRIGHT=false
SKIP_INSTALL=false

for arg in "$@"; do
  case "$arg" in
    --with-playwright) INSTALL_PLAYWRIGHT=true ;;
    --skip-install) SKIP_INSTALL=true ;;
  esac
done

echo "🎬 [Park / Slidev Specialist] Initializing Slidev workspace at: ${PROJECT_DIR}"

mkdir -p "${PROJECT_DIR}"/{components,layouts,public,snippets,setup,styles,pages}

cat << 'EOF' > "${PROJECT_DIR}/package.json"
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
EOF

cat << 'EOF' > "${PROJECT_DIR}/uno.config.ts"
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
EOF

cat << 'EOF' > "${PROJECT_DIR}/global-bottom.vue"
<template>
  <footer
    v-if="$nav.currentLayout !== 'cover' && $nav.currentLayout !== 'end'"
    class="absolute bottom-0 left-0 right-0 px-8 py-3 flex justify-between items-center text-xs opacity-50 pointer-events-none z-10"
  >
    <div class="font-mono">{{ $slidev.configs.title }}</div>
    <div class="font-mono">{{ $nav.currentPage }} / {{ $nav.total }}</div>
  </footer>
</template>
EOF

if [ ! -f "${PROJECT_DIR}/slides.md" ]; then
cat << 'EOF' > "${PROJECT_DIR}/slides.md"
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
EOF
fi

if [ "$SKIP_INSTALL" = false ]; then
  (
    cd "${PROJECT_DIR}"
    echo "📦 Installing Slidev packages..."
    npm install
    if [ "$INSTALL_PLAYWRIGHT" = true ]; then
      echo "🎭 Installing playwright-chromium..."
      npm install -D playwright-chromium
    fi
  )
fi

echo "✅ Slidev project initialized successfully at: ${PROJECT_DIR}"
