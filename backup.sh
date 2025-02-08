#!/bin/zsh

# Define source and destination directories
SRC="$HOME/.config/"
DEST="$HOME/files/dotfiles/config"

# Ensure destination exists
mkdir -p "$DEST"

# Rsync options:
# -a : Archive mode (preserves permissions, symlinks, timestamps)
# -v : Verbose output
# -h : Human-readable sizes
# --progress : Show progress
# --delete : Remove files in destination that no longer exist in source
# --exclude : Exclude cache, temp, and git files

rsync -avh --progress --delete \
    --exclude "*.cache" \
    --exclude ".git" \
    --exclude ".DS_Store" \
    --exclude "Cache/" \
    "$SRC" "$DEST"

# Print completion message
echo "✅ Sync complete: $SRC → $DEST"