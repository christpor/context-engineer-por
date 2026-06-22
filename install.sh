#!/usr/bin/env bash
# Global installer for Context Engineer Por (Antigravity CLI / Gemini CLI)

set -e

SKILL_NAME="context-engineer-por"
TARGET_DIR="$HOME/.gemini/config/skills/$SKILL_NAME"

echo "============================================="
echo "   Context Engineer Por - Installer"
echo "============================================="
echo ""
echo "Installing $SKILL_NAME globally..."

# Create the global skills directory if it doesn't exist
mkdir -p "$HOME/.gemini/config/skills"

# If it already exists, remove it to update
if [ -d "$TARGET_DIR" ]; then
    echo "Updating existing installation at $TARGET_DIR..."
    rm -rf "$TARGET_DIR"
fi

# Copy the skill into the global directory
cp -r "$(dirname "$0")" "$TARGET_DIR"

echo ""
echo "✅ Successfully installed $SKILL_NAME to $TARGET_DIR"
echo "You can now use this skill in any Antigravity CLI project!"
echo "Just ask the agent: 'Set up my context architecture using context-engineer-por.'"
