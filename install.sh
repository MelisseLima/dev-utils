#!/usr/bin/env bash
# 🛠  install.sh — install all scripts from the scripts/ folder
set -euo pipefail

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SCRIPTS_FOLDER="$SCRIPT_DIR/scripts"
SHELL_NAME="$(basename "$SHELL")"

# Determine the right shell config file
if [[ "$SHELL_NAME" == "zsh" ]]; then
  SHELL_RC="$HOME/.zshrc"
elif [[ "$SHELL_NAME" == "bash" ]]; then
  # macOS uses .bash_profile for login shells
  if [[ "$(uname)" == "Darwin" ]]; then
    SHELL_RC="$HOME/.bash_profile"
  else
    SHELL_RC="$HOME/.bashrc"
  fi
else
  SHELL_RC="$HOME/.profile"
fi

PATH_LINE="export PATH=\"$SCRIPTS_FOLDER:\$PATH\""
MARKER="# devutils"

echo ""
echo -e "${CYAN}  🛠  D E V U T I L S   I N S T A L L E R${NC}"
echo ""

# --- Make all scripts executable ---
script_count=0
for script in "$SCRIPTS_FOLDER"/*; do
  [[ -f "$script" ]] || continue
  chmod +x "$script"
  script_count=$((script_count + 1))
  echo -e "${GREEN}  ✓ $(basename "$script")${NC}"
done

if [[ "$script_count" -eq 0 ]]; then
  echo -e "${RED}  ✗ No scripts found in $SCRIPTS_FOLDER${NC}"
  exit 1
fi

echo ""
echo -e "${YELLOW}  Found $script_count script(s) to install.${NC}"
echo ""

# --- Add scripts folder to PATH in shell config ---
if grep -qF "$MARKER" "$SHELL_RC" 2>/dev/null; then
  echo -e "${YELLOW}  ⚠ PATH entry already exists in $SHELL_RC — skipping.${NC}"
else
  {
    echo ""
    echo "$MARKER"
    echo "$PATH_LINE"
  } >> "$SHELL_RC"
  echo -e "${GREEN}  ✓ Added scripts to PATH in $SHELL_RC${NC}"
fi

echo ""
echo -e "${CYAN}  ✅  Installation complete!${NC}"
echo ""
echo -e "  Run ${GREEN}source $SHELL_RC${NC} or open a new terminal to start using your scripts."
echo ""
echo -e "  Available commands:"
for script in "$SCRIPTS_FOLDER"/*; do
  [[ -f "$script" ]] || continue
  echo -e "    ${GREEN}$(basename "$script")${NC}"
done
echo ""
