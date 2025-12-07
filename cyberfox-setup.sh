#!/bin/bash

# ============================================================
#  Cyberfox Environment Setup (Linux Version)
# ============================================================

set -e

# -------------------------
# Configuration
# -------------------------
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FOLDER="$SCRIPT_DIR/CyberfoxPortable"
CYBERFOX_URL="https://github.com/sahmsec/cyberfox/releases/download/v1.0/CyberfoxPortable.zip"
CYBERFOX_ZIP="$FOLDER/CyberfoxPortable.zip"
PASSWORD="aws"

# -------------------------
# Header
# -------------------------
echo "============================================="
echo "       Cyberfox Environment Setup (Linux)"
echo "============================================="
echo ""

# -------------------------
# Workspace
# -------------------------
if [ ! -d "$FOLDER" ]; then
    mkdir -p "$FOLDER"
    echo "[SUCCESS] Workspace created: $FOLDER"
else
    echo "[INFO] Workspace already exists: $FOLDER"
fi

# -------------------------
# Check unzip
# -------------------------
if ! command -v unzip >/dev/null 2>&1; then
    echo "[STEP] Installing unzip..."
    sudo apt update && sudo apt install -y unzip
fi

# -------------------------
# Download Cyberfox ZIP
# -------------------------
echo "[STEP] Downloading Cyberfox package..."
wget -q --show-progress -O "$CYBERFOX_ZIP" "$CYBERFOX_URL"

if [ -f "$CYBERFOX_ZIP" ]; then
    echo "[SUCCESS] Cyberfox ZIP downloaded"
else
    echo "[ERROR] Failed to download Cyberfox"
    exit 1
fi

# -------------------------
# Extract ZIP
# -------------------------
echo "[STEP] Extracting Cyberfox..."

# unzip supports password: -P password
if unzip -P "$PASSWORD" "$CYBERFOX_ZIP" -d "$FOLDER" >/dev/null 2>&1; then
    echo "[SUCCESS] Extraction complete"
else
    echo "[ERROR] Extraction failed"
    exit 1
fi

# -------------------------
# Cleanup ZIP
# -------------------------
rm -f "$CYBERFOX_ZIP"
echo "[INFO] Deleted downloaded ZIP"

# -------------------------
# Open folder for user
# -------------------------
if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$FOLDER"
elif command -v open >/dev/null 2>&1; then
    open "$FOLDER"   # for macOS
fi

echo "[DONE] Cyberfox is ready."

# -------------------------
# Auto-delete script itself
# -------------------------
(
    sleep 5
    rm -f "$0"
) &

exit 0
