#!/usr/bin/env bash
set -e

echo -e "\033[0;36m==========================================================\033[0m"
echo -e "\033[0;32m 🏠 Baan Builders Squad (ทีมงานสร้างบ้าน) - Installer\033[0m"
echo -e "\033[0;36m==========================================================\033[0m"

GEMINI_DIR="$HOME/.gemini"
CONFIG_DIR="$GEMINI_DIR/config"
TARGET_AGENTS="$CONFIG_DIR/agents"
TARGET_SKILLS="$CONFIG_DIR/skills"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$CONFIG_DIR"
mkdir -p "$TARGET_AGENTS"
mkdir -p "$TARGET_SKILLS"

echo -e "\n\033[0;33m[1/4] Installing Agents Config...\033[0m"
cp -r "$SCRIPT_DIR/agents/"* "$TARGET_AGENTS/"
echo -e "\033[0;32m  -> Installed squad agents into $TARGET_AGENTS\033[0m"

echo -e "\n\033[0;33m[2/4] Installing Skills (11 Enterprise Skills)...\033[0m"
cp -r "$SCRIPT_DIR/skills/"* "$TARGET_SKILLS/"
echo -e "\033[0;32m  -> Installed 11 enterprise skills into $TARGET_SKILLS\033[0m"

echo -e "\n\033[0;33m[3/4] Installing Global Operational Rules & Learning Base...\033[0m"
cp "$SCRIPT_DIR/rules/GEMINI.md" "$GEMINI_DIR/GEMINI.md"
cp "$SCRIPT_DIR/rules/AGENTS.md" "$CONFIG_DIR/AGENTS.md"
if [ ! -f "$CONFIG_DIR/LESSONS_LEARNED.md" ]; then
    cp "$SCRIPT_DIR/LESSONS_LEARNED.md" "$CONFIG_DIR/LESSONS_LEARNED.md"
fi
echo -e "\033[0;32m  -> Enforced 3 Core Mandatory Rules & Continuous Self-Improvement loop\033[0m"

echo -e "\n\033[0;36m==========================================================\033[0m"
echo -e "\033[0;32m 🎉 Installation Complete! Ready to build with your AI Squad.\033[0m"
echo -e "\033[0;36m==========================================================\033[0m"
