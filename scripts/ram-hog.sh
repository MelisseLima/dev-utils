#!/usr/bin/env bash
# 🐷 ram-hog — show the top processes eating your RAM
set -euo pipefail

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

COUNT="${1:-10}"

echo ""
echo -e "${CYAN}  🐷  R A M   H O G${NC}"
echo -e "${YELLOW}  Top $COUNT memory-hungry processes:${NC}"
echo ""

printf "${GREEN}  %-7s  %-6s  %-6s  %s${NC}\n" "PID" "%MEM" "%CPU" "COMMAND"
echo "  ─────────────────────────────────────────────"

ps aux --sort=-%mem 2>/dev/null | head -n $((COUNT + 1)) | tail -n "$COUNT" | \
  awk '{printf "  %-7s  %-6s  %-6s  %s\n", $2, $4, $3, $11}' 2>/dev/null || \
ps -eo pid,%mem,%cpu,comm -r 2>/dev/null | head -n $((COUNT + 1)) | tail -n "$COUNT" | \
  awk '{printf "  %-7s  %-6s  %-6s  %s\n", $1, $2, $3, $4}'

echo ""
