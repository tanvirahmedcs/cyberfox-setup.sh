#!/bin/bash

echo "====================================="
echo " Cyberfox Environment Setup (Linux)"
echo "====================================="

SCRIPT_DIR="$(pwd)"
FOLDER="$SCRIPT_DIR/CyberfoxPortable"
ZIP_FILE="$FOLDER/CyberfoxPortable.zip"
URL="https://github.com/sahmsec/cyberfox/releases/download/v1.0/CyberfoxPortable.zip"
PASSWORD="aws"

# Create folder
mkdir -p "$FOLDER"
echo "[SUCCESS] Workspace created: $FOLDER"

# Install unrar if missing
if ! command -v unrar >/dev/null; then
    echo "[STEP] Installing unrar..."
    sudo apt update
    sudo apt install -y unrar
fi

# Download file
echo "[STEP] Downloading Cyberfox..."
wget -O "$ZIP_FILE" "$URL"

echo "[SUCCESS] Download completed"

# Extract
echo "[STEP] Extracting Cyberfox..."
unrar x -p"$PASSWORD" "$ZIP_FILE" "$FOLDER/" >/dev/null

if [ $? -eq 0 ]; then
    echo "[SUCCESS] Extraction completed"
else
    echo "[ERROR] Extraction failed"
    exit 1
fi

# Cleanup
rm -f "$ZIP_FILE"
echo "[INFO] ZIP removed"

echo "[DONE] Cyberfox is ready!"
