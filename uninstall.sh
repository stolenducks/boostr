#!/bin/bash
# boostr uninstaller

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RESET='\033[0m'

echo -e "${CYAN}boostr Uninstaller${RESET}"
echo ""
echo -e "${RED}This will remove:${RESET}"
echo "  - Ghostty config (~/.config/ghostty)"
echo "  - AI scripts (~/bin/ai, ~/bin/ai-exec, ~/bin/greeting)"
echo "  - boostr zsh config (from ~/.zshrc)"
echo ""
echo -e "${CYAN}This will NOT remove:${RESET}"
echo "  - Ghostty application"
echo "  - Ollama and LLM models"
echo "  - zsh plugins (autosuggestions, syntax-highlighting)"
echo ""
read -p "Continue? [y/N] " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}[×]${RESET} Cancelled"
    exit 0
fi

echo -e "${CYAN}[>]${RESET} Removing configs..."

# Backup before removal
BACKUP_DIR=~/.boostr-backup-$(date +%Y%m%d-%H%M%S)
mkdir -p "$BACKUP_DIR"

# Backup and remove Ghostty config
if [ -d ~/.config/ghostty ]; then
    cp -r ~/.config/ghostty "$BACKUP_DIR/"
    rm -rf ~/.config/ghostty
    echo -e "${GREEN}[✓]${RESET} Ghostty config removed"
fi

# Backup and remove AI scripts
if [ -f ~/bin/ai ]; then
    cp ~/bin/{ai,ai-exec,greeting} "$BACKUP_DIR/" 2>/dev/null || true
    rm -f ~/bin/ai ~/bin/ai-exec ~/bin/greeting
    echo -e "${GREEN}[✓]${RESET} AI scripts removed"
fi

# Remove boostr section from .zshrc
if [ -f ~/.zshrc ]; then
    cp ~/.zshrc "$BACKUP_DIR/.zshrc"
    # Remove lines between "# boostr" and the end of boostr config
    sed -i.bak '/# boostr - minimal zsh configuration/,/# Optional: Load zsh-syntax-highlighting/d' ~/.zshrc
    rm ~/.zshrc.bak 2>/dev/null || true
    echo -e "${GREEN}[✓]${RESET} zsh config cleaned"
fi

# Remove AI context files
rm -f ~/.ai-conversation-context ~/.ai-context 2>/dev/null || true

echo ""
echo -e "${GREEN}[✓] Uninstall complete!${RESET}"
echo ""
echo -e "${CYAN}Backup saved to:${RESET} $BACKUP_DIR"
echo ""
echo -e "${CYAN}To remove Ghostty and Ollama:${RESET}"
echo "  macOS: brew uninstall --cask ghostty && brew uninstall ollama"
echo "  Linux: Use your package manager (apt/pacman/xbps)"
echo ""
