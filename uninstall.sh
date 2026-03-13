#!/usr/bin/env bash
# 🗑  uninstall.sh — remove DevUtils from your PATH
set -euo pipefail

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

SHELL_NAME="$(basename "$SHELL")"

# Determine the right shell config file
if [[ "$SHELL_NAME" == "zsh" ]]; then
  SHELL_RC="$HOME/.zshrc"
elif [[ "$SHELL_NAME" == "bash" ]]; then
  if [[ "$(uname)" == "Darwin" ]]; then
    SHELL_RC="$HOME/.bash_profile"
  else
    SHELL_RC="$HOME/.bashrc"
  fi
else
  SHELL_RC="$HOME/.profile"
fi

MARKER="# devutils"

echo ""
echo -e "${CYAN}  🗑  D E V U T I L S   U N I N S T A L L E R${NC}"
echo ""

# --- Remove PATH entry from shell config ---
if grep -qF "$MARKER" "$SHELL_RC" 2>/dev/null; then
  # Remove the marker line and the export PATH line that follows it, plus any blank line before
  # Create a temp file to avoid sed in-place quirks across macOS/Linux
  tmp_file=$(mktemp)
  awk -v marker="$MARKER" '
    # Skip blank line immediately before the marker
    prev == "" && $0 == marker { skip_next = 1; prev = ""; next }
    # Skip the export PATH line after the marker
    skip_next { skip_next = 0; next }
    # Print previous buffered line
    prev != "" { print prev }
    { prev = $0 }
    END { if (prev != "" && prev != marker) print prev }
  ' "$SHELL_RC" > "$tmp_file"

  mv "$tmp_file" "$SHELL_RC"
  echo -e "${GREEN}  ✓ Removed DevUtils from PATH in $SHELL_RC${NC}"
else
  echo -e "${YELLOW}  ⚠ No DevUtils entry found in $SHELL_RC — nothing to remove.${NC}"
fi

echo ""
echo -e "${CYAN}  ✅  Uninstall complete!${NC}"
echo ""
echo -e "  Run ${GREEN}source $SHELL_RC${NC} or open a new terminal to apply changes."
echo -e "  You can also delete this folder if you no longer need the scripts."
echo ""
