#!/usr/bin/env bash
# ==============================================================================
# export-slidev.sh — Export Slidev deck to PDF, PPTX, PNG, or Static SPA
# Author: Park (Slidev Specialist)
# Usage:
#   ./export-slidev.sh [slides.md] [--format pdf|pptx|png|spa] [--with-clicks] [--dark] [--output out.pdf] [--timeout 60000]
# ==============================================================================

set -euo pipefail

ENTRY_FILE="slides.md"
FORMAT="pdf"
WITH_CLICKS=false
DARK=false
OUTPUT=""
RANGE=""
TIMEOUT="60000"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --format)
      FORMAT="$2"
      shift 2
      ;;
    --with-clicks|-c)
      WITH_CLICKS=true
      shift
      ;;
    --dark)
      DARK=true
      shift
      ;;
    --output|-o)
      OUTPUT="$2"
      shift 2
      ;;
    --range)
      RANGE="$2"
      shift 2
      ;;
    --timeout)
      TIMEOUT="$2"
      shift 2
      ;;
    *)
      ENTRY_FILE="$1"
      shift
      ;;
  esac
done

if [ ! -f "$ENTRY_FILE" ]; then
  echo "❌ Slidev entry file not found: $ENTRY_FILE" >&2
  exit 1
fi

if [ "$FORMAT" = "spa" ]; then
  CMD=(npx slidev build "$ENTRY_FILE")
  if [ -n "$OUTPUT" ]; then
    CMD+=(--out "$OUTPUT")
  fi
  echo "🌐 [Park / Slidev Specialist] Building Static SPA from ${ENTRY_FILE}..."
  "${CMD[@]}"
  echo "✅ SPA build completed!"
  exit 0
fi

CMD=(npx slidev export "$ENTRY_FILE" --format "$FORMAT" --timeout "$TIMEOUT")

if [ "$WITH_CLICKS" = true ]; then
  CMD+=(--with-clicks)
fi
if [ "$DARK" = true ]; then
  CMD+=(--dark)
fi
if [ -n "$OUTPUT" ]; then
  CMD+=(--output "$OUTPUT")
fi
if [ -n "$RANGE" ]; then
  CMD+=(--range "$RANGE")
fi

echo "🎬 [Park / Slidev Specialist] Exporting '${ENTRY_FILE}' to format '${FORMAT}'..."
"${CMD[@]}"
echo "✅ Export finished successfully!"
