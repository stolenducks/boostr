# boostr - minimal zsh configuration
export PATH="$HOME/bin:/opt/homebrew/bin:$PATH"

# Show greeting on new terminal (not on subshells)
if [[ -o interactive ]] && [[ -z "$GREETING_SHOWN" ]]; then
    export GREETING_SHOWN=1
    ~/bin/greeting
fi

# Simple colored prompt: green > or red > (if last command failed)
autoload -U colors && colors
setopt PROMPT_SUBST
PROMPT='%(?.%F{green}.%F{red})>%f '

# AI aliases
alias ai='~/bin/ai'
alias ask='~/bin/ai'
alias doo='~/bin/ai-exec'

# Ghostty helper
ghostty-reload() {
    echo "[~] Reloading Ghostty config..."
    if [ -n "$GHOSTTY_RESOURCES_DIR" ]; then
        printf "\033]0;reload\007"
        echo "[✓] Config reloaded (or use Ctrl+Shift+R)"
    else
        echo "[!] Not running in Ghostty"
    fi
}

ghostty-theme() {
    if [ -z "$1" ]; then
        echo "Usage: ghostty-theme [light|dark]"
        ghostty +list-themes | head -20
        return 1
    fi
    echo "Theme switching via command requires manual config edit for now"
    echo "Current themes in config: Catppuccin Mocha (dark), Catppuccin Latte (light)"
}

# Optional: Load zsh-autosuggestions if available
[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Optional: Load zsh-syntax-highlighting if available (must be last)
[ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
