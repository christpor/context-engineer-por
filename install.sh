#!/usr/bin/env bash
# Global installer for Context Engineer Por (Universal Agent Engine)
set -e

SKILL_NAME="context-engineer-por"
SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "============================================="
echo "   Context Engineer Por - Sovereign Installer"
echo "============================================="
echo ""
echo "Installing $SKILL_NAME globally..."

# 1. Symlink sovereign-gate CLI command into ~/.local/bin
mkdir -p "$HOME/.local/bin"
GATE_SCRIPT="$SOURCE_DIR/scripts/sovereign_gate.sh"
chmod +x "$GATE_SCRIPT"
ln -sf "$GATE_SCRIPT" "$HOME/.local/bin/sovereign-gate"
echo "✅ Symlinked sovereign-gate -> $HOME/.local/bin/sovereign-gate"

# 2. Sync skill to all agent runtime directories
TARGET_DIRS=(
    "$HOME/.gemini/config/skills/$SKILL_NAME"
    "$HOME/.claude/skills/$SKILL_NAME"
    "$HOME/.kiro/skills/$SKILL_NAME"
    "$HOME/.opencode/skills/$SKILL_NAME"
    "$HOME/.commandcode/skills/$SKILL_NAME"
    "$HOME/projects/christ-taste/skills/$SKILL_NAME"
)

for target in "${TARGET_DIRS[@]}"; do
    parent_dir="$(dirname "$target")"
    if [ -d "$parent_dir" ]; then
        echo "Syncing to $target..."
        rm -rf "$target"
        cp -r "$SOURCE_DIR" "$target"
    fi
done

echo ""
echo "✅ Successfully installed $SKILL_NAME across all agent runtimes."
echo "You can now run 'sovereign-gate' from ANY repository on this machine!"
