#!/bin/bash

echo "============================================="
echo "      Cyberfox Environment Setup (Linux)"
echo "============================================="

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FOLDER="$SCRIPT_DIR/CyberfoxPortable"
CYBERFOX_URL="https://github.com/sahmsec/cyberfox/releases/download/v1.0/CyberfoxPortable.zip"
CYBERFOX_ZIP="$FOLDER/CyberfoxPortable.zip"
PASSWORD="aws"

# Create workspace
mkdir -p "$FOLDER"
echo "[SUCCESS] Workspace: $FOLDER"

# Install unrar if missing
if ! command -v unrar >/dev/null 2>&1; then
    echo "[STEP] Installing unrar..."
    sudo apt update && sudo apt install -y unrar
fi

# Download Cyberfox
echo "[STEP] Downloading Cyberfox..."
wget -q --show-progress -O "$CYBERFOX_ZIP" "$CYBERFOX_URL"

echo "[SUCCESS] Download completed"

# Extract using UNRAR
echo "[STEP] Extracting Cyberfox (RAR)..."
if unrar x -p"$PASSWORD" "$CYBERFOX_ZIP" "$FOLDER/" >/dev/null 2>&1; then
    echo "[SUCCESS] Extraction complete"
else
    echo "[ERROR] Extraction failed"
    exit 1
fi

# Cleanup
rm -f "$CYBERFOX_ZIP"
echo "[INFO] Deleted ZIP"

# Open folder
xdg-open "$FOLDER" >/dev/null 2>&1 &

# Auto-delete script
(
    sleep 3
    rm -f "$0"
) &

echo "[DONE] Cyberfox is ready!"
